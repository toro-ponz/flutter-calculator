import 'dart:io' show Platform;

import 'package:calculator/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    windowsAppBuilder(context, child) => Container(
          color: const Color(0xFFFAFAFA),
          child: Center(
            child: AspectRatio(
              aspectRatio: 9 / 16,
              child: child,
            ),
          ),
        );

    screenBuilder(context, child) => MaterialApp(
          title: 'Calculator',
          builder: Platform.isWindows ? windowsAppBuilder : null,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomePage(title: 'Calculator'),
        );

    return ScreenUtilInit(
      designSize: const Size(1080, 1920),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: screenBuilder,
    );
  }
}
