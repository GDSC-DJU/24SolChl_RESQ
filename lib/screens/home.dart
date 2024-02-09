import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'google_map_display.dart';
import 'location_display.dart';
import '../widgets/appbar.dart';
import '../widgets/main_profile.dart';
import '../styles/colors.dart';
import 'accident_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: ResqAppBar(),
        backgroundColor: AppColors.backgroundPrimary, 
        body: SingleChildScrollView(
          child: Column(
            children: [
              MainProfile(
                profileImageUrl: 'assets/images/avatar_adventurer.png',
                name: '홍길동',
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LocationDisplay(),
                    Expanded(
                      child: const GoogleMapDisplay(),
                    ),
                  ],
                ),
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
