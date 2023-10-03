import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_examples/core/router.dart';
import 'package:flutter_examples/presentation/login/page/login_page.dart';

import '../auth/bloc/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthUserUnauthenticated ||
                state is AuthAccountDeletionSuccess) {
              navigateAndReplace(context, const LoginPage());
            }
          },
          child: Column(
            children: const [
              _LogoutButton(),
              SizedBox(height: 8.0),
              _DeleteAccountButton()
            ],
          ),
        ),
      ));
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: () =>
            context.read<AuthBloc>().add(AuthLogoutButtonPressed()),
        child: const Text('Logout'),
      );
}

class _DeleteAccountButton extends StatelessWidget {
  const _DeleteAccountButton();

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: () =>
            context.read<AuthBloc>().add(AuthDeleteAccountButtonPressed()),
        child: const Text('Delete account'),
      );
}
