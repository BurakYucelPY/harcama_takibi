import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../fonks.dart';
import '../../../widgets/ortak_widgets.dart';
import 'dil.dart';

class DilView extends StatelessWidget {
  const DilView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DilProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.green.shade100,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            title: Text(
              'dil'.tr(),
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.green,
              ),
            ),
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(
                  Icons.person,
                  color: Colors.green.shade700,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          ),
          drawer: ortakDrawer(context),
          backgroundColor: Colors.brown.shade50,
          body: Column(
            children: [
              // Üst başlık
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade400, Colors.green.shade600],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.shade300.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(Icons.language, color: Colors.white, size: 32),
                    const SizedBox(height: 8),
                    Text(
                      'dil_page.language_selection'.tr(),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // Dil listesi
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    OrtakWidgets.buildDilKart(
                      'Türkçe',
                      'TR',
                      '🇹🇷',
                      provider.seciliDil,
                      (dil) => provider.selectTurkish(context),
                    ),
                    OrtakWidgets.buildDilKart(
                      'İngilizce',
                      'EN',
                      '🇬🇧',
                      provider.seciliDil,
                      (dil) => provider.selectEnglish(context),
                    ),
                    OrtakWidgets.buildDilKart(
                      'İspanyolca',
                      'ES',
                      '🇪🇸',
                      '',
                      (dil) => provider.selectSpanish(context),
                    ),
                    OrtakWidgets.buildDilKart(
                      'Almanca',
                      'DE',
                      '🇩🇪',
                      '',
                      (dil) => provider.selectGerman(context),
                    ),
                    OrtakWidgets.buildDilKart(
                      'Arapça',
                      'AR',
                      '🇸🇦',
                      '',
                      (dil) => provider.selectArabic(context),
                    ),
                    OrtakWidgets.buildDilKart(
                      'Çince',
                      'ZH',
                      '🇨🇳',
                      '',
                      (dil) => provider.selectChinese(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
