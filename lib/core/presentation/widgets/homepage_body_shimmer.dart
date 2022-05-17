import 'package:flutter/material.dart';

class LoadingWidet extends StatelessWidget {
  const LoadingWidet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 200,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(
              height: 20,
            ),
            Text(
              "Loading...",
            ),
          ],
        ),
      ),
    );
  }
}
