import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_flutter/route.dart';
import 'package:study_flutter/view/blueArchiveView.dart';
import 'package:study_flutter/viewModel/blueArchiveViewModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //     home: ChangeNotifierProvider<BlueArchiveViewModel>(
    //   create: (context) => BlueArchiveViewModel(),
    //   child: const BlueArchiveView(),
    // ));

    return MaterialApp.router(
      routerConfig: routerConfig,
      routeInformationParser: routerConfig.routeInformationParser,
      routeInformationProvider: routerConfig.routeInformationProvider,
      routerDelegate: routerConfig.routerDelegate,
    );
  }
}
