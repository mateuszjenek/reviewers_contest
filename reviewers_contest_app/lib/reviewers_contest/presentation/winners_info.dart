import 'package:flutter/material.dart';

import 'package:reviewers_contest_app/reviewers_contest/application/reviewers_contest_bloc.dart';

class WinnersInfo extends StatelessWidget {
  final Loaded state;
  const WinnersInfo(
    this.state, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = "There are no winners";
    String winners = "";
    if (state.winners.length == 1) {
      title = "Pull Request contest winner is:";
      winners = state.winners[0].name;
    } else if (state.winners.length > 1) {
      title = "Pull Request contest winners are:";
      winners = state.winners.map((e) => e.name).join(" & ");
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: Theme.of(context).textTheme.headline5),
        Text(winners, style: Theme.of(context).textTheme.headline4),
      ],
    );
  }
}
