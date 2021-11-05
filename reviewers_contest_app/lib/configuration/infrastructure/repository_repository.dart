import 'package:dartz/dartz.dart';
import 'package:github/github.dart';
import 'package:injectable/injectable.dart';

import 'package:reviewers_contest_app/configuration/domain/i_repository_repository.dart';
import 'package:reviewers_contest_app/configuration/domain/repository.dart'
    as model;
import 'package:reviewers_contest_app/configuration/domain/repository_repository_failure.dart';

@prod
@Injectable(as: IRepositoryRepository)
class RepositoryRepository implements IRepositoryRepository {
  @override
  Future<Either<RepositoryRepositoryFailure, List<model.Repository>>>
      getAllRepositories(String token) async {
    final github = GitHub(auth: Authentication.withToken(token));
    final repos = await github.repositories.listRepositories().toList();
    final result =
        repos.map((repo) => model.Repository(repo.fullName)).toList();
    return right(result);
  }
}
