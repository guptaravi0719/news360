import 'package:flutter/material.dart';
import 'package:novum/src/ui/screens/article_web_view.dart';
import 'package:novum/src/ui/screens/count_for_ads.dart';
import 'package:novum/src/ui/screens/slide_right_route.dart';
import '../../../version-check.dart';
import '../../models/article_model.dart';
import './image_placeholder.dart';
import './fade_route.dart';

import 'package:transparent_image/transparent_image.dart';

import 'package:firebase_admob/firebase_admob.dart';


class ArticleTile extends StatefulWidget {
  ArticleTile({
    this.article,
    this.title,
    this.thumbnail,
    this.published,
    this.expanded,
  });

  ArticleTile.fromArticleModel(ArticleModel article, BuildContext context,
      {bool expanded: false})
      : article = article,
        title = Text(cleanTitle(article.title),
            style: Theme.of(context).textTheme.body1.copyWith(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                )),
        thumbnail = article.imageUrl != null
            ? FadeInImage.memoryNetwork(
                image: article.imageUrl,
                placeholder: kTransparentImage,
                fit: BoxFit.cover,
              )
            : ImagePlaceholder('No image.'),
        published = Text(
          _timestamp(article.published),
          style: Theme.of(context).textTheme.subtitle.copyWith(
            color: Colors.grey,
                fontSize: 14.0,
              ),
        ),
        expanded = expanded;

  final ArticleModel article;
  final Widget title;
  final Widget thumbnail;
  final Widget published;
  final bool expanded;

  @override
  _ArticleTileState createState() => _ArticleTileState();

  static String cleanTitle(String originalTitle) {
    List<String> split = originalTitle.split(' - ');
    return split[0];
  }

  /// Returns the article's published date in a readable
  /// form.
  static String _timestamp(DateTime oldDate) {
    String timestamp;
    DateTime currentDate = DateTime.now();
    Duration difference = currentDate.difference(oldDate);
    if (difference.inSeconds < 60) {
      timestamp = 'Now';
    } else if (difference.inMinutes < 60) {
      timestamp = '${difference.inMinutes}M';
    } else if (difference.inHours < 24) {
      timestamp = '${difference.inHours}H';
    } else if (difference.inDays < 30) {
      timestamp = '${difference.inDays}D';
    }
    return timestamp;
  }
}

class _ArticleTileState extends State<ArticleTile> {
  static const List<String> testDevice = ["A758460DDBEFAE12C800CF559072910E"];
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? testDevice : null,
    childDirected: true,
    nonPersonalizedAds: true,
  );

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: "ca-app-pub-3945166141600873/8216343006",
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
      },
    );
  }
  Widget build(BuildContext context) {
    InterstitialAd interstitialAd;
    interstitialAd=createInterstitialAd();
    Route currentRoute;
    Navigator.popUntil(context, (route) {
      currentRoute = route;
      return true;
    });
    final String category = currentRoute.settings.name != '/search' &&
            currentRoute.settings.name != null
        ? currentRoute.settings.name.replaceAll('/', '')
        : null;
    return InkWell(
      onTap: () {

        versionCheck(context);

        ArticleClickcountForInterstitialAd++;
        if (ArticleClickcountForInterstitialAd>10){
          ArticleClickcountForInterstitialAd=0;
        }

          debugPrint("$ArticleClickcountForInterstitialAd");
        if(ArticleClickcountForInterstitialAd%5==0){

         interstitialAd..load()..show();
         //  Navigator.push(context, FadeRoute(Article(widget.article, category: category)));
        SlideRightRoute(widget: ArticleWebView(title: widget.article.title,url:widget.article.url,));
        }
        else {
        Navigator.push(
            context, FadeRoute(ArticleWebView(title: widget.article.title,url:widget.article.url,)));
       //   SlideRightRoute(widget: ArticleWebView(title: widget.article.title,url:widget.article.url,));
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: widget.expanded ? _expandedTile() : _compactTile(),
      ),
    );
  }

  Widget _expandedTile() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Thumbnail.
        ClipRRect(

          borderRadius: BorderRadius.circular(8.0),
          child: Flexible(
            flex: 3,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                AspectRatio(
                    aspectRatio: 4.0 / 3.0,
                    child: Container(color: Colors.black26)),
                AspectRatio(aspectRatio: 4.0 / 3.0, child: widget.thumbnail),
              ],
            ),
          ),
        ),

        // Title and timestamp.
        Flexible(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: widget.published),
              widget.title,
            ],
          ),
        ),
      ],
    );
  }

  Widget _compactTile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[

        Flexible(
          flex: 1,
          child: Stack(
          alignment: Alignment.center,
            children: <Widget>[
              AspectRatio(
                  aspectRatio: 1.0 / 1.0,
                  child: Container(color: Colors.black26)),
              AspectRatio(aspectRatio: 1.0 / 1.0, child: widget.thumbnail),
            ],
          ),
        ),
        Flexible(
           flex: 1,
          child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: widget.published),
                widget.title,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
