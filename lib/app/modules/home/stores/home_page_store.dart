import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:target_sistemas_teste/core/local_storage/local_storage.dart';

class HomePageStore {
  final LocalStorage localStorage;
  late final Action fetchCardNumber;

  HomePageStore(this.localStorage) {
    fetchCardNumber = Action(_fetchCardNumber);
  }

  final Observable<int?> _cardNumber = Observable(null);

  int? get cardNumber => _cardNumber.value;

  set cardNumber(int? newValue) => _cardNumber.value = newValue;

  final _isLoading = Observable(false);

  bool get isLoading => _isLoading.value;

  set isLoading(bool newValue) => _isLoading.value = newValue;

  final _isError = Observable(false);

  bool get isError => _isError.value;

  set isError(bool newValue) => _isError.value = newValue;

  Future<void> _fetchCardNumber() async {
    debugPrint('_fetchCardNumber');
    isLoading = true;

    debugPrint('Procurando: card_text_total');
    localStorage.fetchData('card_text_total').then((value) {
      runInAction(() => cardNumber = int.parse(value));
    }).catchError((e) {
      debugPrint('Número não encontrado: $e');
    });
    runInAction(() => isLoading = false);
  }
}
