import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants.dart';
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

  String? _usernameValidator(String? val) {
    // TODO: Implement username validator
    if (val == null || val.isEmpty) {
      return "Field cannot be empty";
    }
    return null;
  }

  String? _passwordValidator(String? val) {
    // TODO: Implement password validator
    if (val == null || val.isEmpty) {
      return "Field cannot be empty";
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
              fillColor: kSecondaryColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              prefixIcon: Icon(
                Icons.person,
                color: kPrimaryColor.withOpacity(.5),
              ),
              hintText: "Enter Username",
              hintStyle: TextStyle(color: kPrimaryColor.withOpacity(.5)),
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
            decoration: InputDecoration(
              filled: true,
              fillColor: kSecondaryColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              prefixIcon: Icon(
                Icons.lock,
                color: Theme.of(context).primaryColor.withOpacity(.5),
              ),
              hintText: "Enter Password",
              hintStyle: TextStyle(color: kPrimaryColor.withOpacity(.5)),
              label: const Text("Password"),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _confirmPasswordCtrl,
            validator: (val) => _passwordValidator(val),
            decoration: InputDecoration(
              filled: true,
              fillColor: kSecondaryColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              prefixIcon: Icon(
                Icons.lock,
                color: Theme.of(context).primaryColor.withOpacity(.5),
              ),
              hintText: "Re-enter Password",
              hintStyle: TextStyle(color: kPrimaryColor.withOpacity(.5)),
              label: const Text("Confirm Password"),
              floatingLabelBehavior: FloatingLabelBehavior.always,
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
              child: const Text(
                "Create Account",
                style: TextStyle(
                  color: kSecondaryColor,
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
