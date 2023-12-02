import '../../../../core/interfaces/value_object.dart';

class PasswordVO extends ValueObject<String> {
  const PasswordVO(super.value);

  ///O método [validate] retorna uma string contendo a informação do porquê
  ///o valor é inválido no lado esquerdo e o próprio valor no lado direito,
  ///caso ele seja inválido.
  ///Retorna o próprio PasswordVO no lado direito e nulo no lado esquerdo,
  /// caso o valor seja válido.
  @override
  (String?, PasswordVO) validate() {
    if (value.isEmpty) {
      return ('A senha não pode estar em branco.', this);
    }

    //Ao validar a regex de a até Z e de 0 até 9, já impede que fique espaço
    //no final
    RegExp regex = RegExp(r'^[a-zA-Z0-9]+$');

    if (!regex.hasMatch(value)) {
      return (
        'A senha não pode conter caractéres especiais. Apenas letras maiúsculas, minúsculas e números.',
        this
      );
    }

    if (value.length > 20) {
      return ('A senha não pode ser maior que 20 caractéres.', this);
    }

    return (null, this);
  }
}
