import 'package:dartz/dartz.dart';

import 'package:reviewers_contest_app/configuration/domain/repository.dart';
import 'package:reviewers_contest_app/configuration/domain/repository_repository_failure.dart';

abstract class IRepositoryRepository {
  Future<Either<RepositoryRepositoryFailure, List<Repository>>>
      getAllRepositories(String token);
}
