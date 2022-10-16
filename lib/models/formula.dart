class Formula {
  final String _formula;

  Formula(this._formula);

  bool calculable() {
    try {
      calculate();
    } catch (e) {
      return false;
    }

    return true;
  }

  double calculate() {
    var f = _formula;
    final patterns = [
      RegExp(r'([+-]?\d+(\.\d+)?)([*/])([+-]?\d+(\.\d+)?)'),
      RegExp(r'([+-]?\d+(\.\d+)?)([+-])([+-]?\d+(\.\d+)?)'),
    ];

    for (final pattern in patterns) {
      while (true) {
        final match = pattern.firstMatch(f);

        if (match == null) {
          break;
        }

        final calculated = _calculateSingle(
          double.parse(match.group(1)!),
          double.parse(match.group(4)!),
          match.group(3)!,
        );

        if (calculated > 0) {
          f = f.replaceFirst(pattern, '+${calculated.toString()}');
        } else {
          f = f.replaceFirst(pattern, calculated.toString());
        }
      }
    }

    return double.parse(f);
  }

  double _calculateSingle(double left, double right, String operator) {
    switch (operator) {
      case '+':
        return left + right;
      case '-':
        return left - right;
      case '*':
        return left * right;
      case '/':
        if (right == 0) {
          throw Exception(
              'Formula@_calculateSingle: Invalid formula, zero divide ($left $operator $right).');
        }
        return left / right;
      default:
        throw Exception(
            'Formula@_calculateSingle: Invalid formula ($left $operator $right).');
    }
  }

  @override
  String toString() {
    return _formula;
  }
}
