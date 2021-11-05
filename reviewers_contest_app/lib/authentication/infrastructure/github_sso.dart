import 'dart:html';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:reviewers_contest_app/authentication/domain/authentication_code.dart';
import 'package:reviewers_contest_app/authentication/domain/github_sso_failure.dart';
import 'package:reviewers_contest_app/authentication/domain/i_github_sso.dart';

@prod
@Injectable(as: IGithubSSO)
class GithubSSO implements IGithubSSO {
  @override
  Future<Either<GithubSSOFailure, AuthenticationCode>>
      getAuthentiactionCode() async {
    try {
      final currentUri = Uri.base;
      final redirectUri = Uri(
        host: currentUri.host,
        scheme: currentUri.scheme,
        port: currentUri.port,
        path: "/static.html",
      );
      var cientId = const String.fromEnvironment("GITHUB_SSO_CLIENT_ID");
      print(cientId);
      final authUrl =
          "https://github.com/login/oauth/authorize?client_id=$cientId&redirect_uri=$redirectUri";

      final authWindow = window.open(authUrl, "Github Auth");

      String? code;
      await for (var event in window.onMessage) {
        if (event.data.toString().contains('code=')) {
          code = event.data.toString().split("code=")[1];
          break;
        }
      }

      authWindow.close();

      return right(AuthenticationCode(code!));
    } catch (error) {
      return left(UnknownError());
    }
  }
}
