import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../db/objectbox_harcama.dart';
import '../../db/objectbox_service.dart';
import 'ekle_view.dart';

class EkleModel extends ChangeNotifier {
  final TextEditingController tutarController = TextEditingController();
  final TextEditingController aciklamaController = TextEditingController();
  String? _seciliKategori;
  DateTime _seciliTarih = DateTime.now();
  List<Harcama> _harcamalar = [];

  final Map<String, IconData> kategoriler = {
    'kategoriler.giyim': Icons.checkroom,
    'kategoriler.gida': Icons.restaurant,
    'kategoriler.kozmetik': Icons.brush,
    'kategoriler.akaryakit': Icons.local_gas_station,
    'kategoriler.faturalar': Icons.receipt,
    'kategoriler.teknoloji': Icons.devices
  };

  EkleModel() {
    _harcamalariYukle();
  }

  String? get seciliKategori => _seciliKategori;
  DateTime get seciliTarih => _seciliTarih;
  List<Harcama> get harcamalar => _harcamalar;

  set seciliKategori(String? value) {
    _seciliKategori = value;
    notifyListeners();
  }

  Map<String, IconData> get cevrilmisKategoriler {
    Map<String, IconData> cevrilmis = {};
    kategoriler.forEach((key, value) {
      cevrilmis[key.tr()] = value;
    });
    return cevrilmis;
  }

  List<Harcama> get reversedHarcamalar => _harcamalar.reversed.toList();

  bool get isButtonEnabled =>
      tutarController.text.isNotEmpty &&
      aciklamaController.text.isNotEmpty &&
      _seciliKategori != null;

  /// Veritabanından harcamaları yükle
  void _harcamalariYukle() {
    _harcamalar = ObjectBoxService.instance.tumHarcamalariGetir();
    notifyListeners();
  }

  /// Harcamaları yenile
  void harcamalariYenile() {
    _harcamalariYukle();
  }

  /// Takvim açıp tarih seç
  Future<void> tarihSec(BuildContext context) async {
    final DateTime? secilen = await showDatePicker(
      context: context,
      initialDate: _seciliTarih,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (secilen != null) {
      _seciliTarih = secilen;
      notifyListeners();
    }
  }

  /// Harcama ekle
  void harcamaEkle() {
    final String aciklama = aciklamaController.text.trim();
    final double? tutar = double.tryParse(tutarController.text.trim());
    final kategori = _seciliKategori;
    final tarih = _seciliTarih;

    if (aciklama.isNotEmpty && tutar != null && kategori != null) {
      // Kategori anahtarını bul
      String kategoriAnahtar = kategori;
      kategoriler.forEach((key, value) {
        if (key.tr() == kategori) {
          kategoriAnahtar = key;
        }
      });

      // Yeni harcama oluştur
      final yeniHarcama = Harcama.withIcon(
        kategori: kategori,
        aciklama: aciklama,
        tutar: tutar,
        ikon: kategoriler[kategoriAnahtar] ?? Icons.shopping_cart,
        tarih: tarih,
      );

      // ObjectBox'a kaydet
      ObjectBoxService.instance.harcamaEkle(yeniHarcama);

      // Listeyi güncelle ve formu temizle
      _harcamalariYukle();
      _formTemizle();
    }
  }

  // Harcama sil
  void harcamaSil(int id) {
    ObjectBoxService.instance.harcamaSil(id);
    _harcamalariYukle();
  }

  void harcamaSilFonk(BuildContext context, int id, String kategori) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Harcamayı Sil !'),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          titleTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary, fontSize: 20),
          content: const Text('Bu harcamayı silmeye emin misiniz?'),
          contentTextStyle: TextStyle(
              fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onSurface),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error),
              onPressed: () {
                Navigator.of(context).pop();

                ObjectBoxService.instance.harcamaSil(id);
                _harcamalariYukle();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Harcama silindi'),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Sil'),
            ),
          ],
        );
      },
    );
  }

  /// Tüm harcamaları sil
  void tumHarcamalariSil() {
    ObjectBoxService.instance.tumHarcamalariSil();
    _harcamalariYukle();
  }

  /// Formu temizle
  void _formTemizle() {
    tutarController.clear();
    aciklamaController.clear();
    _seciliKategori = null;
    _seciliTarih = DateTime.now();
    notifyListeners();
  }

  @override
  void dispose() {
    tutarController.dispose();
    aciklamaController.dispose();
    super.dispose();
  }
}

class Ekle extends StatelessWidget {
  const Ekle({super.key});

  @override
  Widget build(BuildContext context) {
    return const EkleView();
  }
}
