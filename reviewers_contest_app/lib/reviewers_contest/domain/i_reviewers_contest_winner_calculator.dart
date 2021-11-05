import 'package:reviewers_contest_app/reviewers_contest/domain/pull_request.dart';
import 'package:reviewers_contest_app/reviewers_contest/domain/reviewer.dart';

abstract class IReviewersContestWinnerCalculator {
  List<Reviewer> getAllReviewers(List<PullRequest> pullRequests);
  List<Reviewer> calculateWinners(List<Reviewer> reviewers);
}
