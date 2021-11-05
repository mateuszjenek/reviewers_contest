part of 'configuration_bloc.dart';

@immutable
class ConfigurationState {
  final DateTime startDate;
  final DateTime endDate;
  final String? repository;

  const ConfigurationState(this.startDate, this.endDate, this.repository);
}
