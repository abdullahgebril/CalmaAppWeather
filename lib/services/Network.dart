

import 'dart:convert';
import 'package:http/http.dart' as http;
class Network {
  final String url;

  Network(this.url);

  Future getweatherData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else {
      print('errpr');
    }
  }
}