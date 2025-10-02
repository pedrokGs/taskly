import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/features/auth/presentation/providers/sign_in_use_case_provider.dart';
import 'package:taskly/features/auth/presentation/widgets/custom_form_text_field.dart';
import 'package:taskly/features/auth/presentation/widgets/submit_form_button.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInUseCase = ref.watch(signInUseCaseProvider);
    final _formKey = GlobalKey<FormState>();

    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomFormTextField(controller: _emailController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatório';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
                      return 'E-mail inválido';
                    }
                    return null;
                  },),
                CustomFormTextField(
                  controller: _passwordController,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatório';
                    }
                    if (value.trim().length < 6) {
                      return 'Senha muito curta';
                    }
                    return null;
                  },
                ),
                SubmitFormButton(onPressed: () {
                  if(_formKey.currentState!.validate()){
                    signInUseCase.call(email: _emailController.text.trim(), password: _passwordController.text.trim());
                  } else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Campos inválidos")));
                  }
                },)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
