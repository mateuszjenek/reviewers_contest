import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:reviewers_contest_app/reviewers_contest/domain/i_pull_request_repository.dart';
import 'package:reviewers_contest_app/reviewers_contest/domain/pull_request.dart';
import 'package:reviewers_contest_app/reviewers_contest/domain/pull_request_repository_failure.dart';

@prod
@Injectable(as: IPullRequestRepository)
class PullRequestRepository implements IPullRequestRepository {
  @override
  Future<Either<PullRequestRepositoryFailure, List<PullRequest>>>
      getPullRequests(
    String token,
    String repository,
    DateTime from,
    DateTime to,
  ) async {
    try {
      final pullRequestsUrl = Uri.parse(
          "https://api.github.com/search/issues?q=is:pr+repo:$repository+updated:${DateFormat("yyyy-MM-dd").format(from)}..${DateFormat("yyyy-MM-dd").format(to)}");
      final response = await http.get(pullRequestsUrl, headers: {
        "Accept": "application/vnd.github.v3+json",
        "Authorization": "token $token",
      });
      final List<dynamic> pullRequests = json.decode(response.body)["items"];

      final result = await Future.wait(
        pullRequests.map((pullRequest) async {
          final int pullRequestId = pullRequest["number"];
          final reviewersUrl = Uri.parse(
              "https://api.github.com/repos/$repository/pulls/$pullRequestId/reviews");
          final response = await http.get(reviewersUrl, headers: {
            "Accept": "application/vnd.github.v3+json",
            "Authorization": "token $token"
          });
          final List<dynamic> reviews = json.decode(response.body);
          final List<String> reviewers = reviews
              .map((review) => review["user"]["login"] as String)
              .toList();

          return PullRequest(
            pullRequest["title"],
            pullRequest["user"]["login"],
            reviewers,
          );
        }),
      );

      return right(result);
    } catch (_) {
      return left(UnknownFailure());
    }
  }
}
