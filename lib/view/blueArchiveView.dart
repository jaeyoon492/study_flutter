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
  late List<Character>? characterList;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(title: Text("Blue Archive View")),
        body:
            Consumer<BlueArchiveViewModel>(builder: (context, provider, child) {
          characterList = provider.characterList;

          return Stack(
            children: [
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: characterList?.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      width: 300,
                      height: 400,
                      color: Colors.black38,
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            characterList?.elementAt(index).photoUrl as String),
                      ),
                    );
                  }),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 5),
                  width: screenWidth * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      provider.fetchNext();
                    },
                    child: const Text("More"),
                  ),
                ),
              ),
            ],
          );
        }));
  }
}
