import 'dart:ui';

import 'package:flutter/material.dart';

class ScrollableHorizontalText extends StatelessWidget {
  final String title;
  final Color color;
  final double? fontSize;
  final double? horizontalPadding;
  final bool? reverse;

  const ScrollableHorizontalText({
    super.key,
    required this.title,
    required this.color,
    this.fontSize,
    this.horizontalPadding,
    this.reverse,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: ScrollConfiguration(
        behavior: _ScrollBehavior(),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          reverse: reverse ?? false,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0.0),
          child: Text(
            title,
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: fontSize, color: color),
          ),
        ),
      ),
    );
  }
}

class _ScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
