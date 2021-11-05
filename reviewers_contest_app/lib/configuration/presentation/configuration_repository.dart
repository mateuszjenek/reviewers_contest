import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:reviewers_contest_app/configuration/application/configuration_bloc.dart';
import 'package:reviewers_contest_app/configuration/domain/repository.dart';

class ConfigurationRepository extends StatelessWidget {
  final List<Repository> repositories;

  const ConfigurationRepository(
    this.repositories, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose a repository",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        BlocBuilder<ConfigurationBloc, ConfigurationState>(
          builder: (context, state) {
            return DropdownButton<String>(
              value: state.repository,
              onChanged: (repository) => context
                  .read<ConfigurationBloc>()
                  .add(RepositoryChanged(repository)),
              items: repositories
                  .map((repository) => DropdownMenuItem(
                        value: repository.name,
                        child: Text(repository.name),
                      ))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
