import 'dart:async';
import 'package:flutter/material.dart';
import '../../models/article_collection_model.dart';
import '../../blocs/article_collection_bloc.dart';
import '../components/article_list.dart';
import '../components/logo.dart';

class Search extends StatefulWidget {
  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> {
  final textController = TextEditingController();

  /// Create new instance of [ArticleCollectionBloc] that is only used
  /// in search to avoid changing the content of the browse screens.
  final searchBloc = ArticleCollectionBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white12,
            centerTitle: true,
            floating: true,
            pinned: true,
            title: Text(
              "News360",
              style: TextStyle(
                  fontFamily: 'Eczar',
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black87),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.close,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black87,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            // App bar bottom containing search field.
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, 73.0),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 16.0),
                child: _SearchField(
                  controller: textController,
                  onChanged: (value) => _handleChange(value),
                ),
              ),
            ),
          ),

          // List of search results.
          SliverList(
            delegate: SliverChildListDelegate([
              _Results(bloc: searchBloc, controller: textController),
            ]),
          ),
        ],
      ),
    );
  }

  void _handleChange(String value) async {
    if (value.isNotEmpty) {
      final String query = value;
      await Future.delayed(Duration(milliseconds: 500));
      if (query == textController.value.text) {
        searchBloc.searchArticles(query);
      }
    }
  }
}

class _SearchField extends StatelessWidget {
  _SearchField({
    @required this.controller,
    this.onChanged,
  });

  final TextEditingController controller;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black87),
      decoration: InputDecoration(
        hintText: 'Search',
      ),
      controller: controller,
      onChanged: (value) => onChanged(value),
    );
  }
}

/// Builds list of search results from [bloc.articles].
class _Results extends StatelessWidget {
  _Results({
    @required this.controller,
    @required this.bloc,
  });

  final TextEditingController controller;
  final ArticleCollectionBloc bloc;

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(vertical: 20.0);
    return StreamBuilder(
      stream: bloc.articles,
      builder: (BuildContext context,
          AsyncSnapshot<ArticleCollectionModel> snapshot) {
        if (snapshot.hasData) {
          // Build list of search results.
          return ArticleList(snapshot.data.articles,
              expandFirst: false, padding: padding);
        }
        // Return placeholder skeleton.
        if (controller.value.text.isNotEmpty) {
          return ArticleList.skeleton(expandFirst: false);
        }
        // Show empty container if there is no current query.
        return Container(padding: padding);
      },
    );
  }
}
