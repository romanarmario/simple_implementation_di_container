import 'package:shared_preferences/shared_preferences.dart';

abstract interface class StorageRepository {
  Future<int> readCounter(String key);
  Future<void> writeCounter(String key, int value);
}

class SharedPreferencesStorage implements StorageRepository {
  final _storage = SharedPreferences.getInstance();

  @override
  Future<int> readCounter(String key) async => (await _storage).getInt(key) ?? 0;

  @override
  Future<void> writeCounter(String key, int value) async =>
      (await _storage).setInt(key, value);
}
