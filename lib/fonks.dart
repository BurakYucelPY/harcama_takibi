import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:harcama_takibi/Route/identify_routes.dart';

// Drawer'ı kapat
void drawerKapat(BuildContext context) {
  if (Scaffold.maybeOf(context)?.isDrawerOpen == true) {
    Scaffold.of(context).closeDrawer();
  }
}

// Tüm sayfalar için ortak drawer
Drawer ortakDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(
            'drawer.kullanici_adi'.tr(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          accountEmail: Text('drawer.kullanici_email'.tr()),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.brown.shade50,
            child: Icon(
              Icons.person,
              size: 40,
              color: Colors.green.shade600,
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.green.shade700,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: Text('profil'.tr()),
          onTap: () {
            Navigator.pop(context);
            context.goNamed('profil');
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.info),
          title: Text('hakkinda'.tr()),
          onTap: () {
            Navigator.pop(context);
            context.goNamed(Rotalar.hakkindaName);
          },
        ),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: Text('cikis'.tr()),
          onTap: () {
            Navigator.pop(context);
            context.goNamed(Rotalar.loginName);
          },
        ),
      ],
    ),
  );
}
