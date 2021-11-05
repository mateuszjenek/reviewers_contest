import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

import 'package:reviewers_contest_app/authentication/domain/access_token.dart';
import 'package:reviewers_contest_app/authentication/domain/authentication_code.dart';
import 'package:reviewers_contest_app/authentication/domain/reviewers_contest_sso_failure.dart';
import 'package:reviewers_contest_app/authentication/domain/i_reviewers_contest_sso.dart';

@prod
@Injectable(as: IReviewersContestSSO)
class GithubStatsSSO implements IReviewersContestSSO {
  @override
  Future<Either<ReviewersContestSSOFailure, AccessToken>>
      getAuthenticationToken(AuthenticationCode code) async {
    try {
      final result = await post(
        Uri.parse(
          const String.fromEnvironment("REVIEWERS_CONTEST_SSO_TOKEN_ENDPOINT"),
        ),
        body: '{"code":"${code.value}"}',
      );
      final token = jsonDecode(result.body)["access_token"];
      return right(AccessToken(token));
    } catch (error) {
      return left(UnknownError());
    }
  }
}
