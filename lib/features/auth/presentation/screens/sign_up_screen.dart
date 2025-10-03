import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taskly/features/auth/domain/exceptions/email_already_in_use_exception.dart';
import 'package:taskly/features/auth/presentation/providers/sign_up_use_case_provider.dart';
import 'package:taskly/features/auth/presentation/widgets/custom_form_text_field.dart';
import 'package:taskly/features/auth/presentation/widgets/submit_form_button.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpUseCase = ref.watch(signUpUseCaseProvider);
    final formKey = GlobalKey<FormState>();

    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmaSenhaController = TextEditingController();

    Future<void>? signUp() async {
      if (formKey.currentState!.validate()) {
        if (!(passwordController.text.trim() ==
            passwordController.text.trim())) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("As senhas não coincidem")));
        }

        try {
            await signUpUseCase.call(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

          context.go("/home");

        } on EmailAlreadyInUseException {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Este email já está sendo utilizado")));
        } on Exception {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Ocorreu um erro inesperado")));
        }
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Campos inválidos")));
      }
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomFormTextField(
                controller: emailController,
                labelText: "Email",
                icon: Icon(Icons.email),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Campo obrigatório';
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value.trim())) {
                    return 'E-mail inválido';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 48),
              CustomFormTextField(
                controller: passwordController,
                isPassword: true,
                labelText: "Senha",
                icon: Icon(Icons.password),
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

              const SizedBox(height: 48),
              CustomFormTextField(
                controller: confirmaSenhaController,
                isPassword: true,
                labelText: "Confirmar Senha",
                icon: Icon(Icons.password),
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

              const SizedBox(height: 48),
              SubmitFormButton(
                onPressed: () async => await signUp(),
                child: Text("Cadastrar"),
              ),
              const SizedBox(height: 24,),
              TextButton(onPressed: () => context.go("/signIn"), child: Text("Já tenho uma conta"))
            ],
          ),
        ),
      ),
    );
  }
}
