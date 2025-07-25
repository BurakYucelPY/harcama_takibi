import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:harcama_takibi/Route/identify_routes.dart';
import '../../db/objectbox_service.dart';
import '../Ekle/ekle.dart';
import 'ayarlar_view.dart';

class AyarlarProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void goToProfil(BuildContext context) {
    context.goNamed(Rotalar.profilName);
  }

  void goToDil(BuildContext context) {
    context.goNamed(Rotalar.dilName);
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void showDataResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('DİKKAT !'),
          backgroundColor: Colors.brown.shade50,
          titleTextStyle: const TextStyle(color: Colors.green, fontSize: 24),
          content: const Text('Tüm verileri temizlenecek ve sıfırlanacak.'),
          contentTextStyle:
              const TextStyle(fontSize: 20, color: Colors.black54),
          actions: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.green),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.green),
              onPressed: () {
                Navigator.of(context).pop();
                _resetData(context);
              },
              child: const Text('Sıfırla'),
            ),
          ],
        );
      },
    );
  }

  void _resetData(BuildContext context) {
    // ObjectBox'tan tüm harcamaları sil
    final silinenSayisi = ObjectBoxService.instance.tumHarcamalariSil();

    // EkleModel'i güncelle
    final ekleModel = context.read<EkleModel>();
    ekleModel.harcamalariYenile();

    // Başarı mesajı göster
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$silinenSayisi harcama kaydı silindi'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class Ayarlar extends StatefulWidget {
  const Ayarlar({super.key});

  @override
  State<Ayarlar> createState() => _AyarlarState();
}

class _AyarlarState extends State<Ayarlar> {
  late AyarlarProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = AyarlarProvider();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: const AyarlarView(),
    );
  }

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }
}
