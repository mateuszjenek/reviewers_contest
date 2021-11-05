part of 'reviewers_contest_bloc.dart';

@immutable
abstract class ReviewersContestEvent {}

class GetReviewersContestWinner extends ReviewersContestEvent {
  final String token;
  final DateTime from;
  final DateTime to;
  final String repository;

  GetReviewersContestWinner(this.token, this.from, this.to, this.repository);
}
