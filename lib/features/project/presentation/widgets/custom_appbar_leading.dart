import 'package:flutter/material.dart';

import '../../../../core/themes.dart';

class CustomAppBarLeading extends StatefulWidget {
  const CustomAppBarLeading({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomAppBarLeading> createState() => _CustomAppBarLeadingState();
}

class _CustomAppBarLeadingState extends State<CustomAppBarLeading> {
  @override
  void initState() {
    customTheme.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Image.asset(
          'assets/images/${customTheme.currentTheme == ThemeMode.light ? 'logo-light' : 'logo-dark'}.png',
        ),
      ),
    );
  }
}
