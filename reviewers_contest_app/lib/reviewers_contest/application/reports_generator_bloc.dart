import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import 'package:reviewers_contest_app/reviewers_contest/domain/i_report_generator.dart';
import 'package:reviewers_contest_app/reviewers_contest/domain/pull_request.dart';
import 'package:reviewers_contest_app/reviewers_contest/domain/reviewer.dart';

part 'reports_generator_event.dart';
part 'reports_generator_state.dart';

@injectable
class ReportsGeneratorBloc
    extends Bloc<ReportsGeneratorEvent, ReportsGeneratorState> {
  final IReportGenerator generator;

  ReportsGeneratorBloc(this.generator) : super(ReportsGeneratorInitial()) {
    on<GenerateRaports>((event, emit) {
      emit(Generating());

      final prReport = generator.generatePullRequestsReport(event.pullRequests);
      final prReportUrl =
          Url.createObjectUrlFromBlob(Blob([prReport.content], "text/csv"));

      final reviewersReport =
          generator.generateReviewersReport(event.reviewers);
      final reviewerReportUrl = Url.createObjectUrlFromBlob(
          Blob([reviewersReport.content], "text/csv"));

      emit(Generated(prReportUrl, reviewerReportUrl));
    });
  }
}
