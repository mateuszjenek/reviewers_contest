import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_button/sign_button.dart';

import 'package:reviewers_contest_app/authentication/application/auth_bloc.dart';
import 'package:reviewers_contest_app/configuration/presentation/configuration_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<AuthBloc>(),
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Flexible(
                flex: 1,
                child: Image(
                  image: AssetImage(
                      "assets/images/reviewers_contest_app_logo.png"),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is Authenticated) {
                        SchedulerBinding.instance!.addPostFrameCallback((_) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ConfigurationPage(state.token.value),
                              ));
                        });
                      }
                      if (state is Authenticating) {
                        return const CircularProgressIndicator();
                      } else {
                        return SignInButton(
                          buttonType: ButtonType.github,
                          onPressed: () {
                            context.read<AuthBloc>().add(SignIn());
                          },
                          buttonSize: ButtonSize.medium,
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
