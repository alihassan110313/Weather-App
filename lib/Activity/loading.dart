import 'package:flutter/material.dart';
import 'package:weather/Worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String city = "Jhelum";
  late String temp;
  late String hum;
  late String airSpeed;
  late String des;
  late String main;
  late String loc;
  late String icon;

  void startApp(String city) async
  {

    Worker instance  = Worker(location: city);
    await instance.getData();

    temp = instance.temp;
    hum = instance.humidity;
    airSpeed = instance.airSpeed;
    des = instance.description;
    main = instance.main;
    loc = instance.location;
    icon = instance.icon;

    Future.delayed(Duration(seconds: 2), (){
    Navigator.pushReplacementNamed(context, '/home',arguments: {
      "temp_value" : temp,
      "hum_value" : hum,
      "airSpeed_value" : airSpeed,
      "des_value" : des,
      "main_value" : main,
      "icon_value" : icon,
      "city_value" : city,

    } );
    });
  }

  @override
  void initState() {
    // TODO: implement initState


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Map? search = ModalRoute.of(context)?.settings.arguments as Map?;

    if (search != null && search.isNotEmpty) {
      city = search['searchText'] as String;
    }
    startApp(city);


    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 180,),
              Image.asset("images/mlogo.png",height: 240,width: 240,),

              Text("Weather App",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                ),),
              SizedBox(height: 10,),
              Text("Made By Ali",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white
                ),),
              SizedBox(height: 30,),
              SpinKitWave(
                color: Colors.white,
                size: 50.0,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.blue[300],

    );
  }
}