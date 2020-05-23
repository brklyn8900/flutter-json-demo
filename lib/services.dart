import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'users.dart';

class Services {
  static const String url = 'https://jsonplaceholder.typicode.com/users';

  static Future<List<Users>> getUsers() async {
    try {
      final responses = await http.get(url);

      if (responses.statusCode == 200) {
        final List<Users> users = usersFromJson(responses.body);
        return users;
      } else {
        return List<Users>();
      }
    } catch (e) {
      print(e);
      return List<Users>();
    }
  }
}
