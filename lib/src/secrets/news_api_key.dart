import 'dart:async';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Returns the user's 'newsapi.org' API key stored in
/// shared preferences.
///
///

Future<String> kNewsApiKey() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('news_api_key');
}
Future<int> getVideoAdCount() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('videoAdCount');

}
setvideoAdCount(int count) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('videoAdCount', count);
}