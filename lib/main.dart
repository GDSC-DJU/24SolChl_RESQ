import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'google_map_display.dart';
import 'location_display.dart';

void main() async {
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
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    //여기는 나중에 UI 수정 예정
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
