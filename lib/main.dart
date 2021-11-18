import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
const kAndroidUserAgent = 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

String selectedUrl = 'http://agrawalcg.com/';

// ignore: prefer_collection_literals
final Set<JavascriptChannel> jsChannels = [
  JavascriptChannel(
      name: 'Print',
      onMessageReceived: (JavascriptMessage message) {
        print(message.message);
      }),
].toSet();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  DateTime currentBackPressTime = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _willpop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      //_onBasicWaitingAlertPressed(context);
      return Future.value(false);
    }
    return Future.value(true);
  }


  // _onBasicWaitingAlertPressed(context) async {
  //   await Alert(
  //       context: context,
  //       title: "Are you sure you want to exit?",
  //       image: Image.asset("assets/images/agrawalicon.png"),
  //       buttons: [
  //         DialogButton(
  //           onPressed: () => Navigator.pop(context),
  //           color: Colors.red,
  //           child: Text(
  //             "No",
  //             style: TextStyle(color: Colors.white, fontSize: 20),
  //           ),
  //         ),
  //         DialogButton(
  //           onPressed: () => {
  //             exit(0),
  //           },
  //           color: Colors.green,
  //           child: Text(
  //             "Yes",
  //             style: TextStyle(color: Colors.white, fontSize: 20),
  //           ),
  //         )
  //       ]
  //   ).show();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgrawalCG',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WillPopScope(
        onWillPop: _willpop,
        child: SafeArea(
          child: WebviewScaffold(
            url: "http://agrawalcg.com/",
            ignoreSSLErrors: true,
            appCacheEnabled: true,
            supportMultipleWindows: true,
            withJavascript: true,
          ),
        ),
      ),
    );
  }
}