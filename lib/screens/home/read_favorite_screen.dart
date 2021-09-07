import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skys_tasks/models/Articles.dart';
import 'package:skys_tasks/screens/Widget/Drawer.dart';

class ReadFavorit extends StatefulWidget {
  static const ReadFavoritRoute = '/ReadFavoritRoute';

  @override
  _ReadFavoritState createState() => _ReadFavoritState();
}

class _ReadFavoritState extends State<ReadFavorit> {
  var bool = true;
  List<Articles> ArticlesList = [];
  @override
  Widget build(BuildContext context) {
    final detailsItem = ModalRoute.of(context)!.settings.arguments as String;
    print(detailsItem);

    void fetchDate() async {
      var url =
          'https://skystasks-default-rtdb.europe-west1.firebasedatabase.app/$detailsItem.json';
      try {
        final response = await http.get(Uri.parse(url));
        var resData = jsonDecode(response.body);
        resData.forEach((key, value) {
          print(value['author']);
        });

        // print(resData);
      } catch (e) {
        print(e);
      }
    }

    // fetchDate();

    return Scaffold(
      appBar: AppBar(
        title: Text(detailsItem),
      ),
      drawer: AppDrawer(),
      body: Text('sad'),
    );
  }
}
