import 'dart:async';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:novum/LiveTv/live_tv_grid.dart';
import 'package:novum/src/ui/components/fade_route.dart';
import 'package:novum/src/ui/components/navigation_drawer.dart';
import 'package:novum/src/ui/theme/colors.dart';
import '../../../fab_circular_menu.dart';
import '../components/novum_app_bar.dart';
import '../components/article_list.dart';
import 'package:firebase_admob/firebase_admob.dart';
import '../../models/article_collection_model.dart';
import '../../blocs/article_collection_bloc.dart';
import 'package:newsapi_client/newsapi_client.dart';

bool adShown = true;
//Ads appAds;
NativeAd nativeAd;
InterstitialAd interstitialAd;
BannerAd bannerAd;

class Browse extends StatefulWidget {
  Browse({
    this.title,
    this.category,
  });

  final String title;
  final Categories category;
  final bloc = ArticleCollectionBloc();

  @override
  BrowseState createState() => BrowseState();
}

class BrowseState extends State<Browse> with SingleTickerProviderStateMixin {
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

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: "ca-app-pub-3945166141600873/4291392510",
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  /// The [_controller] controls the state of the
  /// [NovumAppBar].
  ///
  /// If [_controller.isCompleted] the app bar is
  /// collapsed.
  ///
  /// If [_controller.isDismissed] the app bar is
  /// expanded.
  AnimationController _controller;
  int _pageSize = 20;

  @override
  void initState() {
    interstitialAd=createInterstitialAd()..load();
     FirebaseAdMob.instance.initialize(appId: "ca-app-pub-3945166141600873~8204918491");
      bannerAd = createBannerAd()..load()..show();
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          _controller.reset();
        }
      });

    var eventListener = (MobileAdEvent event) {
      if (event == MobileAdEvent.loaded) {
        adShown = true;
        setState(() {

        });
      } else if (event == MobileAdEvent.failedToLoad) {
        adShown = false;
        setState(() {

        });
      }
    };
  }

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    List<Widget> fakeBottomButtons = new List<Widget>();
    fakeBottomButtons.add(new Container(
      height: 30.0,
    ));

    final listPadding = const EdgeInsets.only(top: 67.0, bottom: 20.0);

    final Widget readMore = FlatButton(
      child: Text(
        'Read More',
        style: Theme.of(context).textTheme.button.copyWith(
              fontSize: 18.0,
            ),
      ),
      onPressed: () => _moreContent(),
    );
    // : Container();

    return Scaffold(
      floatingActionButton: Builder(
        builder: (context) => FabCircularMenu(
          key: fabKey,
          // Cannot be `Alignment.center`
          alignment: Alignment.bottomRight,
          ringColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.tealAccent.withAlpha(200)
              : kNovumPurple.withAlpha(200),
          ringDiameter: 500.0,
          ringWidth: 150.0,
          fabSize: 64.0,
          fabElevation: 8.0,
          fabColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey
              : Colors.white,
          fabOpenIcon: Icon(
            Icons.menu,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : kNovumPurple,
          ),
          fabCloseIcon: Icon(
            Icons.close,
          ),
          fabMargin: const EdgeInsets.all(16.0),
          animationDuration: const Duration(milliseconds: 800),
          animationCurve: Curves.easeInOutCirc,
          onDisplayChange: (isOpen) {
//            _showSnackBar(context, "The menu is ${isOpen ? "open" : "closed"}");
          },
          children: <Widget>[
            RawMaterialButton(
              onPressed: () {
                showModalBottomSheet(
                    isDismissible: true,
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
//                          height: 200,
                        child: WelcomeCard(context),
                      );
                    });
                fabKey.currentState.close();
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(
                Icons.keyboard_arrow_up,
                color: Colors.white,
                size: 40,
              ),
            ),
            RawMaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  FadeRoute(LiveTvGrid()),
                );
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(
                Icons.live_tv,
                color: Colors.white,
                size: 40,
              ),
            ),
            RawMaterialButton(
              onPressed: () {

                setState(() {
                  Theme.of(context).brightness == Brightness.dark
                      ? DynamicTheme.of(context).setBrightness(Brightness.light)
                      : DynamicTheme.of(context).setBrightness(Brightness.dark);
                });

                fabKey.currentState.close();
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(
                Theme.of(context).brightness == Brightness.dark
                    ? Icons.brightness_5
                    : Icons.brightness_2,
                color: Colors.white,
                size: 40,
              ),
            )
          ],
        ),
      ),

