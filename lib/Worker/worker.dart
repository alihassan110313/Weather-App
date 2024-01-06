import 'package:http/http.dart' as http;
import 'dart:convert';

class Worker {
  late String location;
  late String temp;
  late String humidity;
  late String airSpeed;
  late String description;
  late String main;
  late String icon;

  // Constructor
  Worker({required this.location});

  Future<void> getData() async {
    try {
      Uri url = Uri.parse(
          "http://api.openweathermap.org/data/2.5/weather?q=$location&appid=d51628e950bce89574d714fc98eb8c51");

      http.Response response = await http.get(url);
      Map<String, dynamic> data = jsonDecode(response.body);

      // Getting Temp, Humidity
      Map<String, dynamic> tempData = data['main'];
      String getHumidity = tempData['humidity'].toString();
      double getTemp = tempData['temp']- 273.15;

      // Getting airSpeed
      Map<String, dynamic> wind = data['wind'];
      double getAirSpeed = wind['speed']/0.27777777777778;

      // Getting Description
      List<dynamic> weatherData = data['weather'];
      Map<String, dynamic> weatherMainData = weatherData[0];
      String getMainDes = weatherMainData['main'];
      String getDesc = weatherMainData['description'];

      // Assigning Values
      temp = getTemp.toString();
      humidity = getHumidity;
      airSpeed = getAirSpeed.toString();
      description = getDesc;
      main = getMainDes;
      icon = weatherMainData["icon"].toString();
    } catch (e) {
      print(e);
      temp = "NA";
      humidity = "NA";
      airSpeed = "NA";
      description = "Can't Find Data";
      main = "NA";
      icon = "09d";
      // Handle error according to your application's logic
    }
  }
}
