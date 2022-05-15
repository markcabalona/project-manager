import 'package:flutter/material.dart';

class OtherOptionsDivider extends StatelessWidget {
  final String title;

  const OtherOptionsDivider({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          children: [
            const Expanded(
              child: Divider(
                  // color: kPrimaryColor,
                  ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
            ),
            const SizedBox(
              width: 10,
            ),
            const Expanded(
              child: Divider(
                  // color: kPrimaryColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
