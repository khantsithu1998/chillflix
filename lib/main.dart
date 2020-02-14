import 'package:flutter/material.dart';

import 'package:chillflix/network/my_api.dart';
import 'package:chillflix/pages/news_page.dart';
import 'package:chillflix/utils/news_type.dart';
import 'package:chillflix/view_model/my_view_model.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChillFlix',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'ChillFlix'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  var controller;

  MyViewModel model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=TabController(length: 3, vsync: this);
    model=MyViewModel(MyApi());
    fetchNews();
  }

  void fetchNews()async{
    await model.fetchSuperHero();
    await model.fetchTopTen();
    await model.fetctUpcoming();
  }


  @override
  Widget build(BuildContext context) {
    return ScopedModel<MyViewModel>(model: model, child:
    Scaffold(

        appBar: AppBar(
            actions: <Widget>[
              ScopedModelDescendant<MyViewModel>(builder: (BuildContext context, Widget child, MyViewModel model) {
                return IconButton(
                  icon: Icon(Icons.refresh,color: Colors.white,),
                  onPressed: (){
                    fetchNews();
                  },
                );
              },

              ),
              IconButton(icon:Icon(Icons.more_vert,color: Colors.white,),onPressed: (){
                showDialog(context: context,builder: (context){
                  return SimpleDialog(
                    contentPadding: EdgeInsets.all(0.0),
                    children: <Widget>[
                      Container(
                        color: Theme.of(context).primaryColor,
                        child: Text("Developed By",style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0
                        ),),
                        width: double.infinity,
                        height: 50.0,
                        alignment: Alignment.center,
                      ),
                      Container(
                        alignment:Alignment.center,
                        child: Text("Khant Si Thu",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0
                          ),),
                        margin: EdgeInsets.all(50.0),
                      )

                    ],
                  );
                });
              },)
            ],
            title: Text("Movie News",style: TextStyle(
              color: Colors.white,
            ),),
            bottom: PreferredSize(child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white
              ),
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.only(right:5.0,left: 5.0,bottom: 5.0,top: 10.0),
              height: 63.0,
              child: TabBar(tabs: <Widget>[
                Tab(
                  text: "SuperHero",
                  icon: Icon(Icons.movie_filter),
                ),
                Tab(
                  text: "Upcoming",
                  icon: Icon(Icons.movie_creation),
                ),
                Tab(
                  text: "Top Ten",
                  icon: Icon(Icons.local_movies),
                ),

              ],
                controller:controller,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Theme.of(context).primaryColor,

                ),

                indicatorPadding: EdgeInsets.all(0.0),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,

              ),
            ),preferredSize: Size(double.infinity,60.0))
        ),
        body:TabBarView(children: [
          NewsPage(NewsType.superhero),

          NewsPage(NewsType.upcoming),
          NewsPage(NewsType.topten),


        ],
          controller: controller,)

    ),

    );
  }
}
