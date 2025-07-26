import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Harcama {
  @Id()
  int id = 0;

  final String kategori;
  final String aciklama;
  final double tutar;

  // IconData'yı String olarak saklayacağız
  final String ikonAdi;

  @Property(type: PropertyType.date)
  final DateTime tarih;

  // ObjectBox için constructor
  Harcama({
    this.id = 0,
    required this.kategori,
    required this.aciklama,
    required this.tutar,
    required this.ikonAdi,
    required this.tarih,
  });

  // UI için kolay kullanım constructor
  Harcama.withIcon({
    this.id = 0,
    required this.kategori,
    required this.aciklama,
    required this.tutar,
    required IconData ikon,
    required this.tarih,
  }) : ikonAdi = _ikonToString(ikon);

  // IconData'ya dönüştürme
  IconData get ikon => _stringToIconData(ikonAdi);

  // IconData'yı String'e dönüştürme
  static String _ikonToString(IconData ikon) {
    if (ikon == Icons.checkroom) return 'checkroom';
    if (ikon == Icons.restaurant) return 'restaurant';
    if (ikon == Icons.brush) return 'brush';
    if (ikon == Icons.local_gas_station) return 'local_gas_station';
    if (ikon == Icons.receipt) return 'receipt';
    if (ikon == Icons.devices) return 'devices';
    return 'shopping_cart';
  }

  // String'i IconData'ya dönüştürme
  static IconData _stringToIconData(String ikonAdi) {
    switch (ikonAdi) {
      case 'checkroom':
        return Icons.checkroom;
      case 'restaurant':
        return Icons.restaurant;
      case 'brush':
        return Icons.brush;
      case 'local_gas_station':
        return Icons.local_gas_station;
      case 'receipt':
        return Icons.receipt;
      case 'devices':
        return Icons.devices;
      default:
        return Icons.shopping_cart;
    }
  }
}
