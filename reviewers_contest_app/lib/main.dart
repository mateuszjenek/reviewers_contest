import 'package:flutter/material.dart';
import 'package:reviewers_contest_app/injectable.dart';
import 'package:injectable/injectable.dart';

import 'authentication/presentation/login_page.dart';

void main() {
  configureInjection(Environment.prod);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Reviewers contest',
      // theme: ThemeData.dark().copyWith(
      //   colorScheme: ThemeData.dark().colorScheme.copyWith(
      //         secondary: Colors.blueGrey[200],
      //       ),
      // ),
      home: LoginPage(),
    );
  }
}
