import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:web3dart/web3dart.dart';

class MetamaskProvider with ChangeNotifier {
  var apiUrl =
      "https://eth-sepolia.g.alchemy.com/v2/a_-D9iVA1DuWiNDZJCJVG1qPe1bbn_t3";
  var httpClient = Client();
  late Web3Client ethClient;

  late Wallet wallet;

  var clientReady = false;

  var address;
  var credentials = EthPrivateKey.fromHex(
      "9130edb41c56a32e740b50a784b416344ffc79dde1a44a7b1d6f607cd73716bd");

  MetamaskProvider() {
    // print("init metamask provider");

    // address = credentials.address;
    // ethClient = Web3Client(apiUrl, httpClient);

    // clientReady = true;

    // notifyListeners();
  }

  getBalance() async {
    EtherAmount balance = await ethClient.getBalance(address);
    print(balance);
  }
}
