import 'package:flutter/material.dart';

import '../../themes.dart';

class ThemeModeIconButton extends StatefulWidget {
  final Color? primaryColor;
  const ThemeModeIconButton({
    Key? key,
    this.primaryColor,
  }) : super(key: key);

  @override
  State<ThemeModeIconButton> createState() => _ThemeModeIconButtonState();
}

class _ThemeModeIconButtonState extends State<ThemeModeIconButton> {
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
    return IconButton(
      onPressed: () {
        customTheme.toggleTheme();
      },
      icon: customTheme.currentTheme == ThemeMode.dark
          ? Icon(
              Icons.nightlight_outlined,
              color: widget.primaryColor
            )
          : Icon(
              Icons.sunny,
              color: widget.primaryColor,
            ),
    );
  }
}
