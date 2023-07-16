import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_examples/core/router.dart';
import 'package:flutter_examples/core/utils.dart';
import 'package:flutter_examples/dependency_injection.dart';
import 'package:flutter_examples/presentation/home/home_page.dart';
import 'package:flutter_examples/presentation/login/bloc/login_bloc.dart';
import 'package:flutter_examples/presentation/registration/page/registration_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<LoginBloc>(),
        child: Scaffold(
          appBar: AppBar(title: const Text('Login page')),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                _LoginForm(),
                SizedBox(height: 8.0),
                _SignUpButton()
              ],
            ),
          ),
        ),
      );
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => navigateTo(
          context,
          const RegistrationPage(),
        ),
        child: const Text('Do not have an account? Sign up'),
      );
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) => BlocListener<LoginBloc, LoginState>(
        listenWhen: (previous, current) =>
            current.isSubmissionSuccessOrFailure(),
        listener: (context, state) {
          if (state.formSubmissionStatus == FormSubmissionStatus.success) {
            navigateAndReplace(context, const HomePage());
          }

          if (state.formSubmissionStatus == FormSubmissionStatus.failure) {
            showErrorScaffold(
                context, 'Login failed. Please check your credentials.');
          }
        },
        child: Column(
          children: const [
            _EmailInputField(),
            SizedBox(height: 8.0),
            _PasswordInputField(),
            SizedBox(height: 8.0),
            _SignInButton()
          ],
        ),
      );
}

class _EmailInputField extends StatelessWidget {
  const _EmailInputField();

  @override
  Widget build(BuildContext context) => BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => current.email != previous.email,
      builder: (context, state) => TextField(
            onChanged: (email) => context
                .read<LoginBloc>()
                .add(LoginEmailAddressChanged(value: email)),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email address',
              errorText: state.email.hasError ? state.email.errorMessage : null,
            ),
          ));
}

class _PasswordInputField extends StatelessWidget {
  const _PasswordInputField();

  @override
  Widget build(BuildContext context) => BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => current.password != previous.password,
        builder: (context, state) => TextFormField(
          onChanged: (password) => context
              .read<LoginBloc>()
              .add(LoginPasswordChanged(value: password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            errorText:
                state.password.hasError ? state.password.errorMessage : null,
          ),
        ),
      );
}

class _SignInButton extends StatelessWidget {
  const _SignInButton();

  @override
  Widget build(BuildContext context) => BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => ElevatedButton(
          onPressed: () => state.isSubmitting() || !state.isValid
              ? null
              : context.read<LoginBloc>().add(LoginButtonPressed()),
          child: Text(state.isSubmitting() ? 'Submitting' : 'Sign In'),
        ),
      );
}
