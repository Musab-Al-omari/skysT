import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skys_tasks/screens/home/FavoriteScreen.dart';
import 'package:skys_tasks/screens/home/ReadScreen.dart';

class NewsDetails extends StatelessWidget {
  static const NewsDetailsRoute = '/news-details';

  Widget buildContainer(text, child, context) {
    return Column(
      children: [
        buildText(text),
        Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(10),
            ),
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: child,
            )),
      ],
    );
  }

  Widget buildText(text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'RobotoCondensed'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final detailsItem =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final _id = detailsItem['id'];
    final title = detailsItem['title'];
    final author = detailsItem['author'];
    final publishedAt = detailsItem['publishedAt'];
    final imageUrl = detailsItem['imageUrl'];
    final content = detailsItem['content'];
    final description = detailsItem['description'];

    void _alert(
      String text,
      route,
    ) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text(
                'You save ',
              ),
              content: Text('do you want to go to your $text Screen ?'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text('No')),
                ElevatedButton(
                    onPressed: () {
                      // route
                      Navigator.of(context)
                          .pushReplacementNamed(route, arguments: text);
                    },
                    child: Text('Yes'))
              ],
            );
          });
    }

    void _addToNewsReaded() async {
      var url =
          'https://skystasks-default-rtdb.europe-west1.firebasedatabase.app/read.json';

      try {
        final response = await http.post(Uri.parse(url),
            body: jsonEncode({
              'myId': _id,
              'title': title,
              'author': author,
              'publishedAt': publishedAt,
              'imageUrl': imageUrl,
              'content': content,
              'description': description,
            }));
        final resData = jsonDecode(response.body);
      } catch (e) {
        print(e);
      }
      _alert('read ', Read.ReadRoute);
    }

    void _addToNewsfavorite() async {
      var url =
          'https://skystasks-default-rtdb.europe-west1.firebasedatabase.app/favorite.json';

      try {
        final response = await http.post(Uri.parse(url),
            body: jsonEncode({
              'myId': _id,
              'title': title,
              'author': author,
              'publishedAt': publishedAt,
              'imageUrl': imageUrl,
              'content': content,
              'description': description,
            }));
        final resData = jsonDecode(response.body);
      } catch (e) {
        print(e);
      }
      _alert('favorite', Favorite.FavoriteRoute);
    }

    return Scaffold(
        appBar: AppBar(title: Text(title!)),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.4,
                  width: double.infinity,
                  child: Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildText('Title:   $title'),
                    buildText('ID:   $_id'),
                    buildText('Author:   $author'),
                    buildText('publishedAt:   $publishedAt')
                  ],
                ),
                buildContainer(
                    'Description',
                    Text(
                      description!,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'RobotoCondensed',
                      ),
                    ),
                    context),
                buildContainer(
                    'Content',
                    Text(
                      content!,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'RobotoCondensed',
                      ),
                    ),
                    context),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                backgroundColor: Colors.blue.shade400,
                heroTag: "btn",
                onPressed: _addToNewsfavorite,
                child: Icon(Icons.favorite),
              ),
              SizedBox(
                width: 40,
              ),
              FloatingActionButton(
                backgroundColor: Colors.blue.shade400,
                heroTag: "btn2",
                onPressed: _addToNewsReaded,
                child: Icon(Icons.read_more),
              )
            ],
          ),
        ));
  }
}
