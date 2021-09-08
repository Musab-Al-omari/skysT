import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:skys_tasks/models/Articles.dart';
import 'package:skys_tasks/screens/Widget/Drawer.dart';
import 'package:skys_tasks/screens/home/oneCard.dart';
import 'package:http/http.dart' as http;

class mainScreen extends StatefulWidget {
  @override
  _mainScreenState createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  List<Articles> MyArticles = [];
  var isLoading = false;
  String searchTarm = '';

  ///
  void getNews(term) async {
    final url = 'https://newsapi.org/v2/everything?q=$term';
    setState(() {
      isLoading = true;
    });
    try {
      var response = await http.get(Uri.parse(url),
          headers: {'x-api-key': 'aba21d07dd9b45c3ac766afc3d37e61c'});
      var data = jsonDecode(response.body);
      var listData = data['articles'] as List;
      MyArticles.clear(); // before any search happen
      listData.forEach((value) {
        MyArticles.add(Articles(
            id: value['source']['id'] == null ? 'no id' : value['source']['id'],
            title: value['title'] == null ? 'no title' : value['title'],
            author: value['author'] == null ? 'no author' : value['author'],
            content: value['content'] == null ? 'no author' : value['content'],
            description: value['description'] == null
                ? 'no description'
                : value['description'],
            publishedAt: value['publishedAt'] == null
                ? 'no publishedAt'
                : value['publishedAt'],
            imageUrl: value['urlToImage'] == null
                ? 'assets\istockphoto-922962354-612x612.jpg'
                : value['urlToImage']));
      });
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('News App'),
      ),
      drawer: AppDrawer(),
      body: isLoading
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
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(labelText: 'search'),
                            onChanged: (value) {
                              setState(() {
                                searchTarm = value;
                              });
                            },
                          ),
                        ),
                        IconButton(
                            onPressed: () => getNews(searchTarm),
                            icon: Icon(Icons.search))
                      ],
                    ),
                  ),
                  MyArticles.length == 0
                      ? Container(
                          margin:
                              EdgeInsets.only(top: 150, right: 150, left: 150),
                          child: Text('There is no data '))
                      : Expanded(
                          child: ListView.builder(
                            itemCount: MyArticles.length,
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
                                    MyArticles[index].id,
                                    MyArticles[index].title,
                                    MyArticles[index].author,
                                    MyArticles[index].publishedAt,
                                    MyArticles[index].imageUrl,
                                    MyArticles[index].content,
                                    MyArticles[index].description),
                              );
                            },
                          ),
                        )
                ],
              )),
    );
  }
}


// ListView.builder(
//                           itemCount: MyArticles.length,
//                           itemBuilder: (context, index) => 

                        