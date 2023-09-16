import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:study_flutter/view/components/scaffold_with_navbar.dart';
import 'package:study_flutter/view/screens/blue_archive_view.dart';
import 'package:study_flutter/view/screens/web_view.dart';
import 'package:study_flutter/view/wallet_connect.dart';
import 'package:study_flutter/view/home.dart';

import 'dart:developer' as developer;

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(
            child: ScaffoldWithNavBar(
          location: state.matchedLocation,
          child: child,
        ));
      },
      routes: [
        GoRoute(
            path: '/',
            name: "HOME",
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: Scaffold(
                  body: Center(child: Home()),
                ),
              );
            }),
        GoRoute(
          path: '/metamask',
          name: "Metamask",
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              child: Scaffold(
                body: Center(
                  child: MetaMaskPage(),
                ),
              ),
            );
          },
        ),
        GoRoute(
          path: '/webview',
          name: "Webview",
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: Scaffold(
                body: Center(
                  child: WebView(),
                ),
              ),
            );
          },
        ),
        GoRoute(
          path: '/blueArchive',
          name: "BlueArchive",
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: Scaffold(
                body: Center(
                  child: BlueArchiveView(),
                ),
              ),
            );
          },
        ),
      ],
    ),
  ],
);
