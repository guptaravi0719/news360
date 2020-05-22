import 'dart:async';
import './news_api_provider.dart';

import './shared_preferences_provider.dart';
import '../models/article_collection_model.dart';
import '../models/symbol_model.dart';
import '../models/chart_model.dart';
import 'package:newsapi_client/newsapi_client.dart';

class Repository {

  final newsApiProvider = NewsApiProvider();

  final sharedPreferencesProvider = SharedPreferencesProvider();

  /// Returns a collection of [ArticleModel]s from the
  /// given endpoint.
  Future<ArticleCollectionModel> newsApiRequest(Endpoint endpoint) async {
    final response = await newsApiProvider.request(endpoint);
    return response;
  }


}