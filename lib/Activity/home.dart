import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:math';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    searchFocusNode.addListener(() {
      if (!searchFocusNode.hasFocus) {
        _searchCity();
      }
    });
    print("This is a init state");
  }
  void _searchCity() {
    if ((searchController.text).replaceAll(" ", "") == "") {
      print("Blank search");
    } else {
      Navigator.pushReplacementNamed(context, "/loading", arguments: {
        "searchText": searchController.text,
      });
    }
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    print("Set state called");
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    // TODO: implement dispose
    super.dispose();
    print("Widget Destroyed");
  }

  @override
  Widget build(BuildContext context) {

    var city_name = ["Jhelum", "Islamabad", "Karachi", "Frankfurt", "London"];
    final _random = new Random();
    var city = city_name[_random.nextInt(city_name.length)];
    Map? info = ModalRoute.of(context)?.settings.arguments as Map?;

    String temp =  ((info?['temp_value']).toString());
    String air = ((info?['airSpeed_value']).toString());

    if(temp == "NA")
    {
      print("NA");
    }
    else
    {
      temp =  ((info?['temp_value']).toString()).substring(0,4);
      air = ((info?['airSpeed_value']).toString()).substring(0,4);
    }

    String icon = info?['icon_value'];
    String getcity = info?['city_value'];
    String hum = info?['hum_value'];
    String des = info?['des_value'];

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Colors.blue,
          )
        ),
      body: SafeArea(
        child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,

              colors: [
                Colors.blue,
                Colors.indigo,

              ]

            )
          ),
          child: Column(
            children: [
              Container( //Search Wala Container

                padding: EdgeInsets.symmetric(horizontal: 8),
                margin: EdgeInsets.symmetric(horizontal: 24,vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),

                ),
                child: Row(

                  children: [
                    GestureDetector(
                      onTap: _searchCity,
                      child: Container(child: Icon(Icons.search,color: Colors.blueAccent,),margin: EdgeInsets.fromLTRB(3, 0, 7, 0),),
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        focusNode: searchFocusNode,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search $city"
                        ),
                        onSubmitted: (_) {
                          _searchCity();
                        },
                      ),
                    )
                  ],
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)),
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        padding: EdgeInsets.all(10),
                        child: Row(children: [
                          Image.network("http://openweathermap.org/img/wn/$icon@2x.png"),
                          SizedBox(width: 20,),
                          Column(
                            children: [
                              Text("$des",style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text("in $getcity",style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),)
                            ],
                          )
                        ])),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5)),
                      margin:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      padding: EdgeInsets.all(26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.thermostat),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("$temp",style: TextStyle(
                                  fontSize: 90
                              ),),
                              Text("C",style: TextStyle(
                                  fontSize: 30
                              ),)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5)),
                      margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                      padding: EdgeInsets.all(26),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.wind_power)
                            ],
                          ),
                          SizedBox(height: 30,)
                          ,
                          Text("$air",style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold
                          ),),
                          Text("km/hr")
                        ],
                      ),
                      height: 200,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5)),
                      margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                      padding: EdgeInsets.all(26),
                      height: 200,
                      child:  Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.wb_sunny)
                            ],
                          ),
                          SizedBox(height: 30,)
                          ,
                          Text("$hum",style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold
                          ),),
                          Text("Percent")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 150,),
              Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Made By Ali", style: TextStyle(fontWeight: FontWeight.w700)),
                    Text("Data Provided By Openweathermap.org", style: TextStyle(fontWeight: FontWeight.w700),)
                  ],
                ),
              )

            ],
          ),
        ),
      ),
      ),
    );
  }
}