import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
          backgroundColor: Colors.brown.shade50,

          // ----------------------------------------------------------------
          body: navigationShell,
          // ----------------------------------------------------------------
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.green.shade100,
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
                          ? Colors.green.shade700
                          : Colors.grey,
                    ),
                    onPressed: () {
                      drawerKapat(context);
                      navigationShell.goBranch(0);
                    },
                    iconSize: navigationShell.currentIndex == 0 ? 37 : 35,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      color: navigationShell.currentIndex == 1
                          ? Colors.green.shade700
                          : Colors.grey,
                    ),
                    onPressed: () {
                      drawerKapat(context);
                      navigationShell.goBranch(1);
                    },
                    iconSize: navigationShell.currentIndex == 1 ? 37 : 35,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.bar_chart,
                      color: navigationShell.currentIndex == 2
                          ? Colors.green.shade700
                          : Colors.grey,
                    ),
                    onPressed: () {
                      drawerKapat(context);
                      navigationShell.goBranch(2);
                    },
                    iconSize: navigationShell.currentIndex == 2 ? 37 : 35,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: navigationShell.currentIndex == 3
                          ? Colors.green.shade700
                          : Colors.grey,
                    ),
                    onPressed: () {
                      drawerKapat(context);
                      navigationShell.goBranch(3);
                    },
                    iconSize: navigationShell.currentIndex == 3 ? 37 : 35,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      //---------------------------------------------------------------------
      branches: branches,
    ),
  ],
);
