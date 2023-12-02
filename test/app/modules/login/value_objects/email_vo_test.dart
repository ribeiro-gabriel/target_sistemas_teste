import 'package:flutter_test/flutter_test.dart';
import 'package:target_sistemas_teste/app/modules/login/value_objects/email_vo.dart';

void main() {
  group('EmailVO Validation', () {
    test('Empty Email', () {
      const email = EmailVO('');
      final result = email.validate();

      expect(result.$1, equals('O email não pode estar em branco.'));
    });

    test('Invalid Email Format', () {
      const email = EmailVO('invalid_email');
      final result = email.validate();

      expect(result.$1, equals('Por favor, insira um e-mail válido.'));
    });

    test('Email Too Long', () {
      const email = EmailVO('emailtoolong@example.com');
      final result = email.validate();

      expect(
          result.$1, equals('A O email não pode ser maior que 20 caractéres.'));
    });

    test('Valid Email', () {
      const email = EmailVO('valid@email.com');
      final result = email.validate();

      expect(result.$1, isNull);
    });
  });
}
