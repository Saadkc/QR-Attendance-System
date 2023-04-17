import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../common/config.dart';

Future<void> scanQrCode(String name, String status) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String url = scan;
  http.Response response;
  if (status != "Log In") {
    int id = prefs.getInt('id')!;
    response = await http.post(Uri.parse(url),
        body: {"name": name, "status": status, "id": id.toString()});
  } else {
    response =
        await http.post(Uri.parse(url), body: {"name": name, "status": status});
  }

  if (response.statusCode == 200) {
    if (status == "Log In") {
      Map data = jsonDecode(response.body);
      prefs.setInt('id', data['data'][0]['id']);
    }
  } else {
    throw Exception("Failed to load data");
  }
}
