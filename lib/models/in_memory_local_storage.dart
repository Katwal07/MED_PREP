import 'package:localstorage/localstorage.dart';

class InMemoryLocalStorage implements LocalStorage {
  final Map<String, String> _storage = {};

  @override
  int get length => _storage.length;

  @override
  String? key(int index) {
    if (index < 0 || index >= _storage.length) return null;
    return _storage.keys.elementAt(index);
  }

  @override
  String? getItem(String key) {
    return _storage[key];
  }

  @override
  void removeItem(String key) {
    _storage.remove(key);
  }

  @override
  void setItem(String key, String value) {
    _storage[key] = value;
  }

  @override
  void clear() {
    _storage.clear();
  }
}