import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'google_map_display.dart';
import 'location_display.dart';
import 'accident_screen.dart';

import 'package:firebase_core/firebase_core.dart'; // 파이어베이스 설정
import 'firebase_options.dart'; // 파이어베이스 설정

void main() async {
  // 비동기로 파이어 베이스 실행
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
              const Accident_Screen(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _launchURL,
          tooltip: '119 전화 하기',
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
