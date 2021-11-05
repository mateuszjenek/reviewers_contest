import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import 'package:reviewers_contest_app/authentication/domain/access_token.dart';
import 'package:reviewers_contest_app/authentication/domain/i_github_sso.dart';
import 'package:reviewers_contest_app/authentication/domain/i_reviewers_contest_sso.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IGithubSSO _githubSSO;
  final IReviewersContestSSO _reviewersContestSSO;

  AuthBloc(this._githubSSO, this._reviewersContestSSO)
      : super(Unauthenticated()) {
    on<SignIn>((event, emit) async {
      emit(Authenticating());
      final codeRequest = await _githubSSO.getAuthentiactionCode();
      await codeRequest.fold(
        (_) async => emit(AuthenticatingFailed()),
        (code) async {
          final tokenRequest =
              await _reviewersContestSSO.getAuthenticationToken(code);
          await tokenRequest.fold(
            (_) async => emit(AuthenticatingFailed()),
            (token) async => emit(Authenticated(token)),
          );
        },
      );
    });
  }
}
