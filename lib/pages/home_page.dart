import 'package:flutter/material.dart';

import 'package:calculator/states/calculator_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => CalculatorState();
}
