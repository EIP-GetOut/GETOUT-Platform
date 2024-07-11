import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MapController<K, V> extends ChangeNotifier implements ValueListenable<Map<K, V>> {
  final Map<K, V> _map;

  MapController(Map<K, V>? map): _map = map ?? <K,V>{};

  //Map<K, V> get map => _map;
  Map<K, V> get unmodifiable => Map.unmodifiable(_map);
  Iterable<MapEntry<K, V>> get entries => _map.entries;
  Iterable<K> get keys => _map.keys;
  Iterable<V> get values => _map.values;
  bool get isEmpty => _map.isEmpty;
  bool get isNotEmpty => !isEmpty;

  V? get(K key, V value) => _map[key];
  V? operator [](K key) => _map[key];
  bool containsValue(V? value) => _map.containsValue(value);
  bool containsKey(K? key) => _map.containsKey(key);

  void set(K key, V value) {
    _map[key] = value;
    notifyListeners();
  }

  void operator []=(K key, V value) {
    _map[key] = value;
    notifyListeners();
  }

  void remove(K value) {
    _map.remove(value);
    notifyListeners();
  }

  void clear() {
    _map.clear();
    notifyListeners();
  }

  @override
  // TODO: implement value
  Map<K, V> get value => _map;


}