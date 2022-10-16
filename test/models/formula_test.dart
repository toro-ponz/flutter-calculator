import 'package:calculator/models/formula.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formula', () {
    group('calculate', () {
      test('Only one num.', () {
        expect(Formula('34').calculate(), 34);
      });

      test('Simple add.', () {
        expect(Formula('102+1923').calculate(), 2025);
      });

      test('Decimal add.', () {
        expect(Formula('1.52+10.32').calculate(), 11.84);
      });

      test('Simple sub.', () {
        expect(Formula('1923-102').calculate(), 1821);
      });

      test('Decimal sub.', () {
        expect(Formula('10.23-1.22').calculate(), 9.01);
      });

      test('Simple multi.', () {
        expect(Formula('3*12').calculate(), 36);
      });

      test('Decimal multi.', () {
        expect(Formula('1.55*31.2').calculate(), 48.36);
      });

      test('Prioritize multi.', () {
        expect(Formula('10+5*2').calculate(), 20);
      });

      test('Simple div.', () {
        expect(Formula('120/6').calculate(), 20);
      });

      test('Decimal div.', () {
        expect(Formula('31.2/1.55').calculate(), 20.129032258064516);
      });

      test('Prioritize div.', () {
        expect(Formula('10-5/2').calculate(), 7.5);
      });

      test('Long formula.', () {
        expect(Formula('10+5*2+10-5/2-9*3/3').calculate(), 18.5);
      });

      test('Zero div.', () {
        expect(() => {Formula('120/0').calculate()}, throwsException);
      });

      test('Invalid param.', () {
        expect(() => {Formula('ab').calculate()}, throwsException);
      });

      test('Invalid number.', () {
        expect(() => {Formula('1.2.3').calculate()}, throwsException);
      });

      test('Invalid formula.', () {
        expect(() => {Formula('1]2').calculate()}, throwsException);
      });
    });
  });
}
