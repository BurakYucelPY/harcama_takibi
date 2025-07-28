import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:harcama_takibi/widgets/etkilesimli_grafik_widget.dart';
import 'package:harcama_takibi/fonks.dart';
import '../../widgets/ortak_widgets.dart';

class IstatistiklerView extends StatelessWidget {
  final Map<String, double> grafikVerisi;
  final Map<String, IconData> ikonlar;
  final List<Map<String, dynamic>> listeVerisi;
  final String zamanAraligi;
  final int aktifGrafik;
  final Function(String) onZamanAraligiDegisti;
  final VoidCallback onGrafikDegisti;
  final String toplamHarcama;
  final int kategoriSayisi;
  final Map<String, dynamic> enCokHarcananKategoriData;

  const IstatistiklerView({
    super.key,
    required this.grafikVerisi,
    required this.ikonlar,
    required this.listeVerisi,
    required this.zamanAraligi,
    required this.aktifGrafik,
    required this.onZamanAraligiDegisti,
    required this.onGrafikDegisti,
    required this.toplamHarcama,
    required this.kategoriSayisi,
    required this.enCokHarcananKategoriData,
  });

  @override
  Widget build(BuildContext context) {
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
          'istatistikler'.tr(),
          style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.primary),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () => anaDrawerAc(context),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(25),
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: ['Gün', 'Ay', 'Yıl'].map((originalText) {
                  bool isSelected = originalText == zamanAraligi;

                  String displayText = '';
                  if (originalText == 'Gün') {
                    displayText = 'istatistikler_page.gun'.tr();
                  } else if (originalText == 'Ay') {
                    displayText = 'istatistikler_page.ay'.tr();
                  } else if (originalText == 'Yıl') {
                    displayText = 'istatistikler_page.yil'.tr();
                  }

                  return GestureDetector(
                    onTap: () => onZamanAraligiDegisti(originalText),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                )
                              ]
                            : null,
                      ),
                      child: Text(
                        displayText,
                        style: TextStyle(
                          color: isSelected
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.primary,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            height: 325,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                padding:
                    const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Center(
                            child: aktifGrafik == 0
                                ? EtkilesimliPastaGrafigi(
                                    kategoriVerisi: grafikVerisi,
                                    kategoriIkonlari: ikonlar,
                                  )
                                : EtkilesimliCubukGrafigi(
                                    veri: listeVerisi,
                                    ikonlar: ikonlar,
                                  ),
                          ),
                          Positioned(
                            left: 5,
                            child: IconButton(
                              onPressed: onGrafikDegisti,
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Theme.of(context).colorScheme.primary,
                                size: 30,
                              ),
                            ),
                          ),
                          Positioned(
                            right: -5,
                            child: IconButton(
                              onPressed: onGrafikDegisti,
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Theme.of(context).colorScheme.primary,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.analytics,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'istatistikler_page.harcama_ozeti'.tr(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        child: Text(
                          zamanAraligi == 'Gün'
                              ? 'istatistikler_page.gun'.tr()
                              : zamanAraligi == 'Ay'
                                  ? 'istatistikler_page.ay'.tr()
                                  : 'istatistikler_page.yil'.tr(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: OrtakWidgets.buildIstatistikOzetKart(
                          "istatistikler_page.toplam_harcama".tr(),
                          "$toplamHarcama ₺",
                          Icons.account_balance_wallet,
                          Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OrtakWidgets.buildIstatistikOzetKart(
                          "istatistikler_page.kategori_sayisi".tr(),
                          "$kategoriSayisi",
                          Icons.category,
                          Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (enCokHarcananKategoriData['kategori'].isNotEmpty) ...[
                    OrtakWidgets.buildBuyukOzetKart(
                      enCokHarcananKategoriData,
                      ikonlar,
                      context,
                    ),
                  ] else ...[
                    Flexible(
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.info_outline,
                                  size: 40,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.4)),
                              const SizedBox(height: 8),
                              Text(
                                'istatistikler_page.secilen_donemde_harcama_yok'
                                    .tr(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
