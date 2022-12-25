import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/model.dart';

class GetInfoRepository {
  
   getinfo({required String name}) async {
    try {
      final url = Uri.parse(
          'https://api.weatherapi.com/v1/forecast.json?key=0aafe5ca2dc742cb8d7125331222212&q=$name');
      final res = await http.get(url);
     
      if (res.statusCode == 200) {
       dynamic data = jsonDecode(res.body);
        Weather api = Weather.fromJson(data);
        return api;
      }
     
    } catch (e) {
      print(e);
    }
  }
}
