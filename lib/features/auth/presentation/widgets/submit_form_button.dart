import 'package:flutter/material.dart';

class SubmitFormButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget? child;

  const SubmitFormButton({super.key, required this.child, required this.onPressed});

  @override
  SubmitFormButtonState createState() => SubmitFormButtonState();
}

class SubmitFormButtonState extends State<SubmitFormButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(

      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 52),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.surface,
          textStyle: Theme.of(context).textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
