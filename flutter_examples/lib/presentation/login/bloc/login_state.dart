part of 'login_bloc.dart';

enum FormSubmissionStatus {
  initial,
  submitting,
  success,
  failure,
}

class LoginState extends Equatable {
  final EmailAddress email;
  final Password password;
  final FormSubmissionStatus formSubmissionStatus;

  const LoginState({
    this.email = EmailAddress.empty,
    this.password = Password.empty,
    this.formSubmissionStatus = FormSubmissionStatus.initial,
  });

  LoginState copyWith({
    EmailAddress? email,
    Password? password,
    FormSubmissionStatus? formSubmissionStatus,
  }) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
      );

  @override
  List<Object?> get props => [
        email,
        password,
        formSubmissionStatus,
      ];

  bool isSubmitting() =>
      formSubmissionStatus == FormSubmissionStatus.submitting;

  bool isSubmissionSuccessOrFailure() =>
      formSubmissionStatus == FormSubmissionStatus.success ||
      formSubmissionStatus == FormSubmissionStatus.failure;

  bool get isValid => !email.hasError && !password.hasError;
}
