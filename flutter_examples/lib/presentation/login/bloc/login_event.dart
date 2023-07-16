part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  LoginButtonPressed();
}

class LoginEmailAddressChanged extends LoginEvent {
  final String value;

  LoginEmailAddressChanged({required this.value});
}

class LoginPasswordChanged extends LoginEvent {
  final String value;

  LoginPasswordChanged({required this.value});
}
