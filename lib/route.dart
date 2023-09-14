import 'package:go_router/go_router.dart';
import 'package:study_flutter/view/blueArchiveView.dart';

final GoRouter routerConfig = GoRouter(initialLocation: "/", routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const BlueArchiveView(),
  )
]);
