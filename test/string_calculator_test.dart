import 'package:flutter_test/flutter_test.dart';
import 'package:ankit_tdd_incubyte/string_calculator.dart';

void main() {
  group('StringCalculator', () {
    test('returns 0 for empty string', () {
      expect(StringCalculator().add(""), 0);
    });

    test('returns number for single number string', () {
      expect(StringCalculator().add("1"), 1);
    });

    test('returns sum for two numbers separated by comma', () {
      expect(StringCalculator().add("1,5"), 6);
    });

    test('returns sum for multiple numbers separated by comma', () {
      expect(StringCalculator().add("1,2,3,4"), 10);
    });

    test('handles new line delimiters between numbers', () {
      expect(StringCalculator().add("1\n2,3"), 6);
    });

    test('supports custom delimiter defined at start of input', () {
      expect(StringCalculator().add("//;\n1;2"), 3);
    });

    test('throws exception for single negative number', () {
      expect(() => StringCalculator().add("1,-2,3"),
          throwsA(predicate((e) => e is Exception && e.toString().contains('-2'))));
    });

    test('throws exception listing all negative numbers', () {
      expect(() => StringCalculator().add("-1,-2,3"),
          throwsA(predicate((e) => e is Exception && e.toString().contains('-1') && e.toString().contains('-2'))));
    });

    test('handles custom delimiter of any length', () {
      expect(StringCalculator().add("//[***]\n1***2***3"), 6);
    });

    test('handles multiple custom delimiters', () {
      expect(StringCalculator().add("//[*][%]\n1*2%3"), 6);
    });

    test('handles multiple custom delimiters with length longer than one char', () {
      expect(StringCalculator().add("//[***][%%%]\n1***2%%%3"), 6);
    });
  });
}
