import 'package:flutter/material.dart';
import 'package:skys_tasks/models/Articles.dart';

class OneCard extends StatefulWidget {
  // OneCard(String id, String title, String author, String publishedAt,
  //     String imageUrl);

  String id;
  String title;
  String author;
  String publishedAt;
  String imageUrl;
  String content;
  String description;

  OneCard(this.id, this.title, this.author, this.publishedAt, this.imageUrl,
      this.content, this.description);
  @override
  _OneCardState createState() => _OneCardState();
}

class _OneCardState extends State<OneCard> {
  @override
  Widget build(BuildContext context) {
    // return Text('widget.id');
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/news-details', arguments: {
          'id': widget.id,
          'title': widget.title,
          'author': widget.author,
          'publishedAt': widget.publishedAt,
          'imageUrl': widget.imageUrl,
          'content': widget.content,
          'description': widget.description,
        });
      },
      // child: Card(
      //   clipBehavior: Clip.antiAlias,
      //   // height: MediaQuery.of(context).size.height * 0.2,
      //   // width: MediaQuery.of(context).size.width,
      //   child: ListTile(
      //     title: Text(widget.title),
      //     leading: Image.network(
      //       widget.imageUrl,
      //     ),
      //   ),
      // )
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: Image.network(
                widget.imageUrl,
                height: MediaQuery.of(context).size.width * 0.3,
                width: MediaQuery.of(context).size.width * 0.3,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      widget.title,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 15, top: 15),
                    child: Text(
                      'The Author ${widget.author}',
                      style: Theme.of(context).textTheme.bodyText2,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  Container(
                    child: Text(
                      'published At :${widget.publishedAt}',
                      style: Theme.of(context).textTheme.bodyText2,
                      overflow: TextOverflow.fade,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


              //   width: MediaQuery.of(context).size.width * 0.3,
              // height: MediaQuery.of(context).size.width * 0.3,
              // child: SizedBox(
              //     child: Image.network(
              //   widget.imageUrl,
              // )