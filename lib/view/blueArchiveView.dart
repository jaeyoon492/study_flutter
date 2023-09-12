import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_flutter/model/blueArchive.dart';
import 'package:study_flutter/viewModel/blueArchiveViewModel.dart';

class BlueArchiveView extends StatefulWidget {
  const BlueArchiveView({super.key});

  @override
  State<BlueArchiveView> createState() => _BlueArchiveViewState();
}

class _BlueArchiveViewState extends State<BlueArchiveView> {
  late List<Character> characterList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BlueArchive"),
      ),
      body: Consumer<BlueArchiveViewModel>(builder: (context, provider, child) {
        characterList = provider.characterList;
        return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: characterList.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(20),
                width: 400,
                height: 400,
                color: Colors.black38,
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      characterList.elementAt(index).photoUrl as String),
                ),
              );
            });
      }),
    );
  }
}
