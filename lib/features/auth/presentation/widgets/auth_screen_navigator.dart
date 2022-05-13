import 'package:flutter/material.dart';

class AuthScreenNavigator extends StatelessWidget {
  final String hint;
  final String buttonLabel;
  final void Function() callback;

  const AuthScreenNavigator({
    Key? key,
    required this.hint,
    required this.buttonLabel,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(hint),
        TextButton(
          onPressed: callback,
          child: Text(buttonLabel),
        ),
      ],
    );
  }
}
