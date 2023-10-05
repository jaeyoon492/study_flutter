import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/proposal_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/sign_client_events.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/sign_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/web3app/web3app.dart';

// ignore: must_be_immutable
class MetaMaskPage extends HookWidget {
  MetaMaskPage({super.key});

  createSession() async {
    Web3App wcClient = await Web3App.createInstance(
      relayUrl:
          'wss://relay.walletconnect.com', // The relay websocket URL, leave blank to use the default
      projectId: '0c446885b2d551cb58df5ff726bca80c',
      metadata: PairingMetadata(
        name: 'dApp (Requester)',
        description: 'A dapp that can request that transactions be signed',
        url: 'https://walletconnect.com',
        icons: ['https://avatars.githubusercontent.com/u/37784886'],
      ),
    );

    ConnectResponse response = await wcClient.connect(requiredNamespaces: {
      'eip155': RequiredNamespace(
        chains: ['eip155:1'], // Ethereum chain
        methods: ['eth_requestAccounts'], // Requestable Methods
        events: ['eth_sendTransaction'], // Requestable Events
      ),
    });

    Uri? uri = response.uri;

    launchUrlString(uri.toString(), mode: LaunchMode.externalApplication);

    final SessionData session = await response.session.future;

    print(session);
    print("----------------------------------------------------");

    // You can also respond to events from the wallet, like session events
    wcClient.onSessionEvent.subscribe((SessionEvent? session) {
      print("연결된");
      print(session?.name);
    });
    wcClient.onSessionConnect.subscribe((args) {
      print("연결된2");
      print(args);
    });
  }

// Create a connector
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                createSession();
              },
              child: const Text("create metamask session"),
            ),
          ],
        ),
      ),
    );
  }
}
