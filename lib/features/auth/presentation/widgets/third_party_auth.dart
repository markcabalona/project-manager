import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants.dart';
import '../bloc/auth_bloc.dart';

class ThirdPartyAuth extends StatelessWidget {
  const ThirdPartyAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(
                GoogleSignInEvent(),
              );
            },
            child: const FaIcon(
              FontAwesomeIcons.google,
              color: kSecondaryColor,
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              fixedSize: const Size(60, 60),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const FaIcon(
              FontAwesomeIcons.facebookF,
              color: kSecondaryColor,
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              fixedSize: const Size(60, 60),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const FaIcon(
              FontAwesomeIcons.at,
              color: kSecondaryColor,
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              fixedSize: const Size(60, 60),
            ),
          ),
        ],
      ),
    );
  }
}
