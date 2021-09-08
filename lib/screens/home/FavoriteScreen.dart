import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skys_tasks/models/Articles.dart';
import 'package:skys_tasks/screens/Widget/Drawer.dart';
import 'package:skys_tasks/screens/home/oneCard.dart';

class Favorite extends StatefulWidget {
  static const FavoriteRoute = '/favoriteRoute';

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  var _isLoading = false;
  List<Articles> _MyArticles = [];
  @override
  Widget build(BuildContext context) {
    final _detailsItem = ModalRoute.of(context)!.settings.arguments as String;

    void _fetchDate() async {
      setState(() {
        _isLoading = true;
      });
      var url =
          'https://skystasks-default-rtdb.europe-west1.firebasedatabase.app/$_detailsItem.json';
      try {
        print(_detailsItem);
        final _response = await http.get(Uri.parse(url));
        var _resData = jsonDecode(_response.body);
        _MyArticles = [];
        _resData.forEach((key, value) {
          setState(() {
            _MyArticles.add(Articles(
                id: value['myId'],
                title: value['title'],
                author: value['author'],
                description: value['description'],
                publishedAt: value['publishedAt'],
                imageUrl: value['imageUrl'],
                content: value['content']));
          });
        });

        // List<Articles> MyArticles;
      } catch (e) {
        print(e);
      }
      print(_MyArticles.length);
      print(_MyArticles[0].author);
      setState(() {
        _isLoading = false;
      });
    }

    // @override
    // void initState() {
    //   Future.delayed(Duration.zero).then((_) => fetchDate());
    //   super.initState();
    // }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(_detailsItem),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              // height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ElevatedButton(
                      child: Text('featch Data'),
                      onPressed: _fetchDate,
                    ),
                  ),
                  _MyArticles.length == 0
                      ? Container(
                          margin: EdgeInsets.all(150),
                          child: Text('There is no data '))
                      : Expanded(
                          child: ListView.builder(
                            itemCount: _MyArticles.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 7),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: OneCard(
                                    _MyArticles[index].id,
                                    _MyArticles[index].title,
                                    _MyArticles[index].author,
                                    _MyArticles[index].publishedAt,
                                    _MyArticles[index].imageUrl,
                                    _MyArticles[index].content,
                                    _MyArticles[index].description),
                              );
                            },
                          ),
                        )
                ],
              )),
    );
  }
}
