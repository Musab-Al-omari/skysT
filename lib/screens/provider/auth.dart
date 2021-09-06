import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skys_tasks/models/httpException.dart';

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expiryDate;
  late String _userId;
  static const apiKey = 'AIzaSyCLy-BSV9t6VkQ3q9n0jLPw85OpLwi82dg';

  bool get isAuth {
    return token != null;
  }

  get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
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
        print('hi');
        throw HttpException(resData['error']['message']);
      } else {
        print(resData);
      }
    } catch (e) {
      print('missing');
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
      print(resData);
      return resData;
    } catch (e) {
      print(e);
    }
  }
}
