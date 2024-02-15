import 'dart:math';
import 'package:flutter/material.dart';
import '../states/location_controller.dart';
import 'package:get/get.dart';
import 'package:resq/styles/theme.dart';
import 'package:resq/styles/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // 추가 부분

const String name = "홍길동";

Map<String, Object> accidentDescriptions = {}; // 전역 객체 선언(사고유형 리스트)
List<String> accidentTypes = []; // 전역 변수 선언((선택된 3개 사고유형)

class AccidentScreen extends StatefulWidget {
  const AccidentScreen({Key? key}) : super(key: key);

  @override
  _AccidentScreenState createState() => _AccidentScreenState();
}

class _AccidentScreenState extends State<AccidentScreen> {
  late final LocationTypeController locationController;
  late final TemperatureController temperatureController;

  @override
  void initState() {
    super.initState();
    locationController = Get.put(LocationTypeController());
    temperatureController = Get.put(TemperatureController());
    getDataFromFirestore(); // 추가(데이터 불러오기)
    fetchData(); // 추가(데이터 UI 새로고침)
  }

  Future<void> fetchData() async {
    //DB경로를 accidentDescriptions에 저장 및 새로고침(데이터 변경시)  UI를 최신 상태로 업데이트하는 역할
    accidentDescriptions = await getDataFromFirestore();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String locationType = locationController.locationType.value; // 위치 정보 가져오기
    double temperature = temperatureController.temperature.value; // 온도 정보 가져오기

    accidentTypes = getAccidentType(locationType, temperature); // 사고 유형 가져오기

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                const TextSpan(
                    text: '$name 님이 알아두시면 좋을\n',
                    style: AppTheme.headlineMedium),
                TextSpan(
                    text: '사고 유형',
                    style: AppTheme.headlineBold.copyWith(
                      color: AppColors.colorPrimary,
                      height: 2.0,
                    )),
                const TextSpan(
                    text: '을 분석해드릴게요!', style: AppTheme.headlineMedium),
              ],
            ),
          ),
        ),
        Transform.rotate(
          angle: pi / 2, // 90도 회전
          child: Image.asset(
            'assets/images/icon_arrow.png',
            fit: BoxFit.cover,
            height: 24,
          ),
        ),
        SectionWidget(
            title: accidentTypes[0],
            imagePath:
                accidentImages[accidentTypes[0]] ?? 'assets/icon.png', // 의미
            description: accidentDescriptions[accidentTypes[0]] != null
                ? (accidentDescriptions[accidentTypes[0]]
                        as Map<String, dynamic>)['의미']
                    .toString()
                : "설명이 없어요..",
            index: 0),
        SectionWidget(
            title: accidentTypes[1],
            imagePath: accidentImages[accidentTypes[1]] ?? 'assets/icon.png',
            description: accidentDescriptions[accidentTypes[1]] != null
                ? (accidentDescriptions[accidentTypes[1]]
                        as Map<String, dynamic>)['의미']
                    .toString()
                : "설명이 없어요..",
            index: 1),
        SectionWidget(
            title: accidentTypes[2],
            imagePath: accidentImages[accidentTypes[2]] ?? 'assets/icon.png',
            description: accidentDescriptions[accidentTypes[2]] != null
                ? (accidentDescriptions[accidentTypes[2]]
                        as Map<String, dynamic>)['의미']
                    .toString()
                : "설명이 없어요..",
            index: 2),
      ],
    );
  }
}

class SectionWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final String description;
  final int index;

  const SectionWidget(
      {Key? key,
      required this.title,
      required this.imagePath,
      required this.index,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showBottomSheet(context, index); // 찾은 인덱스를 _showBottomSheet 함수에 전달합니다.
      },
      child: Container(
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
                Image.asset(imagePath, width: 100, height: 100),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<Map<String, Object>> getDataFromFirestore() async {
  final firestore = FirebaseFirestore.instance;

  List<String> places = ['도시', '산', '바다']; // 사고장소 리스트
  Map<String, List<String>> accidentTypes = {
    // 사고 장소 세분화
    '도시': [
      "건물화재",
      "교통사고",
      "건물붕괴",
      "공사장 가림막 사고",
      "하천 침수",
      "가스폭발사고",
      "압사",
      "감전사고",
      "엘리베이터 사고"
    ],
    '산': ["낙석사고", "산불사고", "산사태", "낙하사고", "야생동물", "조난사고", "탈수", "일사병", "고산병"],
    '바다': [
      "해양 익사",
      "해변 낙상",
      "입수 후 저체온증",
      "지진 해일 사고",
      "해양 생물에 의한 사고",
      "갯벌 사고",
      "선박 침몰",
      "낚시 장비 충돌",
      "방파제 테트라포드 사고"
    ],
  };

  for (String place in places) {
    // 사고장소 반복문(도시,산,바다)
    for (String accidentType in accidentTypes[place]!) {
      // 각 사고장소(도시,산,바다) 세분화 반복문
      DocumentReference docRef = firestore // 문서위치 가져오기 (사고_ID까지)
          .collection('사고장소')
          .doc(place)
          .collection(accidentType)
          .doc("${accidentType}_ID");

      await docRef.get().then((DocumentSnapshot doc) {
        // 콜백 함수의 인자인 doc는 가져온 문서의 스냅샷입니다.
        if (doc.exists) {
          //가져온 문서가 존재하는지 확인
          Map<String, dynamic>? data = doc.data() as Map<String,
              dynamic>?; //  가져온 문서의 데이터를 맵으로 변환합니다. 이 맵의 키는 문자열, 값은 동적 타입입니다.

          accidentDescriptions[accidentType] = {
            //사고에 대한 설명은 "의미", "사례", "대처방안", "대비방안" 네 가지 항목으로 구성되며, 각 항목의 값은 Firestore 문서로부터 가져온 데이터입니다.
            '의미': data?['의미'],
            '사례': data?['사례'].join(", "),
            '대처방안': data?['대처방안'].join(", "),
            '대비방안': data?['대비방안'].join(", "),
          };
        } else {
          throw Exception("No document found at path: ${docRef.path}"); // 변경
        }
      }).catchError((error) {
        throw Exception(
            "Error occurred while fetching the document at path: ${docRef.path}, error: $error"); // 변경
      });
    }
  }

  return accidentDescriptions;
}

Map<String, String> accidentImages = {
  '건물화재': 'assets/images/fire.png',
  '건물붕괴+풍수해': 'assets/icon.png',
  //여기에 각 사고유형별 이미지 넣으면 됨
};

List<String> getAccidentType(String locationType, double temperature) {
  List<String> accidentTypes = [];

  if (locationType == '도시') {
    if (temperature >= 30.0) {
      accidentTypes = ['건물화재', '건물붕괴', '공사장 가림막 사고', '하천 침수'];
    } else if (temperature <= 10.0) {
      accidentTypes = ['건물붕괴', '공사장 가림막 사고', '하천 침수'];
    } else {
      accidentTypes = ['교통사고', '가스폭발사고', '압사', '감전사고', '엘리베이터 사고'];
    }
  } else if (locationType == '산') {
    if (temperature >= 30.0) {
      accidentTypes = ['산불사고', '일사병', '탈수'];
    } else if (temperature <= 10.0) {
      accidentTypes = ['산불사고', '산사태', '고산병'];
    } else {
      accidentTypes = ['낙석사고', '낙하사고', '야생동물', '조난사고'];
    }
  } else if (locationType == '바다') {
    if (temperature >= 30.0) {
      accidentTypes = ['해양 익사', '입수 후 저체온증', '해양 생물에 의한 사고'];
    } else if (temperature <= 10.0) {
      accidentTypes = ['입수 후 저체온증', '선박 침몰', '낚시 장비 충돌'];
    } else {
      accidentTypes = ['해변 낙상', '지진 해일 사고', '갯벌 사고', '선박 침몰', '방파제 테트라포드 사고'];
    }
  } else if (locationType.isEmpty) {
    accidentTypes = [
      '기본 사고 유형 1',
      '기본 사고 유형 2',
      '기본 사고 유형 3'
    ]; // 빈 문자열인 경우의 기본 사고 유형
  }
  accidentTypes.shuffle(); // 사고 유형 리스트를 랜덤하게 섞음
  return accidentTypes.sublist(0, 3); // 섞인 리스트에서 앞의 3개만 선택
}

// 바텀 시트 추가
void _showBottomSheet(BuildContext context, int index) {
  List<String> incidentName = accidentTypes;
  int incidentIndex = index; // 위젯에서 선택한 사고 유형의 인덱스를 저장

// 사례
  List<String> examples = (accidentDescriptions[incidentName[incidentIndex]]
          as Map<String, dynamic>)['사례']
      .split('., ');
  String example1 = examples[0];
  String example2 = examples.length > 1 ? examples[1] : '';

// 대처방안
  List<String> countermeasures =
      (accidentDescriptions[incidentName[incidentIndex]]
              as Map<String, dynamic>)['대처방안']
          .split('., ');
  String countermeasure1 = countermeasures[0];
  String countermeasure2 = countermeasures.length > 1 ? countermeasures[1] : '';
  String countermeasure3 = countermeasures.length > 2 ? countermeasures[2] : '';

// 대비방안
  List<String> precautions = (accidentDescriptions[incidentName[incidentIndex]]
          as Map<String, dynamic>)['대비방안']
      .split('., ');
  String precaution1 = precautions[0];
  String precaution2 = precautions.length > 1 ? precautions[1] : '';
  String precaution3 = precautions.length > 2 ? precautions[2] : '';

  // 선택한 사고 유형의 정보를 가져옴
  Scaffold.of(context).showBottomSheet<void>((BuildContext context) {
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
            return Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: <Widget>[
                  Text(
                    incidentName[incidentIndex], // 사고이름(추가)
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 14),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.0),
                    child: Text(
                      '대처 방안',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  const Text(
                    '이렇게 대처하세요',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 24),

                  StepContainer(
                    stepNumber: 'STEP 1',
                    text1: countermeasure1, // 추가(대처방안 1)
                    image: 'assets/icon.png',
                    stepNumberColor: Colors.red,
                    text1Style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    text2Style:
                        const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  const SizedBox(height: 16),

                  StepContainer(
                    stepNumber: 'STEP 2',
                    text1: countermeasure2, // 추가(대처방안 2)
                    image: 'assets/icon.png',
                    stepNumberColor: Colors.red,
                    text1Style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    text2Style:
                        const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  const SizedBox(height: 16),

                  StepContainer(
                    stepNumber: 'STEP 3',
                    text1: countermeasure3, // 추가(대처방안 3)
                    image: 'assets/icon.png',
                    stepNumberColor: Colors.red,
                    text1Style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    text2Style:
                        const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  const SizedBox(height: 25),

                  const Padding(
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
                  const SizedBox(height: 12),

                  Text(
                    example1, // 추가(사례 1)
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Text(
                    example2, // 추가(사례 2)
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 25),

                  const Padding(
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

                  const Text(
                    '이렇게 대비해보세요!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),

                  StepContainer(
                    stepNumber: 'STEP 1',
                    text1: precaution1, // 추가(대비방안 1)
                    image: 'assets/icon.png',
                    stepNumberColor: Colors.red,
                    text1Style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    text2Style:
                        const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  const SizedBox(height: 12),

                  StepContainer(
                    stepNumber: 'STEP 2',
                    text1: precaution2, // 추가(대비방안 2)
                    image: 'assets/icon.png',
                    stepNumberColor: Colors.red,
                    text1Style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    text2Style:
                        const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  const SizedBox(height: 12),

                  StepContainer(
                    stepNumber: 'STEP 3',
                    text1: precaution3, // 추가(대비방안 3)
                    image: 'assets/icon.png',
                    stepNumberColor: Colors.red,
                    text1Style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    text2Style:
                        const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  // 추가적인 컨텐츠를 여기에 배치할 수 있습니다
                ],
              ),
            );
          },
        );
      },
    );
  });
}

// StepContainer에서 따로 설정(폰트,크기,배치,색깔 등)할 수 있게 하는 코드임
class StepContainer extends StatelessWidget {
  final String stepNumber;
  final String text1; // 첫 번째 텍스트
  //final String text2; // 두 번째 텍스트
  final String image;
  final Color stepNumberColor; // stepNumber 텍스트 색상
  final TextStyle? text1Style; // 첫 번째 텍스트 스타일
  final TextStyle? text2Style; // 두 번째 텍스트 스타일

  const StepContainer({
    Key? key,
    required this.stepNumber,
    required this.text1,
    //required this.text2,
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
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 4.0),
                      //   child: Text(
                      //     text2,
                      //     style: text2Style ??
                      //         const TextStyle(
                      //             fontSize: 18, color: Colors.black), // 스타일 적용
                      //   ),
                      // ),
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
