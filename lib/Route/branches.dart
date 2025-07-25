import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:harcama_takibi/Route/identify_routes.dart';
import 'package:harcama_takibi/screens/Ayarlar/Dil/dil.dart';
import 'package:harcama_takibi/screens/Ayarlar/Profil/profil.dart';
import 'package:harcama_takibi/screens/Hakk%C4%B1nda/hakkinda.dart';
import '../screens/Anasayfa/anasayfa.dart';
import '../screens/Ekle/ekle.dart';
import '../screens/İstatistikler/istatistikler.dart';
import '../screens/Ayarlar/ayarlar.dart';

final List<StatefulShellBranch> branches = [
  //-------------------------------------------------
  StatefulShellBranch(
    initialLocation: Rotalar.anasayfaPath,
    routes: [
      GoRoute(
        path: Rotalar.anasayfaPath,
        name: Rotalar.anasayfaName,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const Anasayfa(),
        ),
      ),
    ],
  ),
  //-------------------------------------------------
  StatefulShellBranch(
    initialLocation: Rotalar.eklePath,
    routes: [
      GoRoute(
        path: Rotalar.eklePath,
        name: Rotalar.ekleName,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const Ekle(),
        ),
      ),
    ],
  ),
  //-------------------------------------------------
  StatefulShellBranch(
    initialLocation: Rotalar.istatistiklerPath,
    routes: [
      GoRoute(
        path: Rotalar.istatistiklerPath,
        name: Rotalar.istatistiklerName,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const Istatistikler(),
        ),
      ),
    ],
  ),
  //-------------------------------------------------
  StatefulShellBranch(
    initialLocation: Rotalar.ayarlarPath,
    routes: [
      GoRoute(
        path: Rotalar.ayarlarPath,
        name: Rotalar.ayarlarName,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const Ayarlar(),
        ),
        //--------------------
        routes: [
          //--------------------
          GoRoute(
            path: Rotalar.profilPath,
            name: Rotalar.profilName,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const Profil(),
            ),
          ),
          //--------------------
          GoRoute(
            path: Rotalar.dilPath,
            name: Rotalar.dilName,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const Dil(),
            ),
          ),
        ],
      ),
    ],
  ),
  //-------------------------------------------------
  StatefulShellBranch(
    initialLocation: Rotalar.hakkindaPath,
    routes: [
      GoRoute(
        path: Rotalar.hakkindaPath,
        name: Rotalar.hakkindaName,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const Hakkinda(),
        ),
      ),
    ],
  ),
];
