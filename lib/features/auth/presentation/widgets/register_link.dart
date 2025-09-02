import 'package:flutter/material.dart';

class RegisterLink extends StatelessWidget {
  final String route;
  final String text;
  final String secondaryText;
  final VoidCallback? onPressed;
  const RegisterLink({
    required this.route,
    required this.text,
    required this.secondaryText,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(text),
        TextButton(
          onPressed: onPressed,
          child: Text(
            secondaryText,
            style: TextStyle(
              color: Colors.green[200],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
