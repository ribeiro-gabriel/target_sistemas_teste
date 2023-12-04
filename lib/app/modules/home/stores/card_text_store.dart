import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:target_sistemas_teste/core/local_storage/local_storage.dart';
import 'package:target_sistemas_teste/core/my_summary.dart';

class CardTextStore {
  final LocalStorage localStorage;
  late final Action fetchText;
  late final Action saveText;
  late final Action saveMySummaryText;
  late final Action deleteText;
  late final Action dispose;

  CardTextStore(this.localStorage) {
    debugPrint('Construtor');
    fetchText = Action(_fetchText);
    saveText = Action(_saveText);
    saveMySummaryText = Action(_saveMySummaryText);
    deleteText = Action(_deleteText);
    dispose = Action(_dispose);
  }

  final _text = Observable('');

  String get text => _text.value;

  set text(String newValue) => _text.value = newValue;

  final Observable<int?> _cardNumber = Observable(null);

  int? get cardNumber => _cardNumber.value;

  set cardNumber(int? newValue) => _cardNumber.value = newValue;

  final _isLoading = Observable(false);

  bool get isLoading => _isLoading.value;

  set isLoading(bool newValue) => _isLoading.value = newValue;

  final _isError = Observable(false);

  bool get isError => _isError.value;

  set isError(bool newValue) => _isError.value = newValue;

  Future<void> _fetchText() async {
    debugPrint('_fetchText');
    isLoading = true;

    debugPrint('Procurando: card_text_$cardNumber');
    localStorage.fetchData('card_text_$cardNumber').then((value) {
      runInAction(() => text = value);
    }).catchError((e) {
      debugPrint('Texto não encontrado: $e');
    });
    runInAction(() => isLoading = false);
  }

  Future<void> _saveText() async {
    await localStorage.saveData('card_text_$cardNumber', text);
    debugPrint('Salvo: $text');

    //Contabiliza o total de cards para mostrar na home
    try {
      int result = int.parse(await localStorage.fetchData('card_text_total'));
      if (result == cardNumber) return;
      debugPrint('Quantidade anterior: $result');
      result++;
      await localStorage.saveData('card_text_total', (result).toString());
      debugPrint('Quantidade atual: $result');
    } catch (_) {
      //No catch é porque não existe, então será cadastrado
      await localStorage.saveData('card_text_total', '1');
    }
  }

  Future<void> _saveMySummaryText() async {
    await localStorage.saveData('card_text_1', mySummary);
    debugPrint('Salvo: $text');
  }

  Future<void> _deleteText() async {
    localStorage.fetchData('card_text_$cardNumber').then((value) async {
      await localStorage
          .deleteData('card_text_$cardNumber')
          .then((value) async {
        runInAction(() {
          cardNumber = null;
          text = '';
        });

        debugPrint('Deletado: $cardNumber');
        try {
          int result =
              int.parse(await localStorage.fetchData('card_text_total'));
          debugPrint('Quantidade anterior: $result');
          result--;
          await localStorage.saveData('card_text_total', (result).toString());
          debugPrint('Quantidade atual: $result');
        } catch (_) {
          //No catch é porque não existe, então será cadastrado
          await localStorage.saveData('card_text_total', '1');
        }
      });
    }).catchError((e) {
      debugPrint('Texto não encontrado: $e');
    });
  }

  _dispose() {
    cardNumber = null;
    text = '';
  }
}
