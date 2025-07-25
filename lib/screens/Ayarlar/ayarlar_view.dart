import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../fonks.dart';
import 'ayarlar.dart';

class AyarlarView extends StatelessWidget {
  const AyarlarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AyarlarProvider>(
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
              'ayarlar'.tr(),
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
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                // Tema
                ListTile(
                  leading: const Icon(Icons.palette, color: Colors.purple),
                  title: Text('ayarlar_page.tema'.tr()),
                  subtitle: Text('ayarlar_page.tema_subtitle'.tr()),
                  trailing: Switch(
                    value: provider.isDarkMode,
                    onChanged: (value) => provider.toggleTheme(),
                    activeColor: Colors.green,
                  ),
                  onTap: () => provider.toggleTheme(),
                ),
                const Divider(),

                ListTile(
                  leading: const Icon(Icons.person, color: Colors.black),
                  title: Text('profil'.tr()),
                  subtitle: Text('ayarlar_page.profil_subtitle'.tr()),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => provider.goToProfil(context),
                ),
                const Divider(),

                // Dil
                ListTile(
                  leading: const Icon(Icons.language, color: Colors.blue),
                  title: Text('dil'.tr()),
                  subtitle: Text('ayarlar_page.dil_subtitle'.tr()),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => provider.goToDil(context),
                ),
                const Divider(),

                // Verileri Sıfırla
                ListTile(
                  leading: const Icon(Icons.delete_forever, color: Colors.red),
                  title: Text('ayarlar_page.verileri_sifirla'.tr()),
                  subtitle: Text('ayarlar_page.verileri_sifirla_subtitle'.tr()),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => provider.showDataResetDialog(context),
                ),
                const Divider(),
              ],
            ),
          ),
        );
      },
    );
  }
}
