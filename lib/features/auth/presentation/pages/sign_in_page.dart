import 'package:flutter/material.dart';

import '../widgets/auth_screen_navigator.dart';
import '../widgets/other_options_divider.dart';
import '../widgets/sign_in_form.dart';
import '../widgets/sign_in_header.dart';
import '../widgets/third_party_auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SignInHeader(),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SignInForm(),
          ),
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
            hint: "Don't have an account yet?",
            buttonLabel: "Sign Up",
            callback: () {
              Navigator.of(context).popAndPushNamed('/signUp');
            },
          ),
        ],
      ),
    );
  }
}
