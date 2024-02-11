import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resq/states/location_controller.dart';
import 'package:resq/styles/theme.dart';
import 'package:resq/styles/colors.dart';
import 'package:resq/styles/constants.dart';
import 'package:resq/widgets/list_container_large.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    String locationType = locationController.locationType.value; // 위치 정보 가져오기
    double temperature = temperatureController.temperature.value; // 온도 정보 가져오기

    List<String> accidentTypes =
        getAccidentType(locationType, temperature); // 사고 유형 가져오기

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(30.0),
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '현재 위치에서 알아두시면 좋을\n', style: AppTheme.headlineMedium),
                TextSpan(text: '사고 유형', style: AppTheme.headlineBold.copyWith(color: AppColors.colorPrimary, height: 2.0,)),
                TextSpan(text: '을 분석해드릴게요!', style: AppTheme.headlineMedium),
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
        const SizedBox(height: 10.0,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: AppConstants.containerMarginHorizontal, vertical: AppConstants.containerMarginVertical),
          child: Column(
            children: [
              const SizedBox(height: 10.0,),
              ListContainerLarge(
                title: accidentTypes[0],
                imagePath: accidentImages[accidentTypes[0]] ?? 'assets/icon.png',
                description: accidentDescriptions[accidentTypes[0]] ?? "설명이 없어요.."
              ),
              ListContainerLarge(
                title: accidentTypes[1],
                imagePath: accidentImages[accidentTypes[1]] ?? 'assets/icon.png',
                description: accidentDescriptions[accidentTypes[1]] ?? "설명이 없어요.."
              ),
              ListContainerLarge(
                title: accidentTypes[2],
                imagePath: accidentImages[accidentTypes[2]] ?? 'assets/icon.png',
                description: accidentDescriptions[accidentTypes[2]] ?? "설명이 없어요.."
              ),      
            ],
          ),
        ),
      ],
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
