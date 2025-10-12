import 'package:flutter/material.dart';

class SubmitFormButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget? child;

  const SubmitFormButton({super.key, required this.child, required this.onPressed});

  @override
  _SubmitFormButtonState createState() => _SubmitFormButtonState();
}

class _SubmitFormButtonState extends State<SubmitFormButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.075,
      width: MediaQuery.of(context).size.width * 0.5,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          textStyle: Theme.of(context).textTheme.bodyMedium,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
