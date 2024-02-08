import 'package:flutter/material.dart';
import 'states/location_controller.dart';
import 'package:get/get.dart';

class Accident_Screen extends StatelessWidget {
  const Accident_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final locationController = Get.put(LocationTypeController());
    String locationType = locationController.locationType.value; // 위치 정보 가져오기
    final temperatureController = Get.put(TemperatureController());
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
      {super.key,
      required this.title,
      required this.imagePath,
      required this.description});

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
    );
  }
}

Map<String, String> accidentDescriptions = {
  '건물화재': '건물화재에 대한 설명',
  '건물 붕괴+풍수해': '건물붕괴+풍수해에 대한 설명',
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
  '건물붕괴+풍수해': 'assets/images/building_collapse.png',
  //여기에 각 사고유형별 이미지 넣으면 됨
};

List<String> getAccidentType(String locationType, double temperature) {
  List<String> accidentTypes = [];

  if (locationType == '도시') {
    if (temperature >= 30.0) {
      accidentTypes = ['건물화재', '건물붕괴+풍수해', '공사장 가림막 사고', '하천 침수'];
    } else if (temperature <= 10.0) {
      accidentTypes = ['건물 붕괴+풍수해', '공사장 가림막 사고', '하천 침수'];
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