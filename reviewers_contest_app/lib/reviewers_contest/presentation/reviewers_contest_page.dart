import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:reviewers_contest_app/reviewers_contest/application/reports_generator_bloc.dart';
import 'package:reviewers_contest_app/reviewers_contest/application/reviewers_contest_bloc.dart';
import 'package:reviewers_contest_app/reviewers_contest/presentation/app_bar_actions.dart';
import 'package:reviewers_contest_app/reviewers_contest/presentation/reviewers_details.dart';
import 'package:reviewers_contest_app/reviewers_contest/presentation/winners_info.dart';

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
          actions: const [AppBarActions()],
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
                                  Scaffold.of(context).appBarMaxHeight! -
                                  32,
                              child: WinnersInfo(state),
                            ),
                            ReviewersDetails(state),
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
