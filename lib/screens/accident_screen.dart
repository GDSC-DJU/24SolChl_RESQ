import 'package:flutter/material.dart';
import '../states/location_controller.dart';
import 'package:get/get.dart';

class Accident_Screen extends StatefulWidget {
  const Accident_Screen({Key? key}) : super(key: key);

  @override
  _Accident_ScreenState createState() => _Accident_ScreenState();
}

class _Accident_ScreenState extends State<Accident_Screen> {
  late final LocationTypeController locationController;
  late final TemperatureController temperatureController;

  @override
  void initState() {
    super.initState();
    locationController = Get.put(LocationTypeController());
    temperatureController = Get.put(TemperatureController());
  }

  @override
  Widget build(BuildContext context) {
    String locationType = locationController.locationType.value; // 위치 정보 가져오기
    double temperature = temperatureController.temperature.value; // 온도 정보 가져오기

    List<String> accidentTypes =
        getAccidentType(locationType, temperature); // 사고 유형 가져오기

    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(30.0),
          child: Text(
            '{탐험가} 님이 예방해야 하는\n 사고 유형을 분석해드릴게요!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SectionWidget(
            title: accidentTypes[0],
            imagePath: accidentImages[accidentTypes[0]] ?? 'assets/icon.png',
            description: accidentDescriptions[accidentTypes[0]] ?? "설명이 없어요.."),
        SectionWidget(
            title: accidentTypes[1],
            imagePath: accidentImages[accidentTypes[1]] ?? 'assets/icon.png',
            description: accidentDescriptions[accidentTypes[1]] ?? "설명이 없어요.."),
        SectionWidget(
            title: accidentTypes[2],
            imagePath: accidentImages[accidentTypes[2]] ?? 'assets/icon.png',
            description: accidentDescriptions[accidentTypes[2]] ?? "설명이 없어요.."),
      ],
    );
  }
}

class SectionWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final String description;

  const SectionWidget(
      {Key? key,
      required this.title,
      required this.imagePath,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showBottomSheet(context);
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

Map<String, String> accidentDescriptions = {
  '건물화재': '건물화재에 대한 설명',
  '건물붕괴+풍수해': '건물붕괴+풍수해에 대한 설명',
  '공사장 가림막 사고': '공사장 가림막 사고에 대한 설명',
  '하천 침수': '하천 침수에 대한 설명',
  '교통사고': '교통사고에 대한 설명',
  '가스폭발사고': '가스폭발사고에 대한 설명',
  '압사': '압사에 대한 설명',
  '감전사고': '감전사고에 대한 설명',
  '엘리베이터 사고': '엘리베이터 사고에 대한 설명',
  '산불사고': '산불사고에 대한 설명',
  '일사병': '일사병에 대한 설명',
  '탈수': '탈수에 대한 설명',
  '산사태': '산사태에 대한 설명',
  '고산병': '고산병에 대한 설명',
  '낙석사고': '낙석사고에 대한 설명',
  '낙하사고': '낙하사고에 대한 설명',
  '야생동물': '야생동물에 대한 설명',
  '조난사고': '조난사고에 대한 설명',
  '해양 익사': '해양 익사에 대한 설명',
  '입수 후 저체온증': '입수 후 저체온증에 대한 설명',
  '해양 생물에 의한 사고': '해양 생물에 의한 사고에 대한 설명',
  '선박 침몰': '선박 침몰에 대한 설명',
  '낚시 장비 충돌': '낚시 장비 충돌에 대한 설명',
  '해변 낙상': '해변 낙상에 대한 설명',
  '지진 해일 사고': '지진 해일 사고에 대한 설명',
  '갯벌 사고': '갯벌 사고에 대한 설명',
  '방파제 테트라포드 사고': '방파제 테트라포드 사고에 대한 설명',
  '기본 사고 유형 1': '기본 사고 유형 1에 대한 설명',
  '기본 사고 유형 2': '기본 사고 유형 2에 대한 설명',
  '기본 사고 유형 3':
      '기본 사고 유형 3에 대한 설명' //key value 형식의 mapping 방식. 섹션에 대한 설명 파트인데 여기에 DB 적재?? 확인 필요
};

Map<String, String> accidentImages = {
  '건물화재': 'assets/images/fire.png',
  '건물붕괴+풍수해': 'assets/icon.png',
  //여기에 각 사고유형별 이미지 넣으면 됨
};

List<String> getAccidentType(String locationType, double temperature) {
  List<String> accidentTypes = [];

  if (locationType == '도시') {
    if (temperature >= 30.0) {
      accidentTypes = ['건물화재', '건물붕괴+풍수해', '공사장 가림막 사고', '하천 침수'];
    } else if (temperature <= 10.0) {
      accidentTypes = ['건물붕괴+풍수해', '공사장 가림막 사고', '하천 침수'];
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

// 바텀 시트
void _showBottomSheet(BuildContext context) {
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
                    image: 'assets/icon.png',
                    stepNumberColor: Colors.red,
                    text1Style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    text2Style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  SizedBox(height: 16),
                  StepContainer(
                    stepNumber: 'STEP 2',
                    text1: '바람을 파악해요!',
                    text2: '바람의 방향과 속도를 파악하고, 바람 반대 방향으로 등에 두고 대피하세요!',
                    image: 'assets/icon.png',
                    stepNumberColor: Colors.red,
                    text1Style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    text2Style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  SizedBox(height: 16),
                  StepContainer(
                    stepNumber: 'STEP 3',
                    text1: '어디로 대피해야 하나요?',
                    text2:
                        '대피 장소는 불이 지나간 장소, 낮은 장소, 바위 뒤 등으로 산불보다 높은 장소를 피하고 불길로부터 멀리 떨어져야 해요!',
                    image: 'assets/icon.png',
                    stepNumberColor: Colors.red,
                    text1Style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    text2Style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  StepContainer(
                    stepNumber: 'STEP 4',
                    text1: '덮쳐온다면 엎드려요!',
                    text2:
                        '불길이 가까워진다면 물이나 흙으로 몸, 얼굴 등을 적시거나 가리고, 불길이 지나갈 때까지 엎드려 있어요!',
                    image: 'assets/icon.png',
                    stepNumberColor: Colors.red,
                    text1Style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    text2Style: TextStyle(fontSize: 18, color: Colors.black),
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
                    image: 'assets/icon.png',
                    stepNumberColor: Colors.red,
                    text1Style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    text2Style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  SizedBox(height: 12),
                  StepContainer(
                    stepNumber: 'STEP 2',
                    text1: '산불이 발생하기 쉬운 봄철에는 산행을 자제해요!',
                    text2: '',
                    image: 'assets/icon.png',
                    stepNumberColor: Colors.red,
                    text1Style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    text2Style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  SizedBox(height: 12),
                  StepContainer(
                    stepNumber: 'STEP 3',
                    text1: '산불 발생 시 대피방법을 숙지하고 있어야 해요!',
                    text2: '',
                    image: 'assets/icon.png',
                    stepNumberColor: Colors.red,
                    text1Style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    text2Style: TextStyle(fontSize: 18, color: Colors.black),
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
