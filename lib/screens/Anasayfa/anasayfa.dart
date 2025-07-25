import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../Ekle/ekle.dart';
import 'anasayfa_view.dart';
import 'package:harcama_takibi/db/harcama.dart';

class AnasayfaProvider extends ChangeNotifier {
  // Hesaplama metodları
  List<Harcama> getBugunkunHarcamalar(List<Harcama> harcamalar) {
    DateTime bugun = DateTime.now();
    return harcamalar.where((h) {
      return h.tarih.day == bugun.day &&
          h.tarih.month == bugun.month &&
          h.tarih.year == bugun.year;
    }).toList();
  }

  List<Harcama> getBuAykiHarcamalar(List<Harcama> harcamalar) {
    DateTime bugun = DateTime.now();
    return harcamalar.where((h) {
      return h.tarih.month == bugun.month && h.tarih.year == bugun.year;
    }).toList();
  }

  List<Harcama> getSonHarcamalar(List<Harcama> harcamalar) {
    return harcamalar.reversed.take(5).toList();
  }

  double getToplam(List<Harcama> harcamalar) {
    return harcamalar.fold(0, (sum, h) => sum + h.tutar);
  }

  Map<String, dynamic> getEnCokKullanilanKategori(
      List<Harcama> harcamalar, Map<String, IconData> kategoriler) {
    Map<String, double> kategoriToplamlari = {};
    for (var harcama in harcamalar) {
      kategoriToplamlari.update(
        harcama.kategori,
        (value) => value + harcama.tutar,
        ifAbsent: () => harcama.tutar,
      );
    }

    String enCokKullanilanKategori = "";
    double enYuksekTutar = 0;
    IconData kategoriIkonu = Icons.shopping_cart;

    if (kategoriToplamlari.isNotEmpty) {
      var enCokHarcanan = kategoriToplamlari.entries
          .reduce((a, b) => a.value > b.value ? a : b);
      enCokKullanilanKategori = enCokHarcanan.key;
      enYuksekTutar = enCokHarcanan.value;

      // Kategori ikonu bul
      kategoriler.forEach((key, value) {
        if (key.tr() == enCokKullanilanKategori) {
          kategoriIkonu = value;
        }
      });
    }

    return {
      'kategori': enCokKullanilanKategori,
      'ikon': kategoriIkonu,
      'tutar': enYuksekTutar,
    };
  }
}

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  late AnasayfaProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = AnasayfaProvider();
  }

  @override
  Widget build(BuildContext context) {
    final ekleModel = context.watch<EkleModel>(); // Dil değişimini dinler

    return ChangeNotifierProvider.value(
      value: _provider,
      child: Builder(
        builder: (context) {
          final anasayfaProvider = Provider.of<AnasayfaProvider>(context);

          // Hesaplamalar
          final bugunkunHarcamalar =
              anasayfaProvider.getBugunkunHarcamalar(ekleModel.harcamalar);
          final buAykiHarcamalar =
              anasayfaProvider.getBuAykiHarcamalar(ekleModel.harcamalar);
          final sonHarcamalar =
              anasayfaProvider.getSonHarcamalar(ekleModel.harcamalar);
          final bugunkunToplam = anasayfaProvider.getToplam(bugunkunHarcamalar);
          final buAykiToplam = anasayfaProvider.getToplam(buAykiHarcamalar);
          final enCokKategoriData = anasayfaProvider.getEnCokKullanilanKategori(
              buAykiHarcamalar, ekleModel.kategoriler);

          return AnasayfaView(
            bugunkunToplam: bugunkunToplam,
            buAykiToplam: buAykiToplam,
            bugunkunHarcamaSayisi: bugunkunHarcamalar.length,
            toplamHarcamaSayisi: ekleModel.harcamalar.length,
            enCokKullanilanKategori: enCokKategoriData['kategori'],
            enCokKategoriBelirteci: enCokKategoriData['ikon'],
            sonHarcamalar: sonHarcamalar,
            kategoriler: ekleModel.kategoriler,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }
}
