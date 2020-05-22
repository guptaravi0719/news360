import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:novum/LiveTv/live_tv_grid.dart';

import 'package:dynamic_theme/theme_switcher_widgets.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'fade_route.dart';
import 'package:novum/src/app.dart';
NovumAppState _novumAppState;
Widget WelcomeCard(BuildContext context) {
_novumAppState=NovumAppState();

  return Container(
    // padding: new EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
    child: new Container(
      height: MediaQuery
          .of(context)
          .size
          .height / 1.3,
      decoration: new BoxDecoration(
         // color: Colors.white,
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(30.0),
              topRight: const Radius.circular(30.0),
              bottomLeft: const Radius.circular(30.0),
              bottomRight: const Radius.circular(30.0))),
      child: new Column(children: <Widget>[
        Padding(
            padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
            child: new Text(
              'Categories',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: new TextStyle(
                fontSize: 20.0,
                //color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            )),
        Padding(
          padding: EdgeInsets.all(20),
          child: Wrap(
            spacing: 20.0,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      FadeRoute(LiveTvGrid()),
                    );
                  },


                  child: CategoryCard("Live TV",
                      "https://images.unsplash.com/photo-1550926738-f73578677146?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60")),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/sports');
                  },
                  child: CategoryCard("Sports",
                      "https://images.unsplash.com/photo-1495563923587-bdc4282494d0?ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80")),
              GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed('/business'),
                  child: CategoryCard("Business",
                      "https://images.unsplash.com/photo-1507679799987-c73779587ccf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80")),
              GestureDetector(
                  onTap: () =>
                      Navigator.of(context)
                          .pushReplacementNamed('/entertainment'),
                  child: CategoryCard("Entertainment",
                      "https://images.unsplash.com/photo-1522869635100-9f4c5e86aa37?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80")),
              GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed('/health'),
                  child: CategoryCard("Health",
                      "https://images.unsplash.com/photo-1494390248081-4e521a5940db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1595&q=80")),
              GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed('/science'),
                  child: CategoryCard("Science",
                      "https://images.unsplash.com/photo-1554475901-4538ddfbccc2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1504&q=80")),
              GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed('/technology'),
                  child: CategoryCard("Technology",
                      "https://images.unsplash.com/photo-1519389950473-47ba0277781c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80")),





   ],
          ),
        ),
      ]),
    ),
  );



}


Widget CategoryCard(String categoryTitle, String imageUrl) {
  return Container(
    margin: EdgeInsets.only(right: 14),
    child: Card(
      elevation: 8.0,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: 60,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 60,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.black26),
            child: Text(
              categoryTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Eczar'),
            ),
          )
        ],
      ),
    ),
  );
}

//Commented code for navigation drawer if you need to implement it.

//class NavigationDrawer extends StatefulWidget {
//  @override
//  _NavigationDrawerState createState() => _NavigationDrawerState();
//}
//
//class _NavigationDrawerState extends State<NavigationDrawer> {
//  @override
//  Widget build(BuildContext context) {
//    return Drawer(
//      elevation: 8.0,
//      child: ListView(
//        physics: NeverScrollableScrollPhysics(),
//        children: <Widget>[
//          SizedBox(
//            height: 10,
//          ),
//          // Header with logo and close button.
//          DrawerHeader(),
//          //Divider(),
//          ListTile(
//            onTap: () {
//              Navigator.push(context, FadeRoute(LiveTvGrid()));
//            },
//            leading:
//                SizedBox(height: 20.0, child: Image.asset("assets/live.gif")),
//            title: Text(
//              "LiveTv",
//              style: TextStyle(
//                  color: Colors.red,
//                  fontWeight: FontWeight.bold,
//                  fontSize: 20,
//                  fontFamily: 'Eczar'),
//            ),
//          ),
//
//          Divider(),
//          DrawerItem(title: 'Trending', route: '/home'),
//          Divider(),
//          DrawerItem(title: 'Business', route: '/business'),
//          Divider(),
//          DrawerItem(title: 'Entertainment', route: '/entertainment'),
//          Divider(),
//          DrawerItem(title: 'Health', route: '/health'),
//          Divider(),
//          DrawerItem(title: 'Science', route: '/science'),
//          Divider(),
//          DrawerItem(title: 'Sports', route: '/sports'),
//          Divider(),
//          DrawerItem(title: 'Technology', route: '/technology'),
//          Divider(),
//          Spacer(),
//          Spacer(),
//
//          ListTile(
//            contentPadding: EdgeInsets.only(left: 34.0),
//            title: Row(
//              children: <Widget>[
//                Text('Powered by ',
//                    style: TextStyle(
//                      fontFamily: 'Libre Franklin',
//                      fontSize: 5.0,
//                      height: 0.8,
//                      color: Colors.black54,
//                    )),
//                Text('NewsApi.org',
//                    style: TextStyle(
//                      fontFamily: 'Eczar',
//                      fontSize: 5.0,
//                    )),
//              ],
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}
//
//class DrawerHeader extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return ListTile(
//      contentPadding: EdgeInsets.only(bottom: 20.0, left: 16.0),
//      title: Logo.large(),
//      leading: IconButton(
//        color: Colors.black87,
//        icon: Icon(Icons.close, semanticLabel: 'Close'),
//        onPressed: () => Navigator.pop(context),
//        tooltip: 'Close',
//      ),
//    );
//  }
//}
//
//class DrawerItem extends StatelessWidget {
//  DrawerItem({
//    @required this.title,
//    @required this.route,
//  })  : assert(title != null),
//        assert(route != null);
//
//  final String title;
//  final String route;
//
//  @override
//  Widget build(BuildContext context) {
//    bool currentRoute = _isCurrentRoute(context, route);
//    return ListTile(
//      leading: route == "/home"
//          ? Icon(Icons.date_range)
//          : route == "/business"
//              ? Icon(Icons.location_city)
//              : route == '/entertainment'
//                  ? Icon(Icons.lightbulb_outline)
//                  : route == "/health"
//                      ? Icon(Icons.favorite)
//                      : route == "/sports"
//                          ? Icon(Icons.airline_seat_flat_angled)
//                          : route == "/science"
//                              ? Icon(Icons.opacity)
//                              : Icon(Icons.vpn_lock),
//      enabled: !currentRoute,
//      contentPadding: EdgeInsets.only(left: 34.0, right: 34.0),
//      title: Text(
//        title,
//        style: Theme.of(context).textTheme.subtitle.copyWith(
//              //  color: currentRoute ? Colors.black54 : Colors.black87,
//              fontSize: 16.0,
//              fontWeight: FontWeight.w700,
//            ),
//      ),
//      trailing: currentRoute
//          ? Icon(
//              Icons.fiber_manual_record,
//              color: Colors.black38,
//              size: 12.0,
//            )
//          : null,
//      onTap: () => Navigator.of(context).pushReplacementNamed(route),
//    );
//  }
//
//  bool _isCurrentRoute(BuildContext context, String routeName) {
//    bool isCurrentRoute;
//    Navigator.popUntil(context, (route) {
//      isCurrentRoute = route.settings.name == routeName;
//      return true;
//    });
//    return isCurrentRoute;
//  }
//}
