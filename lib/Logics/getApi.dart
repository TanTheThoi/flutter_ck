import 'dart:convert';
import 'package:http/http.dart' as http;

// lấy API

Future<dynamic> getData() async {
  var url = Uri.parse('https://api.jikan.moe/v4/anime');
  var response = await http.get(url);
  var data = jsonDecode(response.body);

  return data;
}
