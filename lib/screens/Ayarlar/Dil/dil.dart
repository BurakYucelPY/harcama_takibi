import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:harcama_takibi/screens/Ayarlar/Dil/dil_view.dart';

class DilProvider extends ChangeNotifier {
  String _seciliDil = 'Türkçe';

  String get seciliDil => _seciliDil;

  void initializeDil(BuildContext context) {
    // Mevcut dili tespit et
    if (context.locale.languageCode == 'en') {
      _seciliDil = 'İngilizce';
    } else {
      _seciliDil = 'Türkçe';
    }
    notifyListeners();
  }

  Future<void> dilDegistir(String yeniDil, BuildContext context) async {
    _seciliDil = yeniDil;

    // Dil değiştirme
    if (yeniDil == 'Türkçe') {
      context.setLocale(const Locale('tr'));
    } else if (yeniDil == 'İngilizce') {
      context.setLocale(const Locale('en'));
    }

    notifyListeners();
    await EasyLocalization.ensureInitialized();
  }

  void showUnsupportedLanguageMessage(BuildContext context, String dil) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$dil dili henüz desteklenmiyor  :('),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  void selectTurkish(BuildContext context) {
    dilDegistir('Türkçe', context);
  }

  void selectEnglish(BuildContext context) {
    dilDegistir('İngilizce', context);
  }

  void selectSpanish(BuildContext context) {
    showUnsupportedLanguageMessage(context, 'İspanyolca');
  }

  void selectGerman(BuildContext context) {
    showUnsupportedLanguageMessage(context, 'Almanca');
  }

  void selectArabic(BuildContext context) {
    showUnsupportedLanguageMessage(context, 'Arapça');
  }

  void selectChinese(BuildContext context) {
    showUnsupportedLanguageMessage(context, 'Çince');
  }
}

class Dil extends StatefulWidget {
  const Dil({super.key});

  @override
  State<Dil> createState() => _DilState();
}

class _DilState extends State<Dil> {
  late DilProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = DilProvider();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _provider.initializeDil(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: const DilView(),
    );
  }

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }
}
