import 'package:flutter/material.dart';

import 'package:calculator/components/grid_text_tile.dart';

class WeekTextButtonTile extends StatelessWidget {
  final Color color = Colors.black54;

  final String title;
  final VoidCallback? onPressed;

  const WeekTextButtonTile({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GridTextTile(
        title: title,
        color: color,
        onPressed: onPressed,
        key: Key('tile-$title'));
  }
}
