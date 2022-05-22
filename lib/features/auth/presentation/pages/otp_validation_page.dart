import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            padding: const EdgeInsets.symmetric(horizontal:20.0,),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  Text('OTP has been send to ${user.email}',textAlign: TextAlign.center,),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: otpCtrl,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'OTP cannot be empty';
                      } else if (val.length != 6) {
                        return 'OTP must be a 6 characters';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Enter OTP",
                      label: Text("OTP"),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(
                            ValidateEmailOTPEvent(user: user, otp: otpCtrl.text),
                          );
                        }
                      },
                      child: const Text('Verify'),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
