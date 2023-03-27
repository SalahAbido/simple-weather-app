import 'package:http/http.dart' as http;
import 'package:simple_weaher_app/modules/weather.dart';

class WeatherService {
  var client = http.Client();

  Future<Weather?> currentWeather(String city) async {
    Weather? weather;
    var url = Uri.parse(
        'https://api.weatherapi.com/v1/current.json?key=b6938ffb61b240afb96160132230203&q=$city');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = response.body;
      weather = weatherFromJson(jsonResponse);
      print('successful get weather');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    if (weather != null) {
      return weather;
    }
    return null;
  }
}
