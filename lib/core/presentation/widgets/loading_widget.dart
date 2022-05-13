import 'package:flutter/material.dart';

import '../../constants.dart';

class LoadingWidet extends StatelessWidget {
  const LoadingWidet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 200,
        color: kSecondaryColor,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            CircularProgressIndicator(
              color: kAccentColor,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Loading...",
              style: TextStyle(color: kAccentColor),
            ),
          ],
        ),
      ),
    );
  }
}
