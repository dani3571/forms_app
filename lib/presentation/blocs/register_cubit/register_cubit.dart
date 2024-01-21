import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:forms_app/infrastructure/inputs/inputs.dart';
import 'package:forms_app/infrastructure/inputs/password.dart';
import 'package:formz/formz.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(const RegisterFormState());

  void onSubmit(){
    // ! En caso de que no emitamos un nuevo estado y demos clic al boton de guardar no se mostrara ningun error
  emit(
      state.copyWith(
        formStatus: FormStatus.validating,
        username: UserName.dirty(state.username.value),
        password: Password.dirty(state.password.value),
        email: Email.dirty(state.email.value),

        isValid: Formz.validate([state.username, state.password, state.email])
      )
    );
    print('Submit: $state');
  }
  void usernameChanged(String value) {
    final username = UserName.dirty(value); // ! Dirty cuando el campo sea alterado por el usuario
    emit(state.copyWith(
      username: username,
      isValid: Formz.validate([username, state.password]), // Esto retornara un true o false

    ));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      isValid: Formz.validate([email, state.username, state.password])
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      isValid: Formz.validate([password, state.username]) // state para poder acceder al username
      // ! debemos mandar los otros inputs porque la funcion de validacion necesita verificar cada uno de los campos para saber si el formulario es valdo 
    ));
  }
}
 