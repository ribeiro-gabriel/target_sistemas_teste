import 'package:flutter_test/flutter_test.dart';
import 'package:target_sistemas_teste/app/modules/login/value_objects/password_vo..dart';

void main() {
  group('PasswordVO Validation', () {
    test('Empty Password', () {
      const password = PasswordVO('');
      final result = password.validate();

      expect(result, isNotNull);
      expect(result.$1, equals('A senha não pode estar em branco.'));
    });

    test('Password with Special Characters', () {
      const password = PasswordVO('senha@123');
      final result = password.validate();

      expect(
        result.$1,
        equals(
          'A senha não pode conter caractéres especiais. Apenas letras maiúsculas, minúsculas e números.',
        ),
      );
    });

    test('Password Too Long', () {
      const password = PasswordVO('senha12345678901234567890');
      final result = password.validate();

      expect(
          result.$1, equals('A senha não pode ser maior que 20 caractéres.'));
    });

    test('Valid Password', () {
      const password = PasswordVO('Senha123');
      final result = password.validate();

      expect(result.$1, isNull);
    });
  });
}
