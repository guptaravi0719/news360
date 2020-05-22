import 'package:flutter/material.dart';
import 'package:novum/LiveTv/live_player.dart';
import 'package:novum/src/ui/components/fade_route.dart';
import 'package:novum/src/ui/screens/browse.dart';
import 'package:novum/src/ui/screens/count_for_ads.dart';
import 'package:novum/src/ui/theme/colors.dart';

String News18India = "O2PMysdmXU8";
String CNBCNewsLiveVideoId = "8LCACOltp6Y";
String News24LiveVideoId = "bYQOy-K1Azc";
String NDTVLiveVideoId = "AFNUeUed8Ro";
String NDTV_India = "l9ViEIip9q4";
String AajTakVideoId = "_QNJA_wFn-o";
String IndiaTOdayVideoId = "l_NIgnb9J2g";
String ABPNewsVideoId = "P7kaBIjvgLk";
String CNNNews18videoId = "OMaPJz50XcA";
String RepublicWorldVideoId = "m_01tHikdy4";
String SkyNewsVideoId = "9Auq9mYxFEE";

class LiveTvGrid extends StatefulWidget {
  @override
  _LiveTvGridState createState() => _LiveTvGridState();
}

class _LiveTvGridState extends State<LiveTvGrid> {
  @override
  void initState() {
    // bannerAd..load()..show();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(


        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .brightness == Brightness.dark ?Colors.white12:Colors.white,

          centerTitle: true,
         automaticallyImplyLeading: false,
          leading: GestureDetector(
onTap: ()=>Navigator.pop(context),
            child: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.deepPurple),
          ),

          title: Text(
              "Live Tv",
              style: Theme
                  .of(context)
                  .textTheme
                  .display4
                  .copyWith(
                fontSize: 24.0,

                //  fontWeight: FontWeight.w50,
              )
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(bottom: 0),
          //MAKE PADDING 50 WHEN ENABLING ADS
          child: new GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              GestureDetector(
                child: Card(
                  elevation: 8.0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset("assets/news18india.png"),
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  TvClickcountForInterstitialAd++;
                  if (TvClickcountForInterstitialAd % 5 == 0) {
                    interstitialAd
                      ..load()
                      ..show();
                  }
                  Navigator.push(
                    context,
                    FadeRoute(
                        YoutubePlayerDemoApp(News18India, "News18 India")),
                  );
                },
              ),
              GestureDetector(
                child: Card(
                  elevation: 8.0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset("assets/NDTV.jpg"),
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  TvClickcountForInterstitialAd++;
                  if (TvClickcountForInterstitialAd % 5 == 0) {
                    interstitialAd
                      ..load()
                      ..show();
                  }
                  Navigator.push(
                    context,
                    FadeRoute(YoutubePlayerDemoApp(NDTV_India, "NDTV India")),
                  );
                },
              ),
              GestureDetector(
                child: Card(
                  elevation: 8.0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.black,
                    child: Image.asset("assets/aajtak.png"),
                  ),
                ),
                onTap: () {
                  TvClickcountForInterstitialAd++;
                  if (TvClickcountForInterstitialAd % 5 == 0) {
                    interstitialAd
                      ..load()
                      ..show();
                  }
                  Navigator.push(
                    context,
                    FadeRoute(YoutubePlayerDemoApp(AajTakVideoId, "Aaj Tak")),
                  );
                },
              ),
              GestureDetector(
                child: Card(
                  elevation: 8.0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset("assets/indiatoday.png"),
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  TvClickcountForInterstitialAd++;
                  if (TvClickcountForInterstitialAd % 5 == 0) {
                    interstitialAd
                      ..load()
                      ..show();
                  }

                  Navigator.push(
                    context,
                    FadeRoute(YoutubePlayerDemoApp(
                        IndiaTOdayVideoId, "India Today Live")),
                  );
                },
              ),
              GestureDetector(
                child: Card(
                  elevation: 8.0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset("assets/news24.jpeg"),
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  TvClickcountForInterstitialAd++;
                  if (TvClickcountForInterstitialAd % 5 == 0) {
                    interstitialAd
                      ..load()
                      ..show();
                  }
                  Navigator.push(
                    context,
                    FadeRoute(
                        YoutubePlayerDemoApp(News24LiveVideoId, "News24")),
                  );
                },
              ),
              GestureDetector(
                child: Card(
                  elevation: 8.0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.black,
                    child: Image.asset("assets/cnbc.jpeg"),
                  ),
                ),
                onTap: () {
                  TvClickcountForInterstitialAd++;
                  if (TvClickcountForInterstitialAd % 5 == 0) {
                    interstitialAd
                      ..load()
                      ..show();
                  }
                  Navigator.push(
                    context,
                    FadeRoute(
                        YoutubePlayerDemoApp(CNBCNewsLiveVideoId, "CNBS news")),

                  );
                },
              ),


              GestureDetector(
                child: Card(
                  elevation: 8.0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset("assets/cnnNews18.jpeg"),
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  TvClickcountForInterstitialAd++;
                  if (TvClickcountForInterstitialAd % 5 == 0) {
                    interstitialAd
                      ..load()
                      ..show();
                  }

                  Navigator.push(
                    context,
                    FadeRoute(YoutubePlayerDemoApp(
                        IndiaTOdayVideoId, "India Today Live")),
                  );
                },
              ),
              GestureDetector(
                child: Card(
                  elevation: 8.0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset("assets/republicworld.png"),
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  TvClickcountForInterstitialAd++;
                  if (TvClickcountForInterstitialAd % 5 == 0) {
                    interstitialAd
                      ..load()
                      ..show();
                  }
                  Navigator.push(
                    context,
                    FadeRoute(YoutubePlayerDemoApp(
                        RepublicWorldVideoId, "Republic World")),
                  );
                },
              ),
              GestureDetector(
                child: Card(
                  elevation: 8.0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset("assets/skynews.png"),
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  TvClickcountForInterstitialAd++;
                  if (TvClickcountForInterstitialAd % 5 == 0) {
                    interstitialAd
                      ..load()
                      ..show();
                  }
                  Navigator.push(
                    context,
                    FadeRoute(YoutubePlayerDemoApp(SkyNewsVideoId, "Sky News")),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
