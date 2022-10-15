import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

import 'package:calculator/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows) {
    setWindowMinSize(const Size(540, 960));
    setWindowMaxSize(const Size(540, 960));
  }

  runApp(const CalculatorApp());
}
