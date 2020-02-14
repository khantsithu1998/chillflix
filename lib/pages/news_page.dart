import 'package:flutter/material.dart';
import 'package:chillflix/pages/loading_page.dart';
import 'package:chillflix/pages/news_list_view.dart';
import 'package:chillflix/pages/no_internet_page.dart';
import 'package:chillflix/utils/news_type.dart';
import 'package:chillflix/view_model/my_view_model.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsPage extends StatefulWidget {
  final NewsType nt;

  NewsPage(this.nt);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MyViewModel>(
      builder: (BuildContext context, Widget child, MyViewModel model) {
        if (model.isLoading) {
          return LoadingPage();
        }

        if (model.noInternet) {
          return NoInternetPage();
        }

        if (widget.nt == NewsType.topten) {
          return NewsListView(model.topten);
        }

        if (widget.nt == NewsType.upcoming) {
          return NewsListView(model.upcoming);
        }

        if (widget.nt == NewsType.superhero) {
          return NewsListView(model.superhero);
        }
      },
    );
  }
}
