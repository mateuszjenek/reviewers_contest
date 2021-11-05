import 'package:dartz/dartz.dart';

import 'authentication_code.dart';
import 'github_sso_failure.dart';

abstract class IGithubSSO {
  Future<Either<GithubSSOFailure, AuthenticationCode>> getAuthentiactionCode();
}
