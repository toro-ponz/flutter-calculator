import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

double _calculateFormula(double left, double right, String operator) {
  switch (operator) {
    case '+':
      return left + right;
    case '-':
      return left - right;
    case '×':
      return left * right;
    case '÷':
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

class _MyHomePageState extends State<MyHomePage> {
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

      if (lastLetter == ')') {
        _displayText = _displayText.replaceFirst('(', '');
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
            formula = formula.replaceFirst(pattern, '+${calculated.toString()}');
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

  Widget _buildAccentTextTile(String text, {VoidCallback? onPressed}) {
    return _buildGridTextTile(text, Colors.blueAccent, ValueKey('button-$text'),
        onPressed: onPressed);
  }

  Widget _buildBlackTextTile(String text, {VoidCallback? onPressed}) {
    return _buildGridTextTile(text, Colors.black54, ValueKey('button-$text'),
        onPressed: onPressed);
  }

  Widget _buildGridTextTile(String text, Color color, Key key,
      {VoidCallback? onPressed}) {
    return Container(
        margin: const EdgeInsets.all(2.0),
        alignment: Alignment.center,
        child: GridTile(
          child: RawMaterialButton(
            key: key,
            constraints: const BoxConstraints.expand(),
            onPressed: onPressed ?? () {},
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(18.0),
            shape: const CircleBorder(),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 40, color: color, fontWeight: FontWeight.bold),
            ),
          ),
        ));
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
            Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.only(top: 32.0, bottom: 32.0),
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    _displayText,
                    key: const ValueKey('formula'),
                    textAlign: TextAlign.right,
                    style:
                        const TextStyle(fontSize: 50, color: Colors.blueAccent),
                  )),
            ),
            Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.only(top: 2.0, bottom: 2.0),
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                  child: Text(
                    _message,
                    textAlign: TextAlign.right,
                    style:
                        const TextStyle(fontSize: 20, color: Colors.redAccent),
                  )),
            ),
            GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              shrinkWrap: true,
              children: [
                _buildBlackTextTile('AC', onPressed: _allClear),
                _buildBlackTextTile('C', onPressed: _clear),
                _buildBlackTextTile('+/-', onPressed: _toggleSign),
                _buildBlackTextTile('÷', onPressed: () {
                  _addOperator(divideOperator);
                }),
                _buildAccentTextTile('7', onPressed: () {
                  _addNumber(7);
                }),
                _buildAccentTextTile('8', onPressed: () {
                  _addNumber(8);
                }),
                _buildAccentTextTile('9', onPressed: () {
                  _addNumber(9);
                }),
                _buildBlackTextTile('×', onPressed: () {
                  _addOperator(multiOperator);
                }),
                _buildAccentTextTile('4', onPressed: () {
                  _addNumber(4);
                }),
                _buildAccentTextTile('5', onPressed: () {
                  _addNumber(5);
                }),
                _buildAccentTextTile('6', onPressed: () {
                  _addNumber(6);
                }),
                _buildBlackTextTile('-', onPressed: () {
                  _addOperator(minusOperator);
                }),
                _buildAccentTextTile('1', onPressed: () {
                  _addNumber(1);
                }),
                _buildAccentTextTile('2', onPressed: () {
                  _addNumber(2);
                }),
                _buildAccentTextTile('3', onPressed: () {
                  _addNumber(3);
                }),
                _buildBlackTextTile('+', onPressed: () {
                  _addOperator(plusOperator);
                }),
                _buildAccentTextTile('0', onPressed: () {
                  _addNumber(0);
                }),
                _buildAccentTextTile('.', onPressed: _addDecimalPoint),
                _buildAccentTextTile('DE', onPressed: _deleteOneLetter),
                _buildBlackTextTile('=', onPressed: _calculate),
              ],
            )
          ],
        ),
      ),
    );
  }
}
