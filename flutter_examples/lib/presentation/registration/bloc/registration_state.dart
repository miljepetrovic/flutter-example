part of 'registration_bloc.dart';

enum FormSubmissionStatus {
  initial,
  submitting,
  success,
  failure,
  confirmPasswordNotMatchWithPassword
}

class RegistrationState extends Equatable {
  final EmailAddress email;
  final Password password;
  final Password confirmPassword;
  final FormSubmissionStatus formSubmissionStatus;

  const RegistrationState({
    this.email = EmailAddress.empty,
    this.password = Password.empty,
    this.confirmPassword = Password.empty,
    this.formSubmissionStatus = FormSubmissionStatus.initial,
  });

  RegistrationState copyWith({
    EmailAddress? email,
    Password? password,
    Password? confirmPassword,
    FormSubmissionStatus? formSubmissionStatus,
  }) =>
      RegistrationState(
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
      );

  @override
  List<Object?> get props => [
        email,
        password,
        confirmPassword,
        formSubmissionStatus,
      ];

  bool isSubmitting() =>
      formSubmissionStatus == FormSubmissionStatus.submitting;

  bool isSubmissionSuccessOrFailure() =>
      formSubmissionStatus == FormSubmissionStatus.success ||
      formSubmissionStatus == FormSubmissionStatus.failure ||
      formSubmissionStatus ==
          FormSubmissionStatus.confirmPasswordNotMatchWithPassword;

  bool get isValid =>
      !email.hasError && !password.hasError && !confirmPassword.hasError;
}
