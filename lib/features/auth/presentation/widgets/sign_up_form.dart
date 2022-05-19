import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/domain/usecases/usecase_params.dart';
import '../bloc/auth_bloc.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();

  late bool passwordDisplayed;

  @override
  void initState() {
    passwordDisplayed = false;
    super.initState();
  }

  String? _usernameValidator(String? val) {
    if (val == null || val.isEmpty) {
      return "Field cannot be empty";
    }
    return null;
  }

  String? _passwordValidator(String? val) {
    if (val == null || val.isEmpty) {
      return "Field cannot be empty";
    } else if (val.length < 6) {
      return "Password must be atleast 6 characters";
    } else if (_passwordCtrl.text != _confirmPasswordCtrl.text) {
      return "Password does not match.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _usernameCtrl,
            validator: (val) => _usernameValidator(val),
            decoration: InputDecoration(
              filled: true,
              // fillColor: kSecondaryColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              prefixIcon: const Icon(
                Icons.person,
                // color: kPrimaryColor.withOpacity(.5),
              ),
              hintText: "Enter Username",
              // hintStyle: TextStyle(color: kPrimaryColor.withOpacity(.5)),
              label: const Text("Username"),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _passwordCtrl,
            validator: (val) => _passwordValidator(val),
            obscureText: !passwordDisplayed,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.lock,
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(
                    passwordDisplayed
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordDisplayed = !passwordDisplayed;
                    });
                  },
                ),
              ),
              hintText: "Enter Password",
              label: const Text("Password"),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _confirmPasswordCtrl,
            validator: (val) => _passwordValidator(val),
            obscureText: !passwordDisplayed,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.lock,
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(
                    passwordDisplayed
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordDisplayed = !passwordDisplayed;
                    });
                  },
                ),
              ),
              hintText: "Re-enter Password",
              label: const Text("Confirm Password"),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<AuthBloc>(context).add(
                    SignUpEvent(
                      params: AuthParams(
                        email: _usernameCtrl.text,
                        password: _passwordCtrl.text,
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Create Account",
                style: TextStyle(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
