part of 'register_cubit.dart';

enum FormStatus{invalid, valid, validating, posting}
class RegisterFormState extends Equatable {
  final FormStatus formStatus;
  final bool isValid;
  final UserName username; // ! Usamos la clase creada con Formz
  final Email email;
  final Password password;

  const RegisterFormState({
    this.formStatus = FormStatus.invalid,
    this.isValid = false,
    this.username = const UserName.pure(), // ! .pure valor inicial
    this.email = const Email.pure(),
    this.password = const Password.pure()
  });

  copyWith({
    FormStatus? formStatus,
    bool? isValid,
    UserName? username,
    Email? email,
    Password? password
  }) => RegisterFormState(
    formStatus: formStatus ?? this.formStatus,
    isValid: isValid ?? this.isValid,
    username: username ?? this.username,
    email: email ??this.email,
    password: password ?? this.password
  );

  @override
  List<Object> get props => [formStatus, username, email, password];
}

