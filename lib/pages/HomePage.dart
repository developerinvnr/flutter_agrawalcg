import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String title = 'Home';
  String url = 'http://agrawalcg.com/';
  bool isLoading = true;
  String loadingPer = 'Loading...0%';
  final _key = UniqueKey();


  @override
  void initState() {
    super.initState();
  }
  DateTime currentBackPressTime = DateTime.now();
  Future<bool> _willpop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      _onBasicWaitingAlertPressed(context);
      return Future.value(false);
    }
    return Future.value(true);
  }

  _onBasicWaitingAlertPressed(context) async {
    await Alert(
        context: context,
        title: "Are you sure you want to exit?",
        image: Image.asset("assets/images/agrawalicon.png"),
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            color: Colors.red,
            child: Text(
              "No",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          DialogButton(
            onPressed: () => {
              exit(0),
            },
            color: Colors.green,
            child: Text(
              "Yes",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]
    ).show();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: new AppBar(
        //     title: Text(this.title,style: TextStyle(fontWeight: FontWeight.w700)),centerTitle: true
        // ),
        body: WillPopScope(
          onWillPop: _willpop,
          child: Stack(
            children: <Widget>[
              WebView(
                key: _key,
                initialUrl: this.url,
                onProgress: (value){
                  setState(() {
                    loadingPer = 'loading...${value}%';
                  });
                },
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (finish) {
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
              isLoading ? Center( child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(loadingPer),
                      )
                    ],
                  )
                ],
              ),)
                  : Stack(),
            ],
          ),
        ),
      ),
    );
  }
}