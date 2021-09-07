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
          headers: {'x-api-key': 'b4aa6f395a0d4f46a65cffd321e95b66'});
      var data = jsonDecode(response.body);
      var listData = data['articles'] as List;

      listData.forEach((value) {
        MyArticles.add(Articles(
            id: value['source']['id'] == null ? 'no id' : value['source']['id'],
            title: value['title'] == null ? 'no title' : value['title'],
            author: value['author'] == null ? 'no author' : value['author'],
            description: value['description'] == null
                ? 'no description'
                : value['description'],
            publishedAt: value['publishedAt'] == null
                ? 'no publishedAt'
                : value['publishedAt'],
            imageUrl: value['urlToImage'] == null
                ? 'https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg'
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
        title: Text('News App'),
      ),
      drawer: AppDrawer(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: 500,
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
                  OneCard(),
                ],
              )),
    );
  }
}
