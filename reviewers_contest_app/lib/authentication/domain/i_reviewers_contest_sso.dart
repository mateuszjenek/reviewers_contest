import 'package:dartz/dartz.dart';

import 'access_token.dart';
import 'authentication_code.dart';
import 'reviewers_contest_sso_failure.dart';

abstract class IReviewersContestSSO {
  Future<Either<ReviewersContestSSOFailure, AccessToken>>
      getAuthenticationToken(AuthenticationCode code);
}
