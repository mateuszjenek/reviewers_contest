import 'package:dartz/dartz.dart';
import 'package:github/github.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'dart:convert';

import 'package:reviewers_contest_app/reviewers_contest/domain/i_pull_request_repository.dart';
import 'package:reviewers_contest_app/reviewers_contest/domain/pull_request.dart'
    as model;
import 'package:reviewers_contest_app/reviewers_contest/domain/pull_request_repository_failure.dart';

@prod
@Injectable(as: IPullRequestRepository)
class PullRequestRepository implements IPullRequestRepository {
  @override
  Future<Either<PullRequestRepositoryFailure, List<model.PullRequest>>>
      getPullRequests(
          String token, String repository, DateTime from, DateTime to) async {
    final github = GitHub(auth: Authentication.withToken(token));
    final prs = await github.pullRequests
        .list(RepositorySlug.full(repository))
        .toList();

    var reviewss = <String, List<String>>{};
    await Future.wait(prs.map((pr) async {
      final url = Uri.parse(
          "https://api.github.com/repos/$repository/pulls/${pr.number}/reviews");
      final response = await http.get(url, headers: {
        "Accept": "application/vnd.github.v3+json",
        "Authorization": "token $token"
      });
      final List<dynamic> reviews = json.decode(response.body);
      final List<String> reviewers =
          reviews.map((review) => review["user"]["login"] as String).toList();
      reviewss[pr.title ?? "unknown title"] = reviewers;
    }));

    var result = <model.PullRequest>[];

    reviewss.forEach(
      (title, reviewers) =>
          result.add(model.PullRequest(title, "unknown", reviewers)),
    );
    return right(result);
  }
}
