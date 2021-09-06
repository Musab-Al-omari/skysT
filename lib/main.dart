import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skys_tasks/screens/Widget/loading.dart';

import 'package:skys_tasks/screens/authentication/logIn.dart';
import 'package:skys_tasks/screens/authentication/signup.dart';
import 'package:skys_tasks/screens/home/mainScreen.dart';
import 'package:skys_tasks/screens/provider/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
      ],
      child: Consumer<Auth>(
          builder: (context, authDat, _) => MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
                    bodyText1:
                        GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
                  ),
                ),
                debugShowCheckedModeBanner: false,
                home: authDat.isAuth
                    ? mainScreen()
                    : FutureBuilder(
                        future: authDat.tryAutoLogIn(),
                        builder: (context, snapshot) =>
                            snapshot.connectionState == ConnectionState.waiting
                                ? Loading()
                                : LoginPage(),
                      ),
                routes: {
                  LoginPage.LoginPagePageScreenRoute: (context) => LoginPage(),
                  SignUpPage.SignUpPageScreenRoute: (context) => SignUpPage(),
                },
              )),
    );
  }
}
