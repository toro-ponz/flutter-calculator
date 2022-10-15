import 'dart:io' show Platform;

import 'package:calculator/app.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows) {
    setWindowMinSize(const Size(405, 720));
  }

  runApp(const CalculatorApp());
}
