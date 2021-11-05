part of 'configuration_bloc.dart';

@immutable
abstract class ConfigurationEvent {}

class TimePeriodChanged extends ConfigurationEvent {
  final DateTime startDate;
  final DateTime endDate;

  TimePeriodChanged(this.startDate, this.endDate);
}

class RepositoryChanged extends ConfigurationEvent {
  final String? repository;

  RepositoryChanged(this.repository);
}
