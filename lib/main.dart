import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:study_flutter/route.dart';
import 'package:study_flutter/viewModel/blueArchiveViewModel.dart';
import 'dart:developer' as developer;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return MultiProvider(
  //     providers: [
  //       ChangeNotifierProvider(create: (context) => BlueArchiveViewModel())
  //       // Provider(create: (context) => AppRouter())
  //     ],
  //     // global config
  //     child: MaterialApp(
  //       home: MaterialApp.router(
  //         routerConfig: router,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BlueArchiveViewModel())
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
