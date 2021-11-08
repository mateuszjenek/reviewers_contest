import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:reviewers_contest_app/reviewers_contest/application/reports_generator_bloc.dart';
import 'package:reviewers_contest_app/reviewers_contest/application/reviewers_contest_bloc.dart';

class AppBarActions extends StatelessWidget {
  const AppBarActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
    return BlocBuilder<ReviewersContestBloc, ReviewersContestState>(
      builder: (context, reviewersState) {
        if (reviewersState is Loaded) {
          return BlocBuilder<ReportsGeneratorBloc, ReportsGeneratorState>(
            builder: (context, reportsState) {
              if (reportsState is ReportsGeneratorInitial) {
                return TextButton(
                  style: style,
                  onPressed: () {
                    context.read<ReportsGeneratorBloc>().add(GenerateRaports(
                          reviewersState.pullRequests,
                          reviewersState.reviewers,
                        ));
                  },
                  child: const Text('Generate reports'),
                );
              } else if (reportsState is Generated) {
                return Row(
                  children: [
                    IconButton(
                      tooltip: "Pull requests report",
                      onPressed: () {
                        window.location.href = reportsState.prReportUrl;
                      },
                      icon: const Icon(Icons.file_download),
                    ),
                    IconButton(
                      tooltip: "Reviewers report",
                      onPressed: () {
                        window.location.href = reportsState.reviewerReportUrl;
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
          return const IconButton(onPressed: null, icon: Icon(Icons.refresh));
        }
      },
    );
  }
}
