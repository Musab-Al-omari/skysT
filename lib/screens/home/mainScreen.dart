import 'package:flutter/material.dart';
import 'package:skys_tasks/main.dart';
import 'package:skys_tasks/screens/Widget/Drawer.dart';

class mainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sadas'),
      ),
      body: Center(
        child: Text('no thing '),
      ),
      drawer: AppDrawer(),
    );
  }
}
