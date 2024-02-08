// 사고 유형 3개 추출 화면입니다.

import 'package:flutter/material.dart';

// 참고 UI 일뿐 완성X, 색상 부분은 색상변수로 통일(Style-color)
// 내가 테스트하려고 실행하려고 만든 runApp 부분
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MY_Budgets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
// 실행하려고 만든 build 부분. 추후에 main.dart에서 실행하려면 수정 필요

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // AppBar 보여주려고 만든 함수 나중에 main AppBar로 통일 필요
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'RESQ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        foregroundColor: Colors.red,
        backgroundColor: Colors.white,
        elevation: 0, // 제거된 AppBar의 그림자
      ), // 여기까지 AppBar 추후에 수정 필요
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[100],
          child: const Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(
                  '{탐험가} 님이 예방해야 하는\n 사고 유형을 분석해드릴게요!', // {탐험가} 부분에는 동적으로 바뀌는 변수로 바꿀 예정(사용자 설정)
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SectionWidget(title: '사고 유형 1', imagePath: 'assets/image1.jpg'),
              SectionWidget(title: '사고 유형 2', imagePath: 'assets/image2.jpg'),
              SectionWidget(title: '사고 유형 3', imagePath: 'assets/image3.jpg'),
              // 사고 유형 title, imagePath 부분은 DB 연결되는 변수로 수정 필요
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action button press handling
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.phone),
      ),
    );
  }
}

class SectionWidget extends StatelessWidget {
  final String title;
  final String imagePath;

  const SectionWidget(
      {super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Image.asset(imagePath,
                  width: 100, height: 100), // 이미지 크기는 필요에 따라 조절
              const SizedBox(width: 8.0),
              const Expanded(
                // 텍스트가 나머지 공간을 차지하도록
                child: Text(
                  '여기에 섹션에 대한 설명을 입력하세요.',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// DB 연결에 따라 변수로 다 바꾸면 text 입력부분이라던가 바뀔 수 있음. 구조만 참고 부탁