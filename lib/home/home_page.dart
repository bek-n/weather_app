import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/home/search_page.dart';
import 'package:weather_app/model/model.dart';
import 'dart:io' show Platform;

import '../repository/get_info.dart';

class HomePage extends StatefulWidget {
  String name;
  HomePage({super.key, this.name = 'london'});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic data;
  GetInfoRepository api = GetInfoRepository();
  bool isLoading = true;

  Future<void> getInfo() async {
    isLoading;
    data = await api.getinfo(name: widget.name);
    isLoading = false;

    setState(() {});
  }

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 0, 4, 11),
          clipBehavior: Clip.hardEdge,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: ((context) => SearchPAge())));
          },
          child: Icon(Icons.search),
        ),
        extendBody: true,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 0, 4, 11),
          title: Text(
            'Weather',
            style: TextStyle(fontSize: 30),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/back.jpg'),
                  fit: BoxFit.cover)),
          child: isLoading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Platform.isAndroid
                        ? CircularProgressIndicator()
                        : CupertinoActivityIndicator()
                  ],
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 135,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '${data.location['name']}',
                      style: TextStyle(color: Colors.white, fontSize: 50),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${data.current['temp_c']}°',
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${data.current['condition']['text']}',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ],
                ),
        ));
  }
}

   // Text('${data.current['temp_c']}'),