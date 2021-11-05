import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:reviewers_contest_app/configuration/application/configuration_bloc.dart';
import 'package:reviewers_contest_app/configuration/application/repositories_bloc.dart';
import 'package:reviewers_contest_app/reviewers_contest/presentation/reviewers_contest_page.dart';

import 'calendar.dart';
import 'configuration_repository.dart';
import 'configuration_time_period.dart';

class ConfigurationPage extends StatelessWidget {
  final String authToken;
  const ConfigurationPage(this.authToken, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RepositoriesBloc>(
          create: (_) => GetIt.instance.get<RepositoriesBloc>()
            ..add(FetchRepositories(authToken)),
        ),
        BlocProvider<ConfigurationBloc>(
          create: (_) => GetIt.instance.get<ConfigurationBloc>(),
        )
      ],
      child: BlocBuilder<RepositoriesBloc, RepositoriesState>(
        builder: (context, state) {
          if (state is RepositoriesLoaded) {
            return Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  if (context.read<ConfigurationBloc>().state.repository !=
                      null) {
                    SchedulerBinding.instance!.addPostFrameCallback((_) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ReviewersContestPage(
                              authToken,
                              context
                                  .read<ConfigurationBloc>()
                                  .state
                                  .repository!,
                              context.read<ConfigurationBloc>().state.startDate,
                              context.read<ConfigurationBloc>().state.endDate,
                            ),
                          ));
                    });
                  }
                },
                icon: const Icon(Icons.query_stats),
                label: const Text("Show statistics"),
              ),
              body: Flex(
                direction: Axis.horizontal,
                children: [
                  const Flexible(
                    flex: 1,
                    child: Calendar(),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      color: Theme.of(context).cardColor,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Configuration",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            const SizedBox(height: 32),
                            const ConfigurationTimePeriod(),
                            const SizedBox(height: 32),
                            ConfigurationRepository(state.repositories),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
