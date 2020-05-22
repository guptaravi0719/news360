import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';

class ArticleWebView extends StatefulWidget {

  String url;
  String title;

  ArticleWebView(

      { this.url, this.title}
      );

  @override
  _ArticleWebViewState createState() => _ArticleWebViewState();
}

class _ArticleWebViewState extends State<ArticleWebView> {
  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      initialChild: Container(
          //color: Colors.redAccent,
          child: Center(
              child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.asset("assets/loaderA.gif")))),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      url: widget.url,
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.deepPurple),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white10
            : Colors.white,
        actions: <Widget>[
          Padding(
            child: GestureDetector(
              child: Icon(
                Icons.share,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.deepPurple,
              ),
              onTap: () {
                Share.share(widget.url +
                    "\n Download this app and read News articles daily, It has Live TV too.\n" +
                    "\nhttps://play.google.com/store/apps/details?id=com.toolsfortools.news360");
              },
            ),
            padding: EdgeInsets.only(right: 20.0),
          )
        ],
        title: new Text(
          widget.title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontFamily: 'Eczar',
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black87),
        ),
      ),
    );
  }
}
