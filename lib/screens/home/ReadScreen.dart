import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skys_tasks/models/Articles.dart';
import 'package:skys_tasks/screens/Widget/Drawer.dart';
import 'package:skys_tasks/screens/home/oneCard.dart';

class Read extends StatefulWidget {
  static const ReadRoute = '/ReadRoute';

  @override
  _ReadState createState() => _ReadState();
}

class _ReadState extends State<Read> {
  var isLoading = false;
  List<Articles> MyArticles = [];
  @override
  Widget build(BuildContext context) {
    final detailsItem = ModalRoute.of(context)!.settings.arguments as String;

    void _fetchDate() async {
      setState(() {
        isLoading = true;
      });
      var url =
          'https://skystasks-default-rtdb.europe-west1.firebasedatabase.app/$detailsItem.json';
      try {
        print(detailsItem);
        final response = await http.get(Uri.parse(url));
        var resData = jsonDecode(response.body);
        MyArticles = [];
        resData.forEach((key, value) {
          setState(() {
            MyArticles.add(Articles(
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
      print(MyArticles.length);
      print(MyArticles[0].author);
      setState(() {
        isLoading = false;
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
        title: Text(detailsItem),
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
                    child: ElevatedButton(
                      child: Text('featch Data'),
                      onPressed: _fetchDate,
                    ),
                  ),
                  MyArticles.length == 0
                      ? Container(
                          margin: EdgeInsets.all(150),
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
