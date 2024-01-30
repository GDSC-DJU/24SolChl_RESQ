import 'package:flutter/material.dart';
import 'google_map_display.dart';
import 'location_display.dart';
import 'package:url_launcher/url_launcher.dart';

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

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
                //스크롤이 가능한 위젯이 스크롤 되지 않게 만들기
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
          //오른쪽 하단 버튼
          onPressed: _launchURL, // 실제 디바이스에서 테스트할 때 주석 해제
          tooltip: '119에 전화',
          child: const Icon(Icons.call),
        ),
      ),
    );
  }

  void _launchURL() async {
    // 119 전화하기
    const url = 'tel:119';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
    // => 이 부분은 에뮬레이터에선 실행 X, 디바이스 설치 테스트시 주석 해제 할 것
    // 전화 걸기 기능이 시뮬레이터에서는 지원되지 않기 때문에 발생하는 것
  }
}
