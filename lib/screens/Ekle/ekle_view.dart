import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'ekle.dart';
import 'package:harcama_takibi/fonks.dart';

class EkleView extends StatelessWidget {
  const EkleView({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<EkleModel>();

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
          'ekle'.tr(),
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
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: ortakDrawer(context),
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: Column(
        children: [
          Expanded(
            child: model.reversedHarcamalar.isEmpty
                ? Center(child: Text("ekle_page.henuz_harcama_yok".tr()))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: model.reversedHarcamalar.length,
                    itemBuilder: (context, index) {
                      final h = model.reversedHarcamalar[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              // Gelecekte bir işlev eklenebilir
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Icon(h.ikon,
                                      size: 32,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(h.kategori,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface)),
                                        Text(h.aciklama,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface
                                                    .withOpacity(0.7))),
                                        const SizedBox(height: 4),
                                        Text(
                                          DateFormat('d MMMM yyyy', 'tr_TR')
                                              .format(h.tarih),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
                                                  .withOpacity(0.6)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "${h.tutar.toStringAsFixed(2)} ₺",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: model.tutarController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "ekle_page.tutar".tr(),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: model.aciklamaController,
                  decoration: InputDecoration(
                    labelText: "ekle_page.aciklama".tr(),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: model.seciliKategori,
                  items: model.cevrilmisKategoriler.entries.map((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.key,
                      child: Row(
                        children: [
                          Icon(entry.value,
                              size: 20,
                              color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 10),
                          Text(entry.key),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    model.seciliKategori = value;
                  },
                  decoration: InputDecoration(
                    labelText: "ekle_page.kategori_sec".tr(),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  onTap: () => model.tarihSec(context),
                  leading: Icon(Icons.calendar_today,
                      color: Theme.of(context).colorScheme.primary),
                  title: Text("ekle_page.tarih".tr()),
                  subtitle: Text(
                    DateFormat('d MMMM yyyy', 'tr_TR')
                        .format(model.seciliTarih),
                  ),
                  trailing: Icon(Icons.arrow_drop_down,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    onPressed: model.isButtonEnabled ? model.harcamaEkle : null,
                    child: Text("ekle_page.harcama_ekle".tr()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
