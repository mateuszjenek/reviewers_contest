import 'package:dartz/dartz.dart';

import 'package:reviewers_contest_app/reviewers_contest/domain/pull_request.dart';
import 'package:reviewers_contest_app/reviewers_contest/domain/pull_request_repository_failure.dart';

abstract class IPullRequestRepository {
  Future<Either<PullRequestRepositoryFailure, List<PullRequest>>>
      getPullRequests(
          String token, String repository, DateTime from, DateTime to);
}
