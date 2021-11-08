part of 'reports_generator_bloc.dart';

@immutable
abstract class ReportsGeneratorState {}

class ReportsGeneratorInitial extends ReportsGeneratorState {}

class Generating extends ReportsGeneratorState {}

class Generated extends ReportsGeneratorState {
  final String prReportUrl;
  final String reviewerReportUrl;

  Generated(this.prReportUrl, this.reviewerReportUrl);
}

class Failed extends ReportsGeneratorState {}
