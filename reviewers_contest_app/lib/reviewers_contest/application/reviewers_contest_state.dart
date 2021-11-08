part of 'reviewers_contest_bloc.dart';

@immutable
abstract class ReviewersContestState {}

class ReviewersContestInitial extends ReviewersContestState {}

class Loading extends ReviewersContestState {}

class LoadingFailed extends ReviewersContestState {}

class Loaded extends ReviewersContestState {
  final List<Reviewer> winners;
  final List<Reviewer> reviewers;
  final Iterable<PullRequest> pullRequests;

  Loaded(this.winners, this.reviewers, this.pullRequests);
}
