import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/features/auth/presentation/state/password_reset_state.dart';
import 'package:taskly/features/auth/presentation/widgets/custom_form_text_field.dart';
import 'package:taskly/features/auth/presentation/widgets/submit_form_button.dart';

class PasswordResetScreen extends ConsumerWidget {
  const PasswordResetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(passwordResetNotifierProvider);
    final notifier = ref.read(passwordResetNotifierProvider.notifier);

    final formKey = GlobalKey<FormState>();

    final emailController = TextEditingController();

    ref.listen<PasswordResetState>(passwordResetNotifierProvider, (previous, next) {
      if (next.errorMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.errorMessage!)));
      }
    });

   Future<void> sendEmail() async {
     if (formKey.currentState!.validate()) {
       await notifier.sendResetPassword(
         email: emailController.text.trim(),
       );
     }
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text('Esqueci minha senha'),
              CustomFormTextField(
                controller: emailController,
                isEnabled: !state.isLoading,
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
              SubmitFormButton(
                onPressed: state.isLoading ? null : () async => await sendEmail(),
                child: state.isLoading
                    ? CircularProgressIndicator()
                    : Text("Entrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
