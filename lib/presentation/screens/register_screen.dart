import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/register_cubit/register_cubit.dart';
import 'package:forms_app/presentation/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo usuario'),
      ),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: const _RegisterView(),
      ),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      // Widget para asegurar que el formulario se pueda ver correctamente
      child: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          // Widget para hacer scroll
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlutterLogo(size: 200),
              SizedBox(height: 20),
              _RegisterForm(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();
 // * Si usariamos _formkey el widget tendria que ser StatefullWidget
 //final GlobalKey<FormState> _formkey = GlobalKey<FormState>(); 

/*
  String username = '';
  String email = '';
  String password = '';
*/
  // * Para controlar el estado del formulario
  @override
  Widget build(BuildContext context) {
     // ! Con el watch cada que el estado cambie se vuelve a renderizar
    final registerCubit = context.watch<RegisterCubit>();
    final username = registerCubit.state.username;
    final email = registerCubit.state.email;
    final password = registerCubit.state.password;

    return Form(
      //  key: _formkey,
        child: Column(
          children: [
            CustomTextFormField(
              label: 'Nombre de usuario',
              errorMessage: username.errorMessage,
              hint: 'Daniel chavez',
              onChanged: (value) => registerCubit.usernameChanged(value), 
              /* {
                // Gestor de estado cubit
                registerCubit.usernameChanged(value);
            //    _formkey.currentState!.validate();
              },*/
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              label: 'Correo electronico',
              hint: 'daniel@gmail.com',
              errorMessage: email.errorMessage,
              onChanged: (value) {
                registerCubit.emailChanged(value);
             //   _formkey.currentState!.validate();
              },
              
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              label: 'Contraseña',
              errorMessage: password.messageError,
              obscureText: true,
              onChanged: (value) {
                registerCubit.passwordChanged(value);
              //  _formkey.currentState!.validate();
              },
            ),
            const SizedBox(height: 20),
            FilledButton.tonalIcon(
              onPressed: () {
                /*  final isValid = _formkey.currentState!.validate();
                if (!isValid) return;
              */
                registerCubit.onSubmit();
              },
              icon: const Icon(Icons.save),
              label: const Text('Crear usuario'),
            ),
          ],
        ));
  }
}
