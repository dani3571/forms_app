import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final bool? obscureText;
  final Function(String)?
      onChanged; // firma del onchanged del TextFormField para ser llamado
  final String? Function(String?)?
      validator; // firma del validator de TextFormField

  const CustomTextFormField(
    { super.key,
      this.label,
      this.hint,
      this.errorMessage,
      this.onChanged,
      this.validator,
      this.obscureText
    }
  );

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
    );
    return TextFormField(
      onChanged: onChanged, // metodo para ver el contenido del input
      validator: validator,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
          enabledBorder: border,
          focusedBorder:
              border.copyWith(borderSide: BorderSide(color: colors.primary)),
          isDense: true,
          label: label != null ? Text('$label') : null,
          hintText: hint, // placeholder
          // suffixIcon: const Icon(Icons.supervised_user_circle_outlined),
          focusColor: colors.primary,
          suffixIconColor: colors.primary,
          //filled: true,
          errorText: errorMessage,
          errorBorder: border.copyWith(
              borderSide: BorderSide(color: Colors.red.shade800)),
          focusedErrorBorder: border.copyWith(
              borderSide: BorderSide(color: Colors.red.shade800))),
    );
  }
}
