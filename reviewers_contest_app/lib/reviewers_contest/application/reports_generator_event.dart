part of 'reports_generator_bloc.dart';

@immutable
abstract class ReportsGeneratorEvent {}

class GenerateRaports extends ReportsGeneratorEvent {
  final Iterable<PullRequest> pullRequests;
  final Iterable<Reviewer> reviewers;

  GenerateRaports(this.pullRequests, this.reviewers);
}
