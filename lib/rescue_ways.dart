// 사고 유형에 따른 대처방안, 사례 등 세부 페이지 입니다.

import 'package:flutter/material.dart';

// 실행하기 위한 runApp 혼동 X (main에서 진행할거라)
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fire Incident UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const FireIncidentPage(),
    );
  }
}
// MyApp도 아닐거임 코드 참고해서 수정

class FireIncidentPage extends StatelessWidget {
  const FireIncidentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('산불 화재 사고',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.grey[100], // Changed to grey color
              width: double.infinity, // Ensure it takes the full width
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      // 입력값에 따라 변수가 달리 봐야해서.. 이게 만약 맑음,도시 를 받으면 모두 바뀌어야 할텐데..
                      '산불 이후 대비 이렇게 대처하세요',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    StepContainer(
                      stepNumber: 'STEP 1',
                      text: '산 중턱 아래라면?',
                      image: 'assets/step1.png',
                      stepNumberColor: Colors.red, // STEP 번호에 원하는 색상 지정
                    ),
                    StepContainer(
                      stepNumber: 'STEP 2',
                      text: '산 중턱이라면?',
                      image: 'assets/step2.png',
                      stepNumberColor: Colors.red, // STEP 번호에 원하는 색상 지정
                    ),
                    StepContainer(
                      stepNumber: 'STEP 3',
                      text: '코와 입을 막아요!',
                      image: 'assets/step3.png',
                      stepNumberColor: Colors.red, // STEP 번호에 원하는 색상 지정
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.grey[100],
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      '산불 화재 사고 의 대표 사례',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    // This Container will hold the content that needs to be scrollable
                    SizedBox(
                      height: 300, // Set a height to the container
                      child: SingleChildScrollView(
                        child: Text(
                          '하와이 섬 화재 사고\n'
                          '강원도 산불 화재 사고\n'
                          '여기에 산불 화재 사고에 대한 자세한 내용을 추가하면 됩니다.\n'
                          '이 텍스트는 스크롤이 가능해야 하며, 여기에 추가 정보를 계속해서 넣을 수 있습니다.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 이건 아마 별개의 container에 대해 변경값을 설정하는 것일텐데.. 워낙 container로 나뉜게 많아서
// DB로 연결된 값들을 이 함수로 설정하는 것 같아.
class StepContainer extends StatelessWidget {
  final String stepNumber;
  final String text;
  final String image;
  final Color stepNumberColor; // stepNumber 텍스트 색상을 위한 새로운 매개변수

  const StepContainer({
    Key? key,
    required this.stepNumber,
    required this.text,
    required this.image,
    this.stepNumberColor = Colors.black, // 기본값은 검정색
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[100], // Container 배경색
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              stepNumber,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: stepNumberColor, // 적용된 stepNumber 폰트 색상
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(image, width: 100, height: 100), // 이미지 사이즈는 조정 필요
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black, // text 폰트 색상은 검정색으로 유지
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
