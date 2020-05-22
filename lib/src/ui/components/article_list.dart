import 'package:flutter/material.dart';
import '../../models/article_model.dart';
import './article_tile.dart';
import './skeleton_frame.dart';

class ArticleList extends StatefulWidget {
  ArticleList(
    this.articles, {
    this.expandFirst: true,
    this.itemCount,
    this.padding: const EdgeInsets.symmetric(vertical: 20.0),
  }) : assert(articles != null);

  ArticleList.skeleton({
    this.expandFirst: true,
    this.itemCount,
    this.padding: const EdgeInsets.symmetric(vertical: 20.0),
  }) : articles = null;

  final List<ArticleModel> articles;
  final bool expandFirst;
  final int itemCount;
  final EdgeInsetsGeometry padding;

  @override
  _ArticleListState createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool skeleton = widget.articles == null;
    return ListView.separated(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: skeleton
          ? widget.itemCount ?? 4
          : widget.itemCount ?? widget.articles.length,
      padding: widget.padding,
      separatorBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          //  child: Divider(),
        );
      },
      itemBuilder: (BuildContext context, int index) {
        if (skeleton) {
          // Return skeleton tile.
          return ArticleTile(
            title: index == 0
                ? SkeletonFrame(width: 300.0, height: 16.0)
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SkeletonFrame(width: 300.0, height: 16.0),
                      SizedBox(height: 4.0),
                      SkeletonFrame(width: 150.0, height: 16.0),
                    ],
                  ),
            published: SkeletonFrame(width: 36.0, height: 16.0),
            thumbnail: Container(width: 100.0, height: 100.0),
            expanded: widget.expandFirst && index == 0,
          );
        } else {
          return Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ArticleTile.fromArticleModel(
              widget.articles[index],
              context,
              expanded: widget.expandFirst && index == 0,
            ),
          );
          //      );
        }
      },
    );
  }
}
