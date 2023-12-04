import 'package:target_sistemas_teste/app/modules/home/stores/card_text_store.dart';
import 'package:target_sistemas_teste/app/modules/home/stores/home_page_store.dart';
import 'package:target_sistemas_teste/core/local_storage/local_storage.dart';
import 'package:target_sistemas_teste/core/local_storage/shared_preferences_adapter_impl.dart';

class DependencyInjectionContainer {
  late LocalStorage localStorage;
  late CardTextStore cardTextStore;
  late HomePageStore homePageStore;

  DependencyInjectionContainer() {
    localStorage = SharedPreferencesAdapterImpl();
    cardTextStore = CardTextStore(localStorage);
    homePageStore = HomePageStore(localStorage);
  }
}
