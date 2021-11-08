import 'dart:html';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:reviewers_contest_app/reviewers_contest/application/reports_generator_bloc.dart';
import 'package:reviewers_contest_app/reviewers_contest/application/reviewers_contest_bloc.dart';

class ReviewersContestPage extends StatelessWidget {
  final String token;
  final String repository;
  final DateTime startDate;
  final DateTime endDate;

  const ReviewersContestPage(
      this.token, this.repository, this.startDate, this.endDate,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.instance.get<ReviewersContestBloc>()
            ..add(GetReviewersContestWinner(
                token, startDate, endDate, repository)),
        ),
        BlocProvider(
          create: (context) => GetIt.instance.get<ReportsGeneratorBloc>(),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          actions: [
            BlocBuilder<ReviewersContestBloc, ReviewersContestState>(
              builder: (context, reviewersState) {
                if (reviewersState is Loaded) {
                  return BlocBuilder<ReportsGeneratorBloc,
                      ReportsGeneratorState>(
                    builder: (context, reportsState) {
                      if (reportsState is ReportsGeneratorInitial) {
                        return IconButton(
                          onPressed: () {
                            context
                                .read<ReportsGeneratorBloc>()
                                .add(GenerateRaports(
                                  reviewersState.pullRequests,
                                  reviewersState.reviewers,
                                ));
                          },
                          tooltip: "Generate",
                          icon: const Icon(Icons.document_scanner),
                        );
                      } else if (reportsState is Generated) {
                        return Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                window.location.href = reportsState.prReportUrl;
                              },
                              icon: const Icon(Icons.file_download),
                            ),
                            IconButton(
                              onPressed: () {
                                window.location.href =
                                    reportsState.reviewerReportUrl;
                              },
                              icon: const Icon(Icons.file_download),
                            ),
                          ],
                        );
                      } else {
                        return const IconButton(
                            onPressed: null, icon: Icon(Icons.refresh));
                      }
                    },
                  );
                } else {
                  return const IconButton(
                      onPressed: null, icon: Icon(Icons.refresh));
                }
              },
            ),
          ],
        ),
        body: BlocBuilder<ReviewersContestBloc, ReviewersContestState>(
          builder: (context, state) {
            if (state is Loaded) {
              return Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ConfettiWidget(
                      confettiController: ConfettiController(
                          duration: const Duration(seconds: 3))
                        ..play(),
                      blastDirectionality: BlastDirectionality.explosive,
                    ),
                  ),
                  Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height -
                                  Scaffold.of(context).appBarMaxHeight!,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Pull Request contest winners are:",
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                  Text(
                                    state.winners
                                        .map((e) => e.name)
                                        .join(" & "),
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  const SizedBox(height: 64),
                                  Text(
                                    "More details",
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  const Icon(Icons.keyboard_arrow_down),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 32.0,
                                    right: 32.0,
                                    top: 8.0,
                                  ),
                                  child: Table(
                                    border: TableBorder.all(),
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    children: [
                                      const TableRow(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text("Reviewer"),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text("Number of PRs"),
                                          )
                                        ],
                                      ),
                                      ...state.reviewers
                                          .map((e) => TableRow(children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(e.name),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      e.numberOfPRs.toString()),
                                                )
                                              ]))
                                          .toList()
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
