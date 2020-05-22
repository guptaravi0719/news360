import 'dart:async';
import 'package:flutter/material.dart';
import 'package:novum/src/ui/screens/count_for_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../blocs/auth_bloc.dart';
import '../../resources/repository.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  RemoteConfig remoteConfig;

  String fetchedApiKey;

  @override
  void initState() {
    fetchApiKey().then((value) => validate(context,fetchedApiKey));

    
    // TODO: implement initState

    super.initState();
  }


  Future<String> fetchApiKey() async {
    //fetching Api key from firebase_remote_config

    remoteConfig = await RemoteConfig.instance;
    try {
      // Using default duration to force fetching from remote server.
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched().then((value) => fetchedApiKey = remoteConfig.getString('Api_Key'));
      


    //  debugPrint(fetchedApiKey);
    } on FetchThrottledException catch (exception) {
      // Fetch throttled.

      print(exception);
    } catch (exception) {}
  }

  final bloc = AuthBloc();

  final _repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<String>(
          stream: bloc.key,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData && snapshot.data.isNotEmpty) {
              validate(context, snapshot.data);
              return splashScreen();
            }
            bloc.getKey();
            return splashScreen();
          },
        ),
      ),
    );
  }

  Widget splashScreen() {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.6,
            ),
            SizedBox(
                height: 120,
                width: 120,
                child: Image.asset("assets/icon-710.png")),
            SizedBox(height: 20, width: 20, child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }

  Future<void> validate(BuildContext context, String key) async {
    key = key.trim();
    final bool valid = await _repository.newsApiProvider.test(key);
    if (valid) {
      // Navigate to the home screen if the API key is
      // valid.
      await bloc.setKey(key);
      //  await Future.delayed(Duration(milliseconds: 0));
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      // Show an error if the API key isn't valid.
      await bloc.setKey('');
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sorry!'),
            content: Text(
                'Check your Connectivity Or We can be under maintainance. We will get back soon in few hours !'),
            actions: <Widget>[
              FlatButton(
                textColor: Theme.of(context).accentColor,
                child: Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    }
  }

  /// Shows the home screen.
  void authenticated(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 300));
    Navigator.pushReplacementNamed(context, '/home');
  }
}
