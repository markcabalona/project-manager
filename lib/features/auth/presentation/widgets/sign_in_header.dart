import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/constants.dart';

class SignInHeader extends StatelessWidget {
  const SignInHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: const Size.fromHeight(260),
          painter: HeaderPainter(),
        ),
        Image.asset(
          'assets/images/logo.png',
          width: 128,
          height: 140,
        ),
      ],
    );
  }
}

class HeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rectPaint = Paint()..color = kPrimaryColor;

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
