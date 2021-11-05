import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import 'package:reviewers_contest_app/reviewers_contest/domain/i_pull_request_repository.dart';
import 'package:reviewers_contest_app/reviewers_contest/domain/i_reviewers_contest_winner_calculator.dart';
import 'package:reviewers_contest_app/reviewers_contest/domain/reviewer.dart';

part 'reviewers_contest_event.dart';
part 'reviewers_contest_state.dart';

@injectable
class ReviewersContestBloc
    extends Bloc<ReviewersContestEvent, ReviewersContestState> {
  final IPullRequestRepository pullRequestRepository;
  final IReviewersContestWinnerCalculator contestCalculator;

  ReviewersContestBloc(this.pullRequestRepository, this.contestCalculator)
      : super(Initial()) {
    on<GetReviewersContestWinner>((event, emit) async {
      emit(Loading());
      var getPullRequestsRequest = await pullRequestRepository.getPullRequests(
        event.token,
        event.repository,
        event.from,
        event.to,
      );
      getPullRequestsRequest.fold(
        (failure) => emit(LoadingFailed()),
        (pullRequests) {
          final reviewers = contestCalculator.getAllReviewers(pullRequests);
          final winners = contestCalculator.calculateWinners(reviewers);
          emit(Loaded(winners, reviewers));
        },
      );
    });
  }
}
