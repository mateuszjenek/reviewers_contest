part of 'repositories_bloc.dart';

@immutable
abstract class RepositoriesState {}

class RepositoriesInitial extends RepositoriesState {}

class RepositoriesLoading extends RepositoriesState {}

class RepositoriesLoaded extends RepositoriesState {
  final List<Repository> repositories;

  RepositoriesLoaded(this.repositories);
}

class RepositoriesLoadingFailure extends RepositoriesState {
  final RepositoryRepositoryFailure failure;

  RepositoriesLoadingFailure(this.failure);
}