//      drawer: NavigationDrawer(),
      body: Stack(
        children: <Widget>[
          RefreshIndicator(
            displacement: 108.0,
            onRefresh: () => _refreshContent(),

            /// The NotificationListener listens for scroll updates
            /// and determines if the app bar should expand or collapse
            /// depending on the scroll direction.
            ///
            /// [_controller.reverse()] expands the app bar.
            /// [_controller.forward()] collapses the app bar.
            child: NotificationListener<ScrollUpdateNotification>(
              onNotification: (notification) {
                final bool scrollingDown = notification.scrollDelta > 0 &&
                    _controller.isDismissed &&
                    notification.metrics.pixels > 0.0;
                final bool scrollingUp = notification.scrollDelta < 0 &&
                    _controller.isCompleted &&
                    notification.metrics.pixels <
                        notification.metrics.maxScrollExtent;
                final bool overflowTop = notification.metrics.pixels < 1.0;

                if (overflowTop) {
                  _controller.reverse();
                } else if (scrollingUp) {
                  _controller.reverse();
                } else if (scrollingDown) {
                  _controller.forward();
                }
              },
              child: ListView(
                children: <Widget>[
                  /// Builds list of articles from [bloc.articles].
                  /// Shows skeleton-screen if stream is empty.
                  StreamBuilder(
                      stream: widget.bloc.articles,
                      builder: (BuildContext context,
                          AsyncSnapshot<ArticleCollectionModel> snapshot) {
                        if (snapshot.hasData) {
                          return ArticleList(
                            snapshot.data.articles,
                            padding: listPadding,
                            itemCount: snapshot.data.articles.length,
                          );
                        }
                        _refreshContent();
                        return ArticleList.skeleton(
                          padding: listPadding,
                          itemCount: 15,
                        );
                      }),

                  readMore,

               //   Divider(),
                ],
              ),
            ),
          ),

          /// Custom app bar
          ///
          /// Appears when [MediaQuery] is available (doesn't return 0.0).
          Align(
            alignment: Alignment.topCenter,
            child: MediaQuery.of(context).size.width == 0.0
                ? SafeArea(
                    child: Container(width: double.infinity, height: 56.0))
                : NovumAppBar(
                    title: widget.title,
                    context: context,
                    controller: _controller,
                  ),
          ),
        ],
      ),

      persistentFooterButtons: adShown ? fakeBottomButtons : null,
    );
  }

  /// Submits a new article request with an increased
  /// pageSize.
  void _moreContent({int step: 10}) {
    setState(() {
      _pageSize = _pageSize += step;
    });
    widget.bloc.requestArticles(TopHeadlines(
      country: Countries.india,
      category: widget.category,
      pageSize: _pageSize,
    ));
  }

  /// Refresh content
  ///
  /// Refreshes the [bloc.articles] stream.
  Future<Null> _refreshContent() async {
    Endpoint endpoint;
    if (widget.category == null) {
      endpoint = TopHeadlines(
        country: Countries.india,
        pageSize: 5,
      );
    } else {
      endpoint = TopHeadlines(
        country: Countries.india,
        category: widget.category,
      );
    }
    await widget.bloc.requestArticles(endpoint);
    return null;
  }

  @override
  void dispose() {
    //_controller.dispose();
    super.dispose();
  }
}
