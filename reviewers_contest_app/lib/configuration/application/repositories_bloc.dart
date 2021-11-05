import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import 'package:reviewers_contest_app/configuration/domain/i_repository_repository.dart';
import 'package:reviewers_contest_app/configuration/domain/repository.dart';
import 'package:reviewers_contest_app/configuration/domain/repository_repository_failure.dart';

part 'repositories_event.dart';
part 'repositories_state.dart';

@injectable
class RepositoriesBloc extends Bloc<RepositoriesEvent, RepositoriesState> {
  final IRepositoryRepository repository;

  RepositoriesBloc(this.repository) : super(RepositoriesInitial()) {
    on<FetchRepositories>((event, emit) async {
      emit(RepositoriesLoading());
      var result = await repository.getAllRepositories(event.token);
      result.fold(
        (failure) => emit(RepositoriesLoadingFailure(failure)),
        (repositories) => emit(RepositoriesLoaded(repositories)),
      );
    });
  }
}
