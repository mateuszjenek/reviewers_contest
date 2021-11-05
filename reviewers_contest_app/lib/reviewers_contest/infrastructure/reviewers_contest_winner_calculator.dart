import 'package:injectable/injectable.dart';

import 'package:reviewers_contest_app/reviewers_contest/domain/i_reviewers_contest_winner_calculator.dart';
import 'package:reviewers_contest_app/reviewers_contest/domain/pull_request.dart';
import 'package:reviewers_contest_app/reviewers_contest/domain/reviewer.dart';

@Injectable(as: IReviewersContestWinnerCalculator)
class ReviewersContestWinnerCalculator
    implements IReviewersContestWinnerCalculator {
  @override
  List<Reviewer> calculateWinners(List<Reviewer> reviewers) {
    reviewers.sort((a, b) => a.numberOfPRs.compareTo(b.numberOfPRs));
    var winners = <Reviewer>[];
    for (var reviewer in reviewers.reversed) {
      if (reviewer.numberOfPRs >= 3 &&
          (winners.isEmpty ||
              winners.first.numberOfPRs == reviewer.numberOfPRs)) {
        winners.add(reviewer);
      }
    }
    return winners;
  }

  @override
  List<Reviewer> getAllReviewers(List<PullRequest> pullRequests) {
    var reviewers = <String, int>{};
    pullRequests.expand((pullRequest) => pullRequest.reviewers).forEach(
      (reviewer) {
        var value = reviewers[reviewer] ?? 0;
        reviewers[reviewer] = value + 1;
      },
    );
    var result = <Reviewer>[];
    reviewers.forEach(
      (name, numberOfPRs) => result.add(Reviewer(name, numberOfPRs)),
    );
    result.sort((a, b) => a.numberOfPRs.compareTo(b.numberOfPRs));
    return result.reversed.toList();
  }
}
