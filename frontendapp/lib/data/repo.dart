import 'dart:convert';

import 'package:http/http.dart' as http;
import '../common/config.dart';

Future<void> scanQrCode(String name, String status,{DateTime? breakTime, DateTime? breakTimeOff}) async {
  String url = scan;
  http.Response response;
  if (status != "break") {
    response =
        await http.post(Uri.parse(url), body: {"name": name, "status": status});
  } else {
    response =
        await http.post(Uri.parse(url), body: json.encode({"name": name, "status": status,"breakoff_time": breakTimeOff,"break_time": breakTime}));
  }

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    throw Exception("Failed to load data");
  }
}
