part of 'reviewers_contest_bloc.dart';

@immutable
abstract class ReviewersContestState {}

class Initial extends ReviewersContestState {}

class Loading extends ReviewersContestState {}

class LoadingFailed extends ReviewersContestState {}

class Loaded extends ReviewersContestState {
  final List<Reviewer> winners;
  final List<Reviewer> reviewers;

  Loaded(this.winners, this.reviewers);
}
