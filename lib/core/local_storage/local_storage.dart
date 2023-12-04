abstract class LocalStorage {
  Future<void> saveData(String keyValue, String valueToCache);

  Future<void> saveListData(String keyValue, List<String> listToCache);

  Future<String> fetchData(String keyValue);

  Future<List<String>> fetchListData(String keyValue);

  Future<void> deleteData(String keyValue);

  Future<void> clearData();
}
