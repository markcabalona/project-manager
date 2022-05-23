import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/auth_bloc.dart';

class OTPValidationPage extends StatelessWidget {
  final User user;
  const OTPValidationPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final otpCtrl = TextEditingController();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      'EMAIL VERIFICATION',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Icon(
                    FontAwesomeIcons.envelopeCircleCheck,
                    size: 128,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Enter the 6-digit code sent to ${user.email}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  TextFormField(
                    controller: otpCtrl,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'OTP cannot be empty';
                      } else if (val.length != 6) {
                        return 'OTP must be 6-digit number';
                      }
                      return null;
                    },
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                    decoration: InputDecoration(
                      hintText: "Enter OTP",
                      suffix: OTPResendButton(
                        user: user,
                        duration: 10,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    onEditingComplete: () {},
                    onFieldSubmitted: (String? x) {
                      onSubmit(context, formKey, otpCtrl);
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        onSubmit(context, formKey, otpCtrl);
                      },
                      child: const Text('Verify and Create Account'),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 30,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSubmit(context, formKey, otpCtrl) {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        ValidateEmailOTPEvent(user: user, otp: otpCtrl.text),
      );
    }
  }
}

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
