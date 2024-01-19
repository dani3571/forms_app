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
              _RegisterForm(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final GlobalKey<FormState> _formkey =
      GlobalKey<FormState>(); // * Para controlar el estado del formulario

/*
  String username = '';
  String email = '';
  String password = '';
*/
  @override
  Widget build(BuildContext context) {
    final registerCubit = context.watch<
        RegisterCubit>(); // ! Con el watch cada que el estado cambio se vuelve a renderizar

    return Form(
        key: _formkey,
        child: Column(
          children: [
            CustomTextFormField(
              label: 'Nombre de usuario',
              errorMessage: null,
              hint: 'Daniel chavez',
              onChanged: (value) {
                // Gestor de estado cubit
                registerCubit.usernameChanged(value);
                _formkey.currentState!.validate();
              },
              validator: (value) {
                if (value == null || value.isEmpty) return 'Campo requerido';
                if (value.trim().isEmpty) return 'Campo requerido'; // ! Limpia espacios delante y atras
                if (value.length < 6) return 'El usuario debe tener mas de 6 letras';

                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              label: 'Correo electronico',
              hint: 'daniel@gmail.com',
              errorMessage: null,
              onChanged: (value) {
                  registerCubit.emailChanged(value);
                     _formkey.currentState!.validate();
              },
              validator: (value) {
                if (value == null || value.isEmpty) return 'Campo requerido';
                if (value.trim().isEmpty) return 'Campo requerido';
                final emailRegExp = RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                );
                // ! Si no hace match con el value del input
                if (!emailRegExp.hasMatch(value))return 'No tiene formato de correo';
                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              label: 'Contraseña',
              errorMessage: null,
              obscureText: true,
              onChanged: (value) {
                registerCubit.passwordChanged(value);
                _formkey.currentState!.validate();
              },
              validator: (value) {
                if (value == null || value.isEmpty) return 'Campo requerido';
                if (value.trim().isEmpty)return 'Campo requerido'; // ! Limpia espacios delante y atras
                if (value.length < 6)return 'La contraseña debe tener mas de 6 letras';

                return null;
              },
            ),
            const SizedBox(height: 20),
            FilledButton.tonalIcon(
              onPressed: () {
                final isValid = _formkey.currentState!.validate();
                if (!isValid) return;
              
                registerCubit.onSubmit();
              },
              icon: const Icon(Icons.save),
              label: const Text('Crear usuario'),
            ),
          ],
        ));
  }
}
