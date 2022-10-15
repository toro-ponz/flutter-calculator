import 'dart:math';

import 'package:calculator/components/accent_text_button_tile.dart';
import 'package:calculator/components/scrollable_horizontal_text.dart';
import 'package:calculator/components/week_text_button_tile.dart';
import 'package:calculator/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CalculatorState extends State<HomePage> {
  static const plusOperator = '+';
  static const minusOperator = '-';
  static const multiOperator = '×';
  static const divideOperator = '÷';

  String _displayText = '0';
  String _message = '';

  void _setMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  void _clear() {
    var lastFormula = _displayText.split(RegExp(r'=')).last;
    setState(() {
      _displayText = lastFormula;
      _message = '';
    });
  }

  void _allClear() {
    setState(() {
      _displayText = '0';
      _message = '';
    });
  }

  void _addNumber(int number) {
    setState(() {
      if (_displayText == '0') {
        _displayText = number.toString();
        return;
      }

      _displayText += number.toString();
    });
  }

  void _addOperator(String operator) {
    if (_displayText == '0') {
      return;
    }

    final String lastLetter = _displayText.substring(_displayText.length - 1);
    final int? parsed = int.tryParse(lastLetter);

    if (parsed == null) {
      return;
    }

    setState(() {
      _displayText += operator;
    });
  }

  void _addDecimalPoint() {
    final pattern = RegExp(r'([+-])?(\d+(\.\d+)?)$');
    final match = pattern.firstMatch(_displayText);

    if (match == null) {
      return;
    }

    final value = match.group(0)!;
    if (value.contains('.')) {
      return;
    }

    setState(() {
      _displayText += '.';
    });
  }

  void _toggleSign() {
    final pattern = RegExp(r'([+-])?(\d+(\.\d+)?)$');
    final match = pattern.firstMatch(_displayText);

    if (match == null) {
      return;
    }

    final sign = match.group(1);
    final newSign = sign == minusOperator ? plusOperator : minusOperator;

    setState(() {
      _displayText = _displayText.replaceFirstMapped(pattern, (match) {
        return '$newSign${match.group(2)}';
      });
    });
  }

  void _backspace() {
    setState(() {
      _message = '';
    });

    if (_displayText.isEmpty) {
      return;
    }

    final String lastLetter = _displayText.substring(_displayText.length - 1);

    setState(() {
      _displayText = _displayText.substring(0, _displayText.length - 1);

      // remove '()'
      if (lastLetter == '=') {
        _displayText = _displayText.substring(1, _displayText.length - 1);
      }

      if (_displayText.isEmpty) {
        _displayText = '0';
      }
    });
  }

  double _roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  void _calculate() {
    var formula = _displayText.split(RegExp(r'=')).last;
    debugPrint('_calculate: formula=$formula');

    final String lastLetter = formula.substring(formula.length - 1);
    final int? parsed = int.tryParse(lastLetter);
    if (parsed == null) {
      return;
    }

    try {
      final patterns = [
        RegExp(r'([+-]?\d+(\.\d+)?)([×÷])([+-]?\d+(\.\d+)?)'),
        RegExp(r'([+-]?\d+(\.\d+)?)([+-])([+-]?\d+(\.\d+)?)'),
      ];

      for (final pattern in patterns) {
        while (true) {
          final match = pattern.firstMatch(formula);

          if (match == null) {
            break;
          }

          final calculated = _calculateFormula(double.parse(match.group(1)!),
              double.parse(match.group(4)!), match.group(3)!);

          if (calculated > 0) {
            formula =
                formula.replaceFirst(pattern, '+${calculated.toString()}');
          } else {
            formula = formula.replaceFirst(pattern, calculated.toString());
          }
        }
      }

      final result = _roundDouble(double.parse(formula), 6);
      debugPrint('_calculate: result=$result');

      setState(() {
        if (result == result.floorToDouble()) {
          _displayText = '($_displayText)=${result.floor()}';
          return;
        }

        _displayText = '($_displayText)=$result';
      });
    } catch (e, stackTrace) {
      debugPrint('$e\n$stackTrace');
      _setMessage(e.toString().replaceAll('\n', ' '));
      return;
    }
  }

  double _calculateFormula(double left, double right, String operator) {
    switch (operator) {
      case plusOperator:
        return left + right;
      case minusOperator:
        return left - right;
      case multiOperator:
        return left * right;
      case divideOperator:
        if (right == 0) {
          throw Exception(
              '_calculateFormula: Invalid formula, zero divide ($left $operator $right).');
        }
        return left / right;
      default:
        throw Exception(
            '_calculateFormula: Invalid formula ($left $operator $right).');
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(1080, 1920),
      minTextAdapt: true,
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ScrollableHorizontalText(
                title: _displayText,
                color: Colors.blueAccent,
                fontSize: 170.sp,
                horizontalPadding: 50.h,
                reverse: true,
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15.h),
              child: ScrollableHorizontalText(
                title: _message,
                color: Colors.redAccent,
                fontSize: 50.sp,
                horizontalPadding: 25.w,
              ),
            ),
            GridView.count(
              padding: EdgeInsets.symmetric(vertical: 25.h),
              crossAxisCount: 4,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.w,
              shrinkWrap: true,
              children: [
                WeekTextButtonTile(
                  title: 'AC',
                  fontSize: 100.sp,
                  onPressed: _allClear,
                ),
                WeekTextButtonTile(
                  title: 'C',
                  fontSize: 100.sp,
                  onPressed: _clear,
                ),
                WeekTextButtonTile(
                  title: '+/-',
                  fontSize: 100.sp,
                  onPressed: _toggleSign,
                ),
                WeekTextButtonTile(
                  title: '÷',
                  fontSize: 100.sp,
                  onPressed: () {
                    _addOperator(divideOperator);
                  },
                ),
                AccentTextButtonTile(
                  title: '7',
                  fontSize: 100.sp,
                  onPressed: () {
                    _addNumber(7);
                  },
                ),
                AccentTextButtonTile(
                  title: '8',
                  fontSize: 100.sp,
                  onPressed: () {
                    _addNumber(8);
                  },
                ),
                AccentTextButtonTile(
                  title: '9',
                  fontSize: 100.sp,
                  onPressed: () {
                    _addNumber(9);
                  },
                ),
                WeekTextButtonTile(
                  title: '×',
                  fontSize: 100.sp,
                  onPressed: () {
                    _addOperator(multiOperator);
                  },
                ),
                AccentTextButtonTile(
                  title: '4',
                  fontSize: 100.sp,
                  onPressed: () {
                    _addNumber(4);
                  },
                ),
                AccentTextButtonTile(
                  title: '5',
                  fontSize: 100.sp,
                  onPressed: () {
                    _addNumber(5);
                  },
                ),
                AccentTextButtonTile(
                  title: '6',
                  fontSize: 100.sp,
                  onPressed: () {
                    _addNumber(6);
                  },
                ),
                WeekTextButtonTile(
                  title: '-',
                  fontSize: 100.sp,
                  onPressed: () {
                    _addOperator(minusOperator);
                  },
                ),
                AccentTextButtonTile(
                  title: '1',
                  fontSize: 100.sp,
                  onPressed: () {
                    _addNumber(1);
                  },
                ),
                AccentTextButtonTile(
                  title: '2',
                  fontSize: 100.sp,
                  onPressed: () {
                    _addNumber(2);
                  },
                ),
                AccentTextButtonTile(
                  title: '3',
                  fontSize: 100.sp,
                  onPressed: () {
                    _addNumber(3);
                  },
                ),
                WeekTextButtonTile(
                  title: '+',
                  fontSize: 100.sp,
                  onPressed: () {
                    _addOperator(plusOperator);
                  },
                ),
                AccentTextButtonTile(
                  title: '0',
                  fontSize: 100.sp,
                  onPressed: () {
                    _addNumber(0);
                  },
                ),
                AccentTextButtonTile(
                  title: '.',
                  fontSize: 100.sp,
                  onPressed: _addDecimalPoint,
                ),
                AccentTextButtonTile(
                  title: 'DE',
                  fontSize: 100.sp,
                  onPressed: _backspace,
                ),
                WeekTextButtonTile(
                  title: '=',
                  fontSize: 100.sp,
                  onPressed: _calculate,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.h),
              child: ScrollableHorizontalText(
                title: '© 2022 toro_ponz',
                color: Colors.grey,
                fontSize: 50.sp,
                horizontalPadding: 25.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
