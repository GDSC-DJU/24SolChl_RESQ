import 'package:flutter/material.dart';

// 바텀 시트 기능을 실행하기 위한 runAPP 추후에는 사고 유형 리스트와 연결되야 함
void main() => runApp(const BottomSheetApp());

class BottomSheetApp extends StatelessWidget {
  const BottomSheetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Scaffold(
        body: BottomSheetExample(),
      ),
    );
  }
}
// 바텀 시트 기능

class BottomSheetExample extends StatelessWidget {
  const BottomSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('Show Fire Incident Steps'),
        onPressed: () => _showModalBottomSheet(context),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return ListView.builder(
              controller: scrollController,
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return const Padding(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    children: <Widget>[
                      Text(
                        '산불 화재 사고',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 14),
                      Text(
                        '산불 이후 대비 이렇게 대처하세요',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 24),
                      StepContainer(
                        stepNumber: 'STEP 1',
                        text1: '즉시 신고해요!',
                        text2: '산불이 발생한 경우, 즉시 119에 신고하고 대피하세요!.',
                        image: 'assets/step1.png',
                        stepNumberColor: Colors.red,
                        text1Style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        text2Style:
                            TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      SizedBox(height: 16),
                      StepContainer(
                        stepNumber: 'STEP 2',
                        text1: '바람을 파악해요!',
                        text2: '바람의 방향과 속도를 파악하고, 바람 반대 방향으로 등에 두고 대피하세요!',
                        image: 'assets/step2.png',
                        stepNumberColor: Colors.red,
                        text1Style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        text2Style:
                            TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      SizedBox(height: 16),
                      StepContainer(
                        stepNumber: 'STEP 3',
                        text1: '어디로 대피해야 하나요?',
                        text2:
                            '대피 장소는 불이 지나간 장소, 낮은 장소, 바위 뒤 등으로 산불보다 높은 장소를 피하고 불길로부터 멀리 떨어져야 해요!',
                        image: 'assets/step3.png',
                        stepNumberColor: Colors.red,
                        text1Style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        text2Style:
                            TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      StepContainer(
                        stepNumber: 'STEP 4',
                        text1: '덮쳐온다면 엎드려요!',
                        text2:
                            '불길이 가까워진다면 물이나 흙으로 몸, 얼굴 등을 적시거나 가리고, 불길이 지나갈 때까지 엎드려 있어요!',
                        image: 'assets/step4.png',
                        stepNumberColor: Colors.red,
                        text1Style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        text2Style:
                            TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      SizedBox(height: 25),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.0),
                        child: Text(
                          '대표 사례',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        '2020년 강원도 삼척시에서 발생한 대규모 산불\n' '(영상1첨가)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        '하와이 섬에서 발생한 대규모 산불\n' '(영상2첨가)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 25),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.0),
                        child: Text(
                          '대비 방안',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        '이렇게 대비해보세요!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 12),
                      StepContainer(
                        stepNumber: 'STEP 1',
                        text1: '산에 불을 지르거나 담배를 피우는 행위를 삼가야 해요!',
                        text2: '',
                        image: 'assets/step1.png',
                        stepNumberColor: Colors.red,
                        text1Style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        text2Style:
                            TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      SizedBox(height: 12),
                      StepContainer(
                        stepNumber: 'STEP 2',
                        text1: '산불이 발생하기 쉬운 봄철에는 산행을 자제해요!',
                        text2: '',
                        image: 'assets/step2.png',
                        stepNumberColor: Colors.red,
                        text1Style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        text2Style:
                            TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      SizedBox(height: 12),
                      StepContainer(
                        stepNumber: 'STEP 3',
                        text1: '산불 발생 시 대피방법을 숙지하고 있어야 해요!',
                        text2: '',
                        image: 'assets/step3.png',
                        stepNumberColor: Colors.red,
                        text1Style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        text2Style:
                            TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      // 추가적인 컨텐츠를 여기에 배치할 수 있습니다
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

// StepContainer에서 따로 설정(폰트,크기,배치,색깔 등)할 수 있게 하는 코드임
class StepContainer extends StatelessWidget {
  final String stepNumber;
  final String text1; // 첫 번째 텍스트
  final String text2; // 두 번째 텍스트
  final String image;
  final Color stepNumberColor; // stepNumber 텍스트 색상
  final TextStyle? text1Style; // 첫 번째 텍스트 스타일
  final TextStyle? text2Style; // 두 번째 텍스트 스타일

  const StepContainer({
    Key? key,
    required this.stepNumber,
    required this.text1,
    required this.text2,
    required this.image,
    this.stepNumberColor = Colors.black,
    this.text1Style,
    this.text2Style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // 가운데 정렬
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              stepNumber,
              textAlign: TextAlign.center, // 가운데 정렬
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: stepNumberColor,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(image, width: 100, height: 100),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        text1,
                        style: text1Style ??
                            const TextStyle(
                                fontSize: 18, color: Colors.black), // 스타일 적용
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          text2,
                          style: text2Style ??
                              const TextStyle(
                                  fontSize: 18, color: Colors.black), // 스타일 적용
                        ),
                      ),
                    ],
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
