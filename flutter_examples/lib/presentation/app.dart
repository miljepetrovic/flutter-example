import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_examples/core/router.dart';
import 'package:flutter_examples/presentation/auth/bloc/auth_bloc.dart';
import 'package:flutter_examples/presentation/home/home_page.dart';
import 'package:flutter_examples/presentation/login/page/login_page.dart';
import 'package:flutter_examples/presentation/splash/splash_screen.dart';

import '../dependency_injection.dart';

class FlutterExampleApp extends StatelessWidget {
  const FlutterExampleApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Flutter example',
      home: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUserUnauthenticated) {
            navigateAndReplace(context, const LoginPage());
          }

          if (state is AuthUserAuthenticated) {
            navigateAndReplace(context, const HomePage());
          }
        },
        builder: (context, state) => const SplashScreen(),
      ));
}
