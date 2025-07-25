import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../Ekle/ekle.dart';
import 'istatistikler_view.dart';

class IstatistiklerProvider extends ChangeNotifier {
  String _zamanAraligi = 'Ay'; // Gün, Ay, Yıl
  int _aktifGrafik = 0; // 0: Pie Chart, 1: Çubuk Grafik

  String get zamanAraligi => _zamanAraligi;
  int get aktifGrafik => _aktifGrafik;

  void setZamanAraligi(String yeniDeger) {
    _zamanAraligi = yeniDeger;
    notifyListeners();
  }

  void toggleGrafik() {
    _aktifGrafik = _aktifGrafik == 0 ? 1 : 0;
    notifyListeners();
  }

  // Toplam harcamayı hesapla
  String hesaplaToplamHarcama(List harcamalar) {
    double toplam = 0;
    for (var harcama in harcamalar) {
      toplam += harcama.tutar;
    }
    return toplam.toStringAsFixed(2);
  }

  // En çok harcama yapılan kategoriyi bul
  Map<String, dynamic> enCokHarcananKategori(
      Map<String, double> kategoriToplamlari) {
    if (kategoriToplamlari.isEmpty) {
      return {"kategori": "", "tutar": 0.0};
    }

    var enCokHarcanan =
        kategoriToplamlari.entries.reduce((a, b) => a.value > b.value ? a : b);
    return {
      "kategori": enCokHarcanan.key,
      "tutar": enCokHarcanan.value,
    };
  }

  // Filtrelenmiş harcamaları getir
  List getFilteredHarcamalar(List harcamalar) {
    DateTime simdi = DateTime.now();
    return harcamalar.where((h) {
      if (_zamanAraligi == 'Gün') {
        return h.tarih.day == simdi.day &&
            h.tarih.month == simdi.month &&
            h.tarih.year == simdi.year;
      } else if (_zamanAraligi == 'Ay') {
        return h.tarih.month == simdi.month && h.tarih.year == simdi.year;
      } else if (_zamanAraligi == 'Yıl') {
        return h.tarih.year == simdi.year;
      }
      return false;
    }).toList();
  }

  // Kategori toplamlarını hesapla
  Map<String, double> hesaplaKategoriToplamlari(List harcamalar) {
    Map<String, double> kategoriToplamlari = {};

    for (var harcama in harcamalar) {
      if (kategoriToplamlari.containsKey(harcama.kategori)) {
        kategoriToplamlari[harcama.kategori] =
            kategoriToplamlari[harcama.kategori]! + harcama.tutar;
      } else {
        kategoriToplamlari[harcama.kategori] = harcama.tutar;
      }
    }

    return kategoriToplamlari;
  }

  // İkonları hesapla
  Map<String, IconData> hesaplaIkonlar(
      Map<String, double> kategoriToplamlari, EkleModel model) {
    Map<String, IconData> ikonlar = {};
    kategoriToplamlari.forEach((kategoriAdi, tutar) {
      // Çevrilmiş kategori adından orijinal anahtar bul
      model.kategoriler.forEach((key, value) {
        if (key.tr() == kategoriAdi) {
          ikonlar[kategoriAdi] = value;
        }
      });
      // Eğer bulunamazsa varsayılan ikon kullan
      if (!ikonlar.containsKey(kategoriAdi)) {
        ikonlar[kategoriAdi] = Icons.shopping_cart;
      }
    });
    return ikonlar;
  }

  // Liste verisini hazırla
  List<Map<String, dynamic>> hazirlaListeVerisi(
      Map<String, double> kategoriToplamlari) {
    return kategoriToplamlari.entries
        .map((entry) => {"kategori": entry.key, "tutar": entry.value})
        .toList();
  }
}

class Istatistikler extends StatefulWidget {
  const Istatistikler({super.key});

  @override
  State<Istatistikler> createState() => _IstatistiklerState();
}

class _IstatistiklerState extends State<Istatistikler> {
  late IstatistiklerProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = IstatistiklerProvider();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Consumer2<IstatistiklerProvider, EkleModel>(
        builder: (context, istatistikProvider, ekleModel, child) {
          List harcamalar =
              istatistikProvider.getFilteredHarcamalar(ekleModel.harcamalar);
          Map<String, double> kategoriToplamlari =
              istatistikProvider.hesaplaKategoriToplamlari(harcamalar);
          Map<String, IconData> ikonlar =
              istatistikProvider.hesaplaIkonlar(kategoriToplamlari, ekleModel);
          List<Map<String, dynamic>> listeVerisi =
              istatistikProvider.hazirlaListeVerisi(kategoriToplamlari);

          return IstatistiklerView(
            grafikVerisi: kategoriToplamlari,
            ikonlar: ikonlar,
            listeVerisi: listeVerisi,
            zamanAraligi: istatistikProvider.zamanAraligi,
            aktifGrafik: istatistikProvider.aktifGrafik,
            toplamHarcama: istatistikProvider.hesaplaToplamHarcama(harcamalar),
            kategoriSayisi: kategoriToplamlari.length,
            enCokHarcananKategoriData:
                istatistikProvider.enCokHarcananKategori(kategoriToplamlari),
            onZamanAraligiDegisti: istatistikProvider.setZamanAraligi,
            onGrafikDegisti: istatistikProvider.toggleGrafik,
          );
        },
      ),
    );
  }
}
