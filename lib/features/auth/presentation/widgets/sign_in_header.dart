import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:todo/core/themes.dart';

class SignInHeader extends StatelessWidget {
  const SignInHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: const Size.fromHeight(260),
          painter: HeaderPainter(color: Theme.of(context).colorScheme.primary),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Image.asset(
            'assets/images/${customTheme.currentTheme == ThemeMode.light ? 'logo-light' : 'logo-dark'}.png',
            width: 128,
            height: 140,
          ),
        ),
      ],
    );
  }
}

class HeaderPainter extends CustomPainter {
  final Color color;
  HeaderPainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var rectPaint = Paint()..color = color;

    Size _rectSize = Size(size.width, size.height - 80);

    canvas.drawRect(
      const Offset(0, 0) & _rectSize,
      rectPaint,
    );
    Size _ovalSize =
        Size(size.width + 60, (size.height - _rectSize.height) * 2);
    canvas.drawArc(
      Offset(-(_ovalSize.width - size.width) / 2,
              size.height - _ovalSize.height) &
          _ovalSize,
      math.pi,
      -math.pi,
      true,
      rectPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
