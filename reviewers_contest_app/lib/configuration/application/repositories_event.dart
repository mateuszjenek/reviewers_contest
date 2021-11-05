part of 'repositories_bloc.dart';

@immutable
abstract class RepositoriesEvent {}

class FetchRepositories extends RepositoriesEvent {
  final String token;

  FetchRepositories(this.token);
}
