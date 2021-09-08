import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skys_tasks/models/httpException.dart';
import 'package:skys_tasks/screens/Widget/bezierContainer.dart';
import 'package:provider/provider.dart';
import 'package:skys_tasks/screens/provider/auth.dart';

class LoginPage extends StatefulWidget {
  late String title;
  static const LoginPagePageScreenRoute = '/LoginPagePage-Screen';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map<String, String> signInData = {'Email': '', 'password': ''};

  void _alert(String text) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              'an error',
            ),
            content: Text(text),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('okay'))
            ],
          );
        });
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              onChanged: (value) {
                switch (title) {
                  case 'Email':
                    signInData['Email'] = value;
                    break;
                  case 'Password':
                    signInData['password'] = value;
                    break;
                }
              },
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    Future<void> _submited() async {
      if (signInData['Email'] == '' || signInData['password'] == '') {
        _alert(
            'the Email field or the password field or both are empty fill them');
        return;
      }
      try {
        var data = await Provider.of<Auth>(context, listen: false).signin(
            signInData['Email'] as String, signInData['password'] as String);

        if (data['error'] != null) {
          print(data['error']);
          _alert(data['error']['message']);
        }
      } catch (err) {
        print(err);
      }
    }

    return InkWell(
      onTap: _submited,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.blue.shade900, Colors.blue.shade200])),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacementNamed(context, '/SignUpPage-Screen');
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Colors.blue.shade900,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'News',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.bodyText1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.blue.shade900,
          ),
          children: [
            TextSpan(
              text: 'pap',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'er',
              style: TextStyle(color: Colors.blue.shade200, fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email"),
        _entryField("Password", isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  _title(),
                  SizedBox(height: 50),
                  _emailPasswordWidget(),
                  SizedBox(height: 20),
                  _submitButton(),
                  SizedBox(height: height * .055),
                  _createAccountLabel(),
                ],
              ),
            ),
          ),
          // Positioned(top: 40, left: 0, child: _backButton()),
        ],
      ),
    ));
  }
}
