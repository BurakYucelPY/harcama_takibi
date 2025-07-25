import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:provider/provider.dart';
import 'Route/routing.dart';
import 'screens/Ekle/ekle.dart';
import 'db/objectbox_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // EasyLocalization başlat
  await EasyLocalization.ensureInitialized();

  // ObjectBox başlat
  await ObjectBoxService.instance.init();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('tr'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('tr'),
      assetLoader: const YamlAssetLoader(),
      child: ChangeNotifierProvider(
        create: (context) => EkleModel(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Harcama Takibi',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: router,
    );
  }
}
