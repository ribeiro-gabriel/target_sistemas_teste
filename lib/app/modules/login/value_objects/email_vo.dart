import '../../../../core/interfaces/value_object.dart';

class EmailVO extends ValueObject<String> {
  const EmailVO(super.value);

  @override
  (String?, EmailVO) validate() {
    if (value.isEmpty) {
      return ('O email não pode estar em branco.', this);
    }

    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (!emailRegex.hasMatch(value!)) {
      return ('Por favor, insira um e-mail válido.', this);
    }

    if (value.length > 20) {
      return ('A O email não pode ser maior que 20 caractéres.', this);
    }

    return (null, this);
  }
}
