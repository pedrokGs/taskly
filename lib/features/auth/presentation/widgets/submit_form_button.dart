import 'package:flutter/material.dart';

class SubmitFormButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? labelText;
  const SubmitFormButton({super.key, this.labelText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.5,
      child: ElevatedButton(onPressed: onPressed, style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        textStyle: Theme.of(context).textTheme.bodyMedium,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))
      ), child: Text(labelText ?? "")),
    );
  }
}
