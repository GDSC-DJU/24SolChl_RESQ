import 'package:flutter/material.dart';
import 'google_map_display.dart';
import 'location_display.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String weather = '';
  IconData weatherIcon = Icons.cloud;
  double temperature = 0.0; // 온도를 저장할 변수 추가

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  Future<void> getWeather() async {
    Position position = await Geolocator.getCurrentPosition();

    final response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=af461c953e205294f8b149d6a35ebf0e'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        weather = data['weather'][0]['main'];
        temperature = data['main']['temp'] - 273.15; // Kelvin to Celsius

        if (weather == 'Clear') {
          weatherIcon = Icons.wb_sunny;
        } else if (weather == 'Clouds') {
          weatherIcon = Icons.cloud;
        } else {
          // Rain, Snow 등
          weatherIcon = Icons.umbrella;
        }
      });
    } else {
      print('Failed to load weather data.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const LocationDisplay(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 3,
                child: const GoogleMapDisplay(),
              ),
              Row(
                // 추가된 버튼들
                children: [
                  Expanded(
                    // 버튼을 화면 가로길이로 균등하게 나눔
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(weatherIcon),
                          tooltip: 'Weather',
                          onPressed: () {},
                        ),
                        Text('${temperature.toStringAsFixed(2)} °C'), // 온도 출력
                      ],
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      tooltip: 'Add', //여기에 locationType 넣고싶음..
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: const Icon(Icons.remove),
                      tooltip: 'Remove',
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('추가 UI ${index + 1}'),
                      subtitle: Text('여기에 추가 예정 ${index + 1}'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _launchURL,
          tooltip: '119에 전화',
          child: const Icon(Icons.call),
        ),
      ),
    );
  }

  void _launchURL() async {
    const url = 'tel:119';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
