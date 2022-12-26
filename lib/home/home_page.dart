import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:weather_app/home/search_page.dart';
import 'package:weather_app/model/model.dart';
import 'dart:io' show Platform;

import '../repository/get_info.dart';

class HomePage extends StatefulWidget {
  final String name1;
  HomePage({super.key, required this.name1});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RefreshController controller = RefreshController();
  Weather weatherdata = Weather();
  bool isLoading = true;

  Future<void> getInfo() async {
    isLoading;
    setState(() {});
    final data = await GetInfoRepository.getinfo(name: widget.name1);
    weatherdata = Weather.fromJson(data);
    isLoading = false;
    setState(() {});
  }

  bool checkHour(int index, Weather? snapshot) {
    return int.tryParse((snapshot
                    ?.forecast?.forecastday?.first.hour?[index].time ??
                "")
            .substring(
                (snapshot?.forecast?.forecastday?.first.hour?[index].time ?? "")
                        .indexOf(":") -
                    2,
                (snapshot?.forecast?.forecastday?.first.hour?[index].time ?? "")
                    .indexOf(":"))) ==
        TimeOfDay.now().hour;
  }

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
                  image: AssetImage('assets/images/night.png'),
                  fit: BoxFit.cover)),
          child: SmartRefresher(
            controller: controller,
            enablePullDown: true,
            onRefresh: () async {
              await getInfo();
              controller.refreshCompleted();
            },
            child: Column(
              children: [
                SizedBox(
                  height: 135,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  weatherdata.location?.name ?? '',
                  style: TextStyle(color: Colors.white, fontSize: 50),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${weatherdata.current?.tempC ?? ''}°',
                  style: TextStyle(color: Colors.white, fontSize: 35),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  weatherdata.current?.condition?.text ?? '',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ],
            ),
          ),
        ));
  }
}

   // Text('${data.current['temp_c']}'),