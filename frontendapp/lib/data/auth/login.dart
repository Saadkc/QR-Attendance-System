import 'package:http/http.dart' as http;
import '../../common/config.dart';

Future<String> signIn(String email,String password) async {
  String url = login;

  http.Response response = await http.post(Uri.parse(url), body: {
    "email": email,
    "password": password,
  });

  if(response.statusCode == 200) {
    return "Success";
  } else {
    throw Exception("Failed to load data");
  }
}