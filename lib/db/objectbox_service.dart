import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'harcama.dart';
import '../objectbox.g.dart';

class ObjectBoxService {
  static ObjectBoxService? _instance;
  static ObjectBoxService get instance => _instance ??= ObjectBoxService._();

  ObjectBoxService._();

  late Store _store;
  late Box<Harcama> _harcamaBox;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  /// ObjectBox'ı başlat
  Future<void> init() async {
    if (_isInitialized) return;

    try {
      // Uygulama doküman dizinini al
      final docsDir = await getApplicationDocumentsDirectory();

      // ObjectBox store'u aç
      _store = await openStore(directory: p.join(docsDir.path, 'objectbox'));

      // Harcama box'ını al
      _harcamaBox = _store.box<Harcama>();

      _isInitialized = true;
      debugPrint('ObjectBox çalıştı.');
    } catch (e) {
      debugPrint('ObjectBox çalışamadım :( $e');
      rethrow;
    }
  }

  /// Harcama ekle
  int harcamaEkle(Harcama harcama) {
    if (!_isInitialized) throw StateError('ObjectBox henüz başlatılmadı');
    return _harcamaBox.put(harcama);
  }

  /// Tüm harcamaları getir
  List<Harcama> tumHarcamalariGetir() {
    if (!_isInitialized) return [];
    return _harcamaBox.getAll();
  }

  /// ID'ye göre harcama getir
  Harcama? harcamaGetir(int id) {
    if (!_isInitialized) return null;
    return _harcamaBox.get(id);
  }

  /// Harcama güncelle
  int harcamaGuncelle(Harcama harcama) {
    if (!_isInitialized) throw StateError('ObjectBox henüz başlatılmadı');
    return _harcamaBox.put(harcama);
  }

  /// Harcama sil
  bool harcamaSil(int id) {
    if (!_isInitialized) return false;
    return _harcamaBox.remove(id);
  }

  /// Tüm harcamaları sil
  int tumHarcamalariSil() {
    if (!_isInitialized) return 0;
    return _harcamaBox.removeAll();
  }

  /// Store'u kapat
  void close() {
    if (_isInitialized) {
      _store.close();
      _isInitialized = false;
    }
  }
}
