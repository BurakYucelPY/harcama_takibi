import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:harcama_takibi/Route/identify_routes.dart';
import '../../db/objectbox_service.dart';
import '../Ekle/ekle.dart';
import 'ayarlar_view.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

class AyarlarProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeData get lightTheme {
    return FlexColorScheme.light(
      scheme: FlexScheme.jungle,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 7,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      tertiary: const Color(0xFFE8F5E8),
    ).toTheme;
  }

  ThemeData get darkTheme {
    return FlexColorScheme.dark(
      scheme: FlexScheme.jungle,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 13,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      tertiary: const Color(0xFF1A2E1A),
    ).toTheme;
  }

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
          backgroundColor: Theme.of(context).colorScheme.surface,
          titleTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary, fontSize: 24),
          content: const Text('Tüm verileri temizlenecek ve sıfırlanacak.'),
          contentTextStyle: TextStyle(
              fontSize: 20, color: Theme.of(context).colorScheme.onSurface),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.primary),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.primary),
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
    final silinenSayisi = ObjectBoxService.instance.tumHarcamalariSil();

    final ekleModel = context.read<EkleModel>();
    ekleModel.harcamalariYenile();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$silinenSayisi harcama kaydı silindi'),
        backgroundColor: Theme.of(context).colorScheme.primary,
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
  @override
  Widget build(BuildContext context) {
    return Consumer<AyarlarProvider>(
      builder: (context, provider, child) {
        return const AyarlarView();
      },
    );
  }
}
