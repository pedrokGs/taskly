import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

    void showResultModal() {
      showModalBottomSheet(
        context: context,
        isDismissible: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle_outline, color: Colors.green, size: 60),
                const SizedBox(height: 16),
                Text(
                  "Sucesso!",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Colors.green),
                ),
                const SizedBox(height: 8),
                Text(
                  "Um e-mail de redefinição de senha foi enviado para o seu endereço de e-mail.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    foregroundColor: Theme.of(context).colorScheme.surface,
                  ),
                  onPressed: () {
                    context.go('/signIn');
                  },
                  child: Text("Fechar"),
                ),
              ],
            ),
          );
        },
      );
    }

    ref.listen<PasswordResetState>(passwordResetNotifierProvider, (
      previous,
      next,
    ) {
      if(next.success){
        showResultModal();
      }
      if (next.errorMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.errorMessage!)));
      }
    });


    Future<void> sendEmail() async {
      if (formKey.currentState!.validate()) {
        await notifier.sendResetPassword(email: emailController.text.trim());
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
              Text('Redefinição de Senha', style: Theme.of(context).textTheme.titleSmall,),
              const SizedBox(height: 48,),
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
                onPressed: state.isLoading
                    ? null
                    : () async => await sendEmail(),
                child: state.isLoading
                    ? CircularProgressIndicator()
                    : Text("Enviar"),
              ),
              TextButton(onPressed: () => context.go('/signIn'), child: Text("Voltar")),
            ],
          ),
        ),
      ),
    );
  }

}
