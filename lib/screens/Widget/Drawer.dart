import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skys_tasks/screens/provider/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Home',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                DrawerBars(() {
                  Navigator.of(context).pushReplacementNamed('/');
                }, Icons.home, 'Home'),
                SizedBox(
                  height: 10,
                ),
                DrawerBars(() {
                  Navigator.of(context)
                      .pushNamed('/favoriteRoute', arguments: 'favorite');
                }, Icons.favorite_rounded, 'Favorite Screen'),
                SizedBox(
                  height: 10,
                ),
                DrawerBars(() {
                  Navigator.of(context)
                      .pushNamed('/ReadRoute', arguments: 'read');
                }, Icons.read_more, 'Read Screen'),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: DrawerBars(() {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
                Provider.of<Auth>(context, listen: false).logOut();
              }, Icons.logout, 'logOut'),
            ),
          ],
        ),
      ),
    );
  }

  Widget DrawerBars(myOnTap, IconData myIcon, String title) {
    return ListTile(
      onTap: myOnTap,
      leading: Icon(
        myIcon,
        size: 25,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
