import 'package:flutter/material.dart';

class GridTextTile extends StatelessWidget {
  final String title;
  final Color color;
  final double? fontSize;
  final VoidCallback? onPressed;

  const GridTextTile({
    super.key,
    required this.title,
    required this.color,
    this.fontSize,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: GridTile(
        child: RawMaterialButton(
          key: Key('$title-button'),
          constraints: const BoxConstraints.expand(),
          onPressed: onPressed ?? () {},
          fillColor: Colors.white,
          shape: const CircleBorder(),
          child: Text(
            title,
            style: TextStyle(
              fontSize: fontSize,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
