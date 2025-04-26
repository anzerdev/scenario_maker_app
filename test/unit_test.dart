import 'package:flutter_test/flutter_test.dart';
import 'package:scenario_maker_app/services/helpers.dart';

void main() {
  group('validateEmail', () {
    test('returns error when email is null', () {
      expect(validateEmail(null), 'Email cannot be empty');
    });

    test('returns error when email is empty', () {
      expect(validateEmail(''), 'Email cannot be empty');
    });

    test('returns error when email does not contain "@"', () {
      expect(
          validateEmail('example.com'), 'Please enter a valid email address');
    });

    test('returns error when email starts with "@"', () {
      expect(
          validateEmail('@example.com'), 'Please enter a valid email address');
    });

    test('returns error when email ends with "@"', () {
      expect(validateEmail('example@'), 'Please enter a valid email address');
    });

    test('returns null when email is valid', () {
      expect(validateEmail('test@example.com'), null);
    });
  });
}