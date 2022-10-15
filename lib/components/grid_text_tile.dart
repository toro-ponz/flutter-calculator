import 'package:flutter/material.dart';

class GridTextTile extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback? onPressed;

  const GridTextTile(
      {super.key, required this.title, required this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(2.0),
        alignment: Alignment.center,
        child: GridTile(
          child: RawMaterialButton(
            key: Key('$title-button'),
            constraints: const BoxConstraints.expand(),
            onPressed: onPressed ?? () {},
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(18.0),
            shape: const CircleBorder(),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 35, color: color, fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
