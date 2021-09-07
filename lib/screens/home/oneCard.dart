import 'package:flutter/material.dart';

class OneCard extends StatefulWidget {
  @override
  _OneCardState createState() => _OneCardState();
}

class _OneCardState extends State<OneCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width * .2,
              height: MediaQuery.of(context).size.height * .2,
              color: Colors.amber,
              child: Center(
                child: Text('sada'),
              ),
            ),
            Column(
              children: [
                Text('title'),
                Text('auther'),
                Text('puplish date'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
