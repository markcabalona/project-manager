import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/usecases/usecase_params.dart';
import '../bloc/auth_bloc.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              prefixIcon: const Icon(
                Icons.person,
              ),
              hintText: "Enter Username",
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
            obscureText: true,
            decoration: InputDecoration(
              filled: true,
              // fillColor: kSecondaryColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              prefixIcon: const Icon(
                Icons.lock,
              ),
              hintText: "Enter Password",

              label: const Text("Password"),
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
                    SignInEvent(
                      params: AuthParams(
                        email: _usernameCtrl.text,
                        password: _passwordCtrl.text,
                      ),
                    ),
                  );
                }
              },
              child: const Text(
                "Login",
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
