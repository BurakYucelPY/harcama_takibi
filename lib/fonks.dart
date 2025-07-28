import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:harcama_takibi/Route/identify_routes.dart';

final GlobalKey<ScaffoldState> mainScaffoldKey = GlobalKey<ScaffoldState>();

void drawerKapat(BuildContext context) {
  if (Scaffold.maybeOf(context)?.isDrawerOpen == true) {
    Scaffold.of(context).closeDrawer();
  }
}

void anaDrawerAc(BuildContext context) {
  // Global key ile direkt ana scaffold'a erişiyoor
  mainScaffoldKey.currentState?.openDrawer();
}

Drawer ortakDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(
            'drawer.kullanici_adi'.tr(),
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.surface),
          ),
          accountEmail: Text(
            'drawer.kullanici_email'.tr(),
            style: TextStyle(color: Theme.of(context).colorScheme.surface),
          ),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Icon(
              Icons.person,
              size: 40,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        ListTile(
          leading:
              Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
          title: Text('profil'.tr()),
          onTap: () {
            Navigator.pop(context);
            context.goNamed(Rotalar.profilName);
          },
        ),
        const Divider(),
        ListTile(
          leading:
              Icon(Icons.info, color: Theme.of(context).colorScheme.primary),
          title: Text('hakkinda'.tr()),
          onTap: () {
            Navigator.pop(context);
            context.goNamed(Rotalar.hakkindaName);
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app,
              color: Theme.of(context).colorScheme.error),
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
