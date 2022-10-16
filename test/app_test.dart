import 'package:calculator/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  group('CalculatorApp', () {
    testWidgets('calculate(10+25)', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
      await tester.pumpWidget(const CalculatorApp());

      await tester.tap(Utils.findChildButtonByKeyString('tile-1'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-0'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-+'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-2'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-5'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-='));
      await tester.pump();

      expect(find.text('(10+25)=35'), findsOneWidget);
    });

    testWidgets('calculate(10-25)', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
      await tester.pumpWidget(const CalculatorApp());

      await tester.tap(Utils.findChildButtonByKeyString('tile-1'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-0'));
      await tester.tap(Utils.findChildButtonByKeyString('tile--'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-2'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-5'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-='));
      await tester.pump();

      expect(find.text('(10-25)=-15'), findsOneWidget);
    });

    testWidgets('calculate(10*25)', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
      await tester.pumpWidget(const CalculatorApp());

      await tester.tap(Utils.findChildButtonByKeyString('tile-1'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-0'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-×'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-2'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-5'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-='));
      await tester.pump();

      expect(find.text('(10×25)=250'), findsOneWidget);
    });

    testWidgets('calculate(10/25)', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
      await tester.pumpWidget(const CalculatorApp());

      await tester.tap(Utils.findChildButtonByKeyString('tile-1'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-0'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-÷'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-2'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-5'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-='));
      await tester.pump();

      expect(find.text('(10÷25)=0.4'), findsOneWidget);
    });

    testWidgets('calculate(10+2*33-0.5/3)', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
      await tester.pumpWidget(const CalculatorApp());

      await tester.tap(Utils.findChildButtonByKeyString('tile-1'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-0'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-+'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-2'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-×'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-3'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-3'));
      await tester.tap(Utils.findChildButtonByKeyString('tile--'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-.'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-5'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-÷'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-3'));
      await tester.tap(Utils.findChildButtonByKeyString('tile-='));
      await tester.pump();

      expect(find.text('(10+2×33-0.5÷3)=75.833333'), findsOneWidget);
    });
  });
}
