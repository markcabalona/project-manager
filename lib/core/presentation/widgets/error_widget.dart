import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;
  const CustomErrorWidget({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            // color: kAccentColor,
            size: 48,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            errorMessage,
            // style: const TextStyle(color: kAccentColor),
          ),
        ],
      ),
    );
  }
}
