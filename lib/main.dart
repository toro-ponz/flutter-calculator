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

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Brightness? _brightness;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _brightness = WidgetsBinding.instance?.window.platformBrightness;
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {
      _brightness = WidgetsBinding.instance?.window.platformBrightness;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
      home: const CalculatorApp(),
    );
  }
}
