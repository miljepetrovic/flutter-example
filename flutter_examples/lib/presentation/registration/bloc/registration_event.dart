part of 'registration_bloc.dart';

abstract class RegistrationEvent {}

class RegistrationSignupButtonPressed extends RegistrationEvent {
  RegistrationSignupButtonPressed();
}

class RegistrationEmailAddressChanged extends RegistrationEvent {
  final String value;

  RegistrationEmailAddressChanged({required this.value});
}

class RegistrationPasswordChanged extends RegistrationEvent {
  final String value;

  RegistrationPasswordChanged({required this.value});
}

class RegistrationConfirmPasswordChanged extends RegistrationEvent {
  final String value;

  RegistrationConfirmPasswordChanged({required this.value});
}
