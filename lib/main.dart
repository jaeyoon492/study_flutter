import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:study_flutter/route.dart';
import 'package:study_flutter/viewModel/blue_archive_view_model.dart';
import 'package:study_flutter/viewModel/metamask.dart';
import 'dart:developer' as developer;

import 'package:study_flutter/viewModel/web_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BlueArchiveViewModel()),
        ChangeNotifierProvider(create: (context) => WebViewModel()),
        ChangeNotifierProvider(create: (context) => MetamaskProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          home: MaterialApp.router(
            routerConfig: router,
          ),
        );
      },
    );
  }
}
