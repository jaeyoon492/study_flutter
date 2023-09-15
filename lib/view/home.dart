import 'package:flutter/material.dart';
import 'package:study_flutter/route.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => router.go('/dummy'),
          child: const Text('go to dummy'),
        ),
      ),
    );
  }
}
