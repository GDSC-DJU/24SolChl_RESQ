import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resq/states/location_controller.dart';
import 'package:resq/styles/theme.dart';
import 'package:resq/styles/colors.dart';
import 'package:resq/styles/constants.dart';
import 'package:resq/widgets/list_container_large.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Map<String, Object> accidentDescriptions = {};
List<String> accidentTypes = [];

class AccidentScreen extends StatefulWidget {
  const AccidentScreen({Key? key}) : super(key: key);

  @override
  _AccidentScreenState createState() => _AccidentScreenState();
}

class _AccidentScreenState extends State<AccidentScreen> {
  late final LocationTypeController locationController;
  late final TemperatureController temperatureController;
  late final AccidentTypeController accidentTypeController;

  @override
  void initState() {
    super.initState();
    locationController = Get.put(LocationTypeController());
    temperatureController = Get.put(TemperatureController());
    accidentTypeController = Get.put(AccidentTypeController());
    getDataFromFirestore();
    fetchData();
  }

  Future<void> fetchData() async {
    accidentDescriptions = await getDataFromFirestore();
    accidentTypeController.accidentTypes.value = getAccidentType(
        locationController.locationType.value,
        temperatureController.temperature.value);
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
                    text: '현재 위치에서 알아두시면 좋을\n', style: AppTheme.headlineMedium),
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
          angle: pi / 2,
          child: Image.asset(
            'assets/images/icon_arrow.png',
            fit: BoxFit.cover,
            height: 24,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          margin: const EdgeInsets.symmetric(
              horizontal: AppConstants.containerMarginHorizontal,
              vertical: AppConstants.containerMarginVertical),
          child: Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              ListContainerLarge(
                  title: accidentTypes[0],
                  imagePath:
                      accidentImages[accidentTypes[0]] ?? 'assets/icon.png',
                  description: accidentDescriptions[accidentTypes[0]] != null
                      ? (accidentDescriptions[accidentTypes[0]]
                              as Map<String, dynamic>)['의미']
                          .toString()
                      : "설명이 없어요..",
                  index: 0),
              ListContainerLarge(
                  title: accidentTypes[1],
                  imagePath:
                      accidentImages[accidentTypes[1]] ?? 'assets/icon.png',
                  description: accidentDescriptions[accidentTypes[1]] != null
                      ? (accidentDescriptions[accidentTypes[1]]
                              as Map<String, dynamic>)['의미']
                          .toString()
                      : "설명이 없어요..",
                  index: 1),
              ListContainerLarge(
                  title: accidentTypes[2],
                  imagePath:
                      accidentImages[accidentTypes[2]] ?? 'assets/icon.png',
                  description: accidentDescriptions[accidentTypes[2]] != null
                      ? (accidentDescriptions[accidentTypes[2]]
                              as Map<String, dynamic>)['의미']
                          .toString()
                      : "설명이 없어요..",
                  index: 2),
            ],
          ),
        ),
      ],
    );
  }
}

// 4번 코드
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
  '건물붕괴': 'assets/icon.png',
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
      '로딩 중입니다!',
      '잠시만 기다려주세요..',
      '금방 끝이 나요!!'
    ]; // 빈 문자열인 경우의 기본 사고 유형
  }
  accidentTypes.shuffle(); // 사고 유형 리스트를 랜덤하게 섞음
  return accidentTypes.sublist(0, 3); // 섞인 리스트에서 앞의 3개만 선택
}
