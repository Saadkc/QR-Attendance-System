import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/config.dart';

Future<String> signIn(String email, String password) async {
  String url = login;

  http.Response response = await http.post(Uri.parse(url), body: {
    "email": email,
    "password": password,
  });

  if (response.statusCode == 200) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map data = jsonDecode(response.body);
    prefs.setString('name', data['data']['name']);
    return "Success";
  } else {
    throw Exception("Failed to load data");
  }
}
