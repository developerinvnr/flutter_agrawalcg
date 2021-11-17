import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String title = 'Home';
  String url = 'http://agrawalcg.com/';
  bool isLoading=true;
  final _key = UniqueKey();

  WebViewState(String title,String url){
    this.title=title;
    this.url=url;
  }

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: new AppBar(
        //     title: Text(this.title,style: TextStyle(fontWeight: FontWeight.w700)),centerTitle: true
        // ),
        body: Stack(
          children: <Widget>[
            WebView(
              key: _key,
              initialUrl: this.url,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
            isLoading ? Center( child: CircularProgressIndicator(),)
                : Stack(),
          ],
        ),
      ),
    );
  }
}