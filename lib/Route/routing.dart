import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:harcama_takibi/Route/identify_routes.dart';
import 'package:harcama_takibi/screens/Login/login.dart';
import 'package:harcama_takibi/screens/Login/Register/register.dart';
import 'branches.dart';
import '../fonks.dart';

GoRouter router = GoRouter(
  initialLocation: Rotalar.loginPath,
  routes: [
    GoRoute(
      path: Rotalar.loginPath,
      name: Rotalar.loginName,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const Login(),
      ),
      routes: [
        GoRoute(
          path: Rotalar.registerPath,
          name: Rotalar.registerName,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const Register(),
          ),
        ),
      ],
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Scaffold(
          key: ValueKey('shell_${context.locale.languageCode}'),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          drawer: ortakDrawer(context),
          body: Container(
            key: ValueKey('body_${context.locale.languageCode}'),
            child: navigationShell,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: BottomAppBar(
              color: Colors.transparent,
              elevation: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: navigationShell.currentIndex == 0
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.6),
                    ),
                    onPressed: () {
                      drawerKapat(context);
                      navigationShell.goBranch(0,
                          initialLocation: (navigationShell.currentIndex == 0));
                    },
                    iconSize: navigationShell.currentIndex == 0 ? 37 : 35,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      color: navigationShell.currentIndex == 1
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.6),
                    ),
                    onPressed: () {
                      drawerKapat(context);
                      navigationShell.goBranch(1,
                          initialLocation: (navigationShell.currentIndex == 1));
                    },
                    iconSize: navigationShell.currentIndex == 1 ? 37 : 35,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.bar_chart,
                      color: navigationShell.currentIndex == 2
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.6),
                    ),
                    onPressed: () {
                      drawerKapat(context);
                      navigationShell.goBranch(2,
                          initialLocation: (navigationShell.currentIndex == 2));
                    },
                    iconSize: navigationShell.currentIndex == 2 ? 37 : 35,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: navigationShell.currentIndex == 3
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.6),
                    ),
                    onPressed: () {
                      drawerKapat(context);
                      navigationShell.goBranch(3,
                          initialLocation: (navigationShell.currentIndex == 3));
                    },
                    iconSize: navigationShell.currentIndex == 3 ? 37 : 35,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      branches: branches,
    ),
  ],
);
