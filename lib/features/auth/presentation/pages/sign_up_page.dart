import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants.dart';
import '../widgets/auth_screen_navigator.dart';
import '../widgets/other_options_divider.dart';
import '../widgets/sign_up_form.dart';
import '../widgets/third_party_auth.dart';
import 'authenticate_page.dart';
import 'sign_in_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Create an Account",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor),
                ),
                const SizedBox(
                  height: 60,
                ),
                const SignUpForm(),
                const SizedBox(
                  height: 20,
                ),
                const OtherOptionsDivider(
                  title: "Or Continue With",
                ),
                const SizedBox(
                  height: 20,
                ),
                const ThirdPartyAuth(), 
                const SizedBox(
                  height: 20,
                ),
                AuthScreenNavigator(
                  hint: "Already have an account?",
                  buttonLabel: "Sign In",
                  callback: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const AuthenticatePage(
                          child: Left(SignInPage()),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
