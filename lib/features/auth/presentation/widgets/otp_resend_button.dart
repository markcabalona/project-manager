import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';

class OTPResendButton extends StatefulWidget {
  const OTPResendButton({
    Key? key,
    required this.user,
    required this.duration,
  }) : super(key: key);

  final User user;
  final int duration;

  @override
  State<OTPResendButton> createState() => _OTPResendButtonState();
}

class _OTPResendButtonState extends State<OTPResendButton> {
  bool canResend = true;

  Timer? _timer;
  startTimer({int duration = 10}) {
    canResend = false;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_timer!.tick < duration) {
          setState(() {});
        } else {
          setState(() {
            canResend = true;
            timer.cancel();
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return canResend
        ? TextButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(
                SendEmailOTPEvent(user: widget.user),
              );
              startTimer(duration: widget.duration);
            },
            child: const Text(
              'Resend OTP',
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              'Resend in: ${widget.duration - _timer!.tick}',
              style: Theme.of(context).textTheme.button?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color),
            ),
          );
  }
}
