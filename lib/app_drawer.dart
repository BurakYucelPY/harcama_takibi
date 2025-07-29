import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:harcama_takibi/Route/identify_routes.dart';

abstract class AppDrawer {
  static GlobalKey<ScaffoldState>? _mainScaffoldKey;
  static GlobalKey<ScaffoldState> get key =>
      _mainScaffoldKey ??= GlobalKey<ScaffoldState>();

  static void close() {
    key.currentState?.closeDrawer();
  }

  static void open() {
    key.currentState?.openDrawer();
  }

  static Widget build(BuildContext context) => Drawer(
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
              leading: Icon(Icons.person,
                  color: Theme.of(context).colorScheme.primary),
              title: Text('profil'.tr()),
              onTap: () {
                Navigator.pop(context);
                context.goNamed(Rotalar.profilName);
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.info,
                  color: Theme.of(context).colorScheme.primary),
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
