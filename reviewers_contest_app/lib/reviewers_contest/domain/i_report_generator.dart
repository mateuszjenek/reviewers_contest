import 'package:reviewers_contest_app/reviewers_contest/domain/pull_request.dart';
import 'package:reviewers_contest_app/reviewers_contest/domain/report.dart';
import 'package:reviewers_contest_app/reviewers_contest/domain/reviewer.dart';

abstract class IReportGenerator {
  Report generateReviewersReport(Iterable<Reviewer> reviewers);
  Report generatePullRequestsReport(Iterable<PullRequest> pullRequests);
}
