import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;
  Future getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      return json.decode(data);
    } else {
      print(response.statusCode);
    }
  }
}
//'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=${apiKey}'
