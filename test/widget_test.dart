// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calculator/main.dart';

void main() {
  testWidgets('calculate(10+25)', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byKey(const ValueKey('button-1')));
    await tester.tap(find.byKey(const ValueKey('button-0')));
    await tester.tap(find.byKey(const ValueKey('button-+')));
    await tester.tap(find.byKey(const ValueKey('button-2')));
    await tester.tap(find.byKey(const ValueKey('button-5')));
    await tester.tap(find.byKey(const ValueKey('button-=')));
    await tester.pump();

    final formulaFinder = find.byKey(const ValueKey('formula'));
    final formula = formulaFinder.evaluate().single.widget as Text;

    expect(formula.data, '(10+25)=35');
  });

  testWidgets('calculate(10-25)', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byKey(const ValueKey('button-1')));
    await tester.tap(find.byKey(const ValueKey('button-0')));
    await tester.tap(find.byKey(const ValueKey('button--')));
    await tester.tap(find.byKey(const ValueKey('button-2')));
    await tester.tap(find.byKey(const ValueKey('button-5')));
    await tester.tap(find.byKey(const ValueKey('button-=')));
    await tester.pump();

    final formulaFinder = find.byKey(const ValueKey('formula'));
    final formula = formulaFinder.evaluate().single.widget as Text;

    expect(formula.data, '(10-25)=-15');
  });

  testWidgets('calculate(10*25)', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byKey(const ValueKey('button-1')));
    await tester.tap(find.byKey(const ValueKey('button-0')));
    await tester.tap(find.byKey(const ValueKey('button-×')));
    await tester.tap(find.byKey(const ValueKey('button-2')));
    await tester.tap(find.byKey(const ValueKey('button-5')));
    await tester.tap(find.byKey(const ValueKey('button-=')));
    await tester.pump();

    final formulaFinder = find.byKey(const ValueKey('formula'));
    final formula = formulaFinder.evaluate().single.widget as Text;

    expect(formula.data, '(10×25)=250');
  });

  testWidgets('calculate(10/25)', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byKey(const ValueKey('button-1')));
    await tester.tap(find.byKey(const ValueKey('button-0')));
    await tester.tap(find.byKey(const ValueKey('button-÷')));
    await tester.tap(find.byKey(const ValueKey('button-2')));
    await tester.tap(find.byKey(const ValueKey('button-5')));
    await tester.tap(find.byKey(const ValueKey('button-=')));
    await tester.pump();

    final formulaFinder = find.byKey(const ValueKey('formula'));
    final formula = formulaFinder.evaluate().single.widget as Text;

    expect(formula.data, '(10÷25)=0.400000');
  });

  testWidgets('calculate(10+2*33-0.5/3)', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byKey(const ValueKey('button-1')));
    await tester.tap(find.byKey(const ValueKey('button-0')));
    await tester.tap(find.byKey(const ValueKey('button-+')));
    await tester.tap(find.byKey(const ValueKey('button-2')));
    await tester.tap(find.byKey(const ValueKey('button-×')));
    await tester.tap(find.byKey(const ValueKey('button-3')));
    await tester.tap(find.byKey(const ValueKey('button-3')));
    await tester.tap(find.byKey(const ValueKey('button--')));
    await tester.tap(find.byKey(const ValueKey('button-0')));
    await tester.tap(find.byKey(const ValueKey('button-.')));
    await tester.tap(find.byKey(const ValueKey('button-5')));
    await tester.tap(find.byKey(const ValueKey('button-÷')));
    await tester.tap(find.byKey(const ValueKey('button-3')));
    await tester.tap(find.byKey(const ValueKey('button-=')));
    await tester.pump();

    final formulaFinder = find.byKey(const ValueKey('formula'));
    final formula = formulaFinder.evaluate().single.widget as Text;

    expect(formula.data, '(10+2×33-0.5÷3)=75.8333');
  });
}
