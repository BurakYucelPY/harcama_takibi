import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class OrtakWidgets {
  // ============================================
  // İSTATİSTİKLER SAYFA WIDGET'LARI (istatistikler_view.dart'tan)
  // ============================================

  /// İstatistikler sayfasındaki küçük olan kart
  static Widget buildIstatistikOzetKart(
      String baslik, String deger, IconData icon, Color renk) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: renk, size: 28),
            const SizedBox(height: 8),
            Text(
              baslik,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              deger,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// İstatistikler sayfasındaki büyük olan kart
  static Widget buildBuyukOzetKart(
    Map<String, dynamic> enCokHarcananKategoriData,
    Map<String, IconData> ikonlar,
    BuildContext context,
  ) {
    final kategoriAdi = enCokHarcananKategoriData['kategori'] as String;
    final kategoriTutar = enCokHarcananKategoriData['tutar'] as double;
    final kategoriIcon = ikonlar[kategoriAdi] ?? Icons.shopping_cart;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // İkon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                kategoriIcon,
                color: Colors.green.shade600,
                size: 24,
              ),
            ),

            const SizedBox(width: 16),

            // Bilgiler
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'istatistikler_page.en_cok_harcanan'.tr(),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    kategoriAdi,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${kategoriTutar.toStringAsFixed(2)} ₺',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================
  // DİL SAYFA WIDGET'LARI (dil_view.dart'tan)
  // ============================================

  /// Dil seçimi kartı widget'ı
  static Widget buildDilKart(String dil, String kod, String bayrak,
      String seciliDil, Function(String) onDilSecildi) {
    final isSelected = seciliDil == dil;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Card(
        elevation: isSelected ? 4 : 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isSelected ? Colors.green.shade400 : Colors.transparent,
            width: 2,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => onDilSecildi(dil),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(bayrak, style: const TextStyle(fontSize: 28)),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dil,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color:
                              isSelected ? Colors.green.shade700 : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        kod,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        isSelected ? Colors.green.shade600 : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? Colors.green.shade600
                          : Colors.grey.shade400,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
