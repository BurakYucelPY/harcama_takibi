import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:harcama_takibi/Route/identify_routes.dart';
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
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            title: Text(
              'ayarlar'.tr(),
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
                onPressed: () => anaDrawerAc(context),
              ),
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.palette,
                      color: Theme.of(context).colorScheme.secondary),
                  title: Text('ayarlar_page.tema'.tr()),
                  subtitle: Text('ayarlar_page.tema_subtitle'.tr()),
                  trailing: Switch(
                    value: provider.isDarkMode,
                    onChanged: (value) => provider.toggleTemaTus(),
                    activeColor: Theme.of(context).colorScheme.primary,
                  ),
                  onTap: () => provider.toggleTemaTus(),
                ),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.person,
                      color: Theme.of(context).colorScheme.onSurface),
                  title: Text('profil'.tr()),
                  subtitle: Text('ayarlar_page.profil_subtitle'.tr()),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => context.goNamed(Rotalar.profilName),
                ),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.language,
                      color: Theme.of(context).colorScheme.primary),
                  title: Text('dil'.tr()),
                  subtitle: Text('ayarlar_page.dil_subtitle'.tr()),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => context.goNamed(Rotalar.dilName),
                ),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.delete_forever,
                      color: Theme.of(context).colorScheme.error),
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
