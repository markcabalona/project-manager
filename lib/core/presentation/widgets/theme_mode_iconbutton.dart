import 'package:flutter/material.dart';

import 'package:todo/core/themes.dart';

class ThemeModeIconButton extends StatefulWidget {
  final Color? lightThemeColor;
  const ThemeModeIconButton({
    Key? key,
    this.lightThemeColor,
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
          ? const Icon(Icons.nightlight_outlined)
          : Icon(
              Icons.sunny,
              color: widget.lightThemeColor,
            ),
    );
  }
}
