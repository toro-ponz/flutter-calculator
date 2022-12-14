import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Finder findChildButtonByKeyString(String keyString) {
  return find.descendant(
    of: find.byKey(Key(keyString)),
    matching: find.byType(RawMaterialButton),
  );
}
