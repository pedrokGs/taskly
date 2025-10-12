import 'package:flutter/material.dart';

class CustomFormTextField extends StatefulWidget{
  final bool isEnabled;
  final bool isPassword;
  final ValueChanged<String>? onChanged;
  final String? labelText;
  final Widget? icon;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const CustomFormTextField({
    super.key,
    this.isEnabled = true,
    this.isPassword = false,
    this.onChanged,
    required this.controller,
    this.icon,
    this.labelText,
    this.validator
  });

  @override
  State<CustomFormTextField> createState() => _CustomFormTextFieldState();
}

class _CustomFormTextFieldState extends State<CustomFormTextField> {
  bool obscureText = false;


  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.isEnabled,
      obscureText: obscureText,
      onChanged: widget.onChanged,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        prefixIcon: widget.icon,
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        suffixIcon: widget.isPassword
            ? IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
        )
            : null,
      ),
    );
  }
}
