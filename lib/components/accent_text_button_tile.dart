import 'package:calculator/components/grid_text_tile.dart';
import 'package:flutter/material.dart';

class AccentTextButtonTile extends StatelessWidget {
  Color get color => Colors.blueAccent;

  final String title;
  final double? fontSize;
  final VoidCallback? onPressed;

  const AccentTextButtonTile({
    super.key,
    required this.title,
    this.fontSize,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GridTextTile(
      title: title,
      color: color,
      fontSize: fontSize,
      onPressed: onPressed,
      key: Key('tile-$title'),
    );
  }
}
