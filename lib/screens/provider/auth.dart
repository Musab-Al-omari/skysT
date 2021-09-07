import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skys_tasks/models/httpException.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  var _token;
  var _expiryDate;
  var _userId;
  var _authTimer;
  static const apiKey = 'AIzaSyCLy-BSV9t6VkQ3q9n0jLPw85OpLwi82dg';

  bool get isAuth {
    return token != null;
  }

  get token {
    if (_expiryDate != null && _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Future<void> signUp(String userName, String email, String password,
      String phoneNumber) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$apiKey';
    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode({
            'email': email,
            'password': password,
            "returnSecureToken": true
          }));
      final resData = jsonDecode(response.body);
      print('logup');
      if (resData['error'] != null) {
        throw HttpException(resData['error']['message']);
      } else {
        print(resData);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future signin(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$apiKey';
    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode({
            'email': email,
            'password': password,
            "returnSecureToken": true
          }));
      final resData = jsonDecode(response.body);

      // print(resData);

      if (resData['localId'] != null &&
          resData['email'] != null &&
          resData['expiresIn'] != null) {
        _token = resData['idToken'];
        _userId = resData['localId'];
        _expiryDate = DateTime.now()
            .add(Duration(seconds: int.parse(resData['expiresIn'])));
      }
      _autoLogOut();
      notifyListeners();

      ///////////////////////////
      // AUTO LOG IN IMPLEMENTATION
      var prefs = await SharedPreferences.getInstance();
      var userData = jsonEncode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate.toIso8601String()
      });
      prefs.setString('mykey', userData);

      /////////////////////
      return resData;
    } catch (e) {
      print(e);
    }
  }

  void logOut() async {
    _token = null;
    _expiryDate = null;
    _userId = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('mykey');
  }

  void _autoLogOut() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    var timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    print(timeToExpiry);
    _authTimer = Timer(Duration(seconds: timeToExpiry), logOut);
  }

  Future<bool> tryAutoLogIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('mykey')) {
      return false;
    }

    Map<String, Object> extractUserData =
        json.decode(prefs.getString('mykey') as String);
    print(1);
    final expiryDate = DateTime.parse(extractUserData['expiryDate'] as String);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = extractUserData['token'];
    _expiryDate = extractUserData['userId'];
    _userId = extractUserData['expiryDate'];
    notifyListeners();
    _autoLogOut();

    return true;
  }
}
