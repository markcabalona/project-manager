import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          RepaintBoundary(
            child: TextFormField(
              controller: _usernameCtrl,
              validator: (val) => _usernameValidator(val),
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                ),
                hintText: "Enter Username",
                label: Text("Username"),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          RepaintBoundary(
            child: TextFormField(
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
          ),
          const SizedBox(
            height: 20,
          ),
          RepaintBoundary(
            child: SizedBox(
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
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Login",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
