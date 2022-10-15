import 'package:calculator/components/accent_text_button_tile.dart';
import 'package:calculator/components/scrollable_horizontal_text.dart';
import 'package:calculator/components/week_text_button_tile.dart';
import 'package:calculator/pages/home_page.dart';
import 'package:flutter/material.dart';

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
    final String lastLetter = _displayText.substring(_displayText.length - 1);
    final int? parsed = int.tryParse(lastLetter);

    if (parsed == null) {
      return;
    }

    setState(() {
      _displayText += '.';
    });
  }

  void _toggleSign() {
    if (_displayText == '0') {
      return;
    }

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

  void _deleteOneLetter() {
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

  void _calculate() {
    var formula = _displayText.split(RegExp(r'=')).last;
    debugPrint('_calculate: formula=$formula');

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

      final result = double.parse(formula);
      debugPrint('_calculate: result=$result');

      setState(() {
        if (result == result.floorToDouble()) {
          _displayText = '($_displayText)=${result.floor()}';
          return;
        }

        _displayText = '($_displayText)=${result.toStringAsPrecision(6)}';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ScrollableHorizontalText(
              title: _displayText,
              color: Colors.blueAccent,
              fontSize: 50,
              paddingSize: 20.0,
              reverse: true,
            ),
            ScrollableHorizontalText(
                title: _message,
                color: Colors.redAccent,
                paddingSize: 2.0,
                fontSize: 20),
            GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              shrinkWrap: true,
              children: [
                WeekTextButtonTile(title: 'AC', onPressed: _allClear),
                WeekTextButtonTile(title: 'C', onPressed: _clear),
                WeekTextButtonTile(title: '+/-', onPressed: _toggleSign),
                WeekTextButtonTile(
                    title: '÷',
                    onPressed: () {
                      _addOperator(divideOperator);
                    }),
                AccentTextButtonTile(
                    title: '7',
                    onPressed: () {
                      _addNumber(7);
                    }),
                AccentTextButtonTile(
                    title: '8',
                    onPressed: () {
                      _addNumber(8);
                    }),
                AccentTextButtonTile(
                    title: '9',
                    onPressed: () {
                      _addNumber(9);
                    }),
                WeekTextButtonTile(
                    title: '×',
                    onPressed: () {
                      _addOperator(multiOperator);
                    }),
                AccentTextButtonTile(
                    title: '4',
                    onPressed: () {
                      _addNumber(4);
                    }),
                AccentTextButtonTile(
                    title: '5',
                    onPressed: () {
                      _addNumber(5);
                    }),
                AccentTextButtonTile(
                    title: '6',
                    onPressed: () {
                      _addNumber(6);
                    }),
                WeekTextButtonTile(
                    title: '-',
                    onPressed: () {
                      _addOperator(minusOperator);
                    }),
                AccentTextButtonTile(
                    title: '1',
                    onPressed: () {
                      _addNumber(1);
                    }),
                AccentTextButtonTile(
                    title: '2',
                    onPressed: () {
                      _addNumber(2);
                    }),
                AccentTextButtonTile(
                    title: '3',
                    onPressed: () {
                      _addNumber(3);
                    }),
                WeekTextButtonTile(
                    title: '+',
                    onPressed: () {
                      _addOperator(plusOperator);
                    }),
                AccentTextButtonTile(
                    title: '0',
                    onPressed: () {
                      _addNumber(0);
                    }),
                AccentTextButtonTile(title: '.', onPressed: _addDecimalPoint),
                AccentTextButtonTile(title: 'DE', onPressed: _deleteOneLetter),
                WeekTextButtonTile(title: '=', onPressed: _calculate),
              ],
            )
          ],
        ),
      ),
    );
  }
}
