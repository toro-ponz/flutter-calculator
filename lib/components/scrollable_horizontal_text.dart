import 'package:flutter/material.dart';

class ScrollableHorizontalText extends StatelessWidget {
  final String title;
  final Color color;
  final double? fontSize;
  final double? paddingSize;
  final bool? reverse;

  const ScrollableHorizontalText(
      {super.key,
      required this.title,
      required this.color,
      this.fontSize,
      this.paddingSize,
      this.reverse});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.symmetric(vertical: paddingSize ?? 0.0),
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          reverse: reverse ?? false,
          padding: EdgeInsets.symmetric(horizontal: paddingSize ?? 0.0),
          child: Text(
            title,
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: fontSize, color: color),
          )),
    );
  }
}
