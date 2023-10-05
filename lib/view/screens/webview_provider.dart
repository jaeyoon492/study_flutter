import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_flutter/viewModel/metamask.dart';
import 'package:url_launcher/url_launcher_string.dart';
// import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';
import 'package:walletconnect_flutter_v2/apis/web3app/web3app.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_secure_storage/walletconnect_secure_storage.dart';
import 'package:web3_provider/web3_provider.dart';
import 'package:web3dart/web3dart.dart';
import 'package:logger/logger.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

import "../../constants.dart";

class WebViewProvider extends StatefulWidget {
  const WebViewProvider({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<WebViewProvider> createState() => _WebViewProviderState();
}

class _WebViewProviderState extends State<WebViewProvider> {
  String? walletAddress;
  int chainId = -1;
  var apiUrl =
      "https://eth-sepolia.g.alchemy.com/v2/a_-D9iVA1DuWiNDZJCJVG1qPe1bbn_t3"; //Replace with your API

  String statusMessage = 'Initialized';
  String _displayUri = ''; // QR Code for OpenConnect but not used

  Web3App? web3app;
  SessionData? session;
  Uri? uri;
  String? url;
  final String deepLink = "metamask://wc?uri=";

  var logger = Logger(printer: SimplePrinter());

  Credentials credentials = EthPrivateKey.fromHex(
      "9130edb41c56a32e740b50a784b416344ffc79dde1a44a7b1d6f607cd73716bd");

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
      userAgent:
          "Mozilla/5.0 (Linux; Android 4.4.4; SAMSUNG-SM-N900A Build/tt) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/33.0.0.0 Mobile Safari/537.36",
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
      domStorageEnabled: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  Future<void> createWalletConnectV2Instance() async {
    try {
      print("intializing");
      web3app = await Web3App.createInstance(
        relayUrl: 'wss://relay.walletconnect.com',
        projectId:
            '0c446885b2d551cb58df5ff726bca80c', //jmquilez28 personal -- //'68a8e2955516fa9847a032b3e4b0bdf5', --> //'2672792a5a3e5caad0ec346948caaed9'
        metadata: const PairingMetadata(
          name: "jy-dev",
          description: "test wallet",
          url: "https://altava.io/",
          icons: [
            "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.flaticon.com%2Fkr%2Ffree-icon%2Furl_1078454&psig=AOvVaw2FQNz-bOe9NxQ0iqr7I2ft&ust=1695345854549000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCOjTys_FuoEDFQAAAAAdAAAAABAE"
          ],
        ),
      );

      print("initialized");
    } catch (err, stackTrace) {
      print("catch err $stackTrace");
    }
  }

  Uri? formatNativeUrl(String? deepLink, String wcUri) {
    String safeAppUrl = deepLink ?? "";

    if (deepLink != null && deepLink.isNotEmpty) {
      if (!safeAppUrl.contains('://')) {
        safeAppUrl = deepLink.replaceAll('/', '').replaceAll(':', '');
        safeAppUrl = '$safeAppUrl://';
      }
    }

    String encodedWcUrl = Uri.encodeComponent(wcUri);
    print('Encoded WC URL: $encodedWcUrl');

    return Uri.parse('$safeAppUrl$encodedWcUrl');
  }

  loginUsingMetamask(BuildContext context) async {
    if (web3app == null) await createWalletConnectV2Instance();

    try {
      //TODO, CHECK: pop-up takes too long to appear
      ConnectResponse? resp = await web3app?.connect(requiredNamespaces: {
        'eip155': const RequiredNamespace(
          chains: ["eip155:11155111"], // Mumbai chain
          methods: [
            'personal_sign',
            'eth_sign',
            'eth_sendTransaction',
            'eth_signTypedData',
            'eth_sendTransaction',
          ], // Requestable Methods
          events: ["chainChanged", "accountsChanged"], // Requestable Events
        )
      });
      uri = resp?.uri;
      url = uri.toString();
      if (deepLink != null) {
        final link = formatNativeUrl("metamask://wc?uri=", uri.toString());
        url = link.toString();
      }

      if (await canLaunchUrlString(url.toString())) {
        await launchUrlString(url.toString(),
            mode: LaunchMode
                .externalApplication /*LaunchMode.externalNonBrowserApplication*/);
      } else {
        await launchUrlString(
            'https://play.google.com/store/apps/details?id=io.metamask',
            mode: LaunchMode
                .externalNonBrowserApplication /*LaunchMode.inAppWebView*/);
      }
      // TODO, ISSUE: SOMETIMES NOT RETURNING TO APP

      print("returning the wallet response $url");
      //ses = (await resp?.session.future);
      session = (await resp?.session.future);
      print("SessionData ----> ${session.toString()}");

      final String address = NamespaceUtils.getAccount(
        session?.namespaces.values.first.accounts.first ?? "",
      );

      // if (resp.session.isCompleted) {
      print("calling onConnected function :- ${resp?.session.isCompleted}");
      print("---> $address");
      walletAddress = address;

      // onConnected != null ? onConnected() : () {};
      // }
    } catch (err, s) {
      print("error connecting wallet -----> $err, $s");
    }
  }

  signMint() async {
    print("session ->");
    print(session.toString());

    // var tx = Transaction.callContract(
    //   contract: contract,
    //   function: func!,
    //   parameters: params,
    //   gasPrice: null,
    //   nonce: nonce,
    // );

    final tx = jsonEncode([
      {
        "from": "0x645a6b5570fe5a95B52F2c2b5e764E9dDf49Eef6",
        "to": "0x645a6b5570fe5a95B52F2c2b5e764E9dDf49Eef6",
        "data": "0x",
        "gasPrice": "0x029104e28c",
        "value": "0x00"
      }
    ]);

    final signature = await web3app?.request(
      topic: session?.topic ?? "",
      chainId: 'eip155:11155111',
      request: SessionRequestParams(
        method: 'eth_sendTransaction',
        params: jsonDecode(tx),
      ),
    );

    // Timer(Duration(seconds: 2), () {
    //   launchUrlString(deepLink, mode: LaunchMode.externalApplication);
    // });

    print(uri.toString());

    print(signature);
  }

  @override
  void initState() {
    createWalletConnectV2Instance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<MetamaskProvider>(
      builder: (context, provider, child) {
        return InAppWebViewEIP1193(
          // use default provider
          chainId: chainId,
          rpcUrl: apiUrl,
          signCallback: (params, eip1193, controller) {
            final id = params["id"];
            switch (eip1193) {
              case EIP1193.requestAccounts:
                controller?.setAddress(walletAddress ?? "", id);

                print('requestAccounts');
                break;
              case EIP1193.signTransaction:
                print('signTransaction');
                break;
              case EIP1193.signMessage:
              case EIP1193.signPersonalMessage:
                break;
              case EIP1193.signTypedMessage:
                Map<String, dynamic> object = params["object"];
                String raw = object["raw"];
                break;
              case EIP1193.addEthereumChain:
                print('addEthereumChain');
                break;
            }
          },
          initialUrlRequest: URLRequest(
            url: Uri.parse(
              'http://10.190.240.178:3000',
            ),
          ),
          onWebViewCreated: (controller) {
            controller.addJavaScriptHandler(
                handlerName: 'requestAccounts',
                callback: (args) async {
                  loginUsingMetamask(context);
                });
            controller.addJavaScriptHandler(
                handlerName: 'authRequest',
                callback: (args) async {
                  signMint();
                });
          },
          onConsoleMessage: (controller, consoleMessage) {},
        );
      },
    ));
  }
}
