import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:reviewers_contest_app/configuration/application/configuration_bloc.dart';

class ConfigurationTimePeriod extends StatelessWidget {
  const ConfigurationTimePeriod({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigurationBloc, ConfigurationState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Choose a time period",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            ListTile(
              leading: const Icon(Icons.arrow_forward),
              subtitle: const Text("start date"),
              title: Text(DateFormat("dd-MM-yyyy").format(state.startDate)),
            ),
            ListTile(
              leading: const Icon(Icons.arrow_downward),
              subtitle: const Text("end date"),
              title: Text(DateFormat("dd-MM-yyyy").format(state.endDate)),
            ),
          ],
        );
      },
    );
  }
}
