import 'package:injectable/injectable.dart';

import 'package:reviewers_contest_app/reviewers_contest/domain/i_report_generator.dart';
import 'package:reviewers_contest_app/reviewers_contest/domain/reviewer.dart';
import 'package:reviewers_contest_app/reviewers_contest/domain/report.dart';
import 'package:reviewers_contest_app/reviewers_contest/domain/pull_request.dart';

@prod
@Injectable(as: IReportGenerator)
class ReportGenerator implements IReportGenerator {
  @override
  Report generatePullRequestsReport(Iterable<PullRequest> pullRequests) {
    var content = pullRequests.map((pullRequest) {
      final reviewers = pullRequest.reviewers.join(" ");
      return "${pullRequest.title},$reviewers";
    }).join("\n");
    content = "Pull request title,Reviewers\n" + content;
    return Report("pr-report.csv", content);
  }

  @override
  Report generateReviewersReport(Iterable<Reviewer> reviewers) {
    var content = reviewers
        .map((reviewer) => "${reviewer.name},${reviewer.numberOfPRs}")
        .join("\n");
    content = "Reviewer name,Number of PRs\n" + content;
    return Report("reviewers-report.csv", content);
  }
}
