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
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            title: Text(
              'dil'.tr(),
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          ),
          drawer: ortakDrawer(context),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          body: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primaryContainer
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(Icons.language,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 32),
                    const SizedBox(height: 8),
                    Text(
                      'dil_page.language_selection'.tr(),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
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
