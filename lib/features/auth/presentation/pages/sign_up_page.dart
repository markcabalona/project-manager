import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/routes/routes.dart';
import '../widgets/auth_screen_navigator.dart';
import '../widgets/other_options_divider.dart';
import '../widgets/sign_up_form.dart';
import '../widgets/third_party_auth.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Create an Account",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
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
                    context.goNamed(Routes.login.name);
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
