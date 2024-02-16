import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:resq/states/location_controller.dart';
import 'package:resq/styles/colors.dart';
import 'package:resq/styles/constants.dart';
import 'package:resq/widgets/rectangle_icon_card.dart';

const googleElevationKey = "AIzaSyDFPyBxHHukkmlKfe3tfGwmSDIIiZE9clc";
const googlePlacesKey = "AIzaSyA2OoWCsbg8IaIzSBv4SvH7EZAAw30GVlU";
const weatherKey = "af461c953e205294f8b149d6a35ebf0e";

final locationTypeController = Get.put(LocationTypeController());

final accidentIcons = {
  "건물화재": 'assets/icons/icon.png',
  "교통사고": 'assets/icons/icon.png',
  "건물붕괴": 'assets/images/icon_cloud.png',
  "공사장 가림막 사고": 'assets/images/icon_arrow.png',
  "하천 침수": 'assets/images/icon_city.png',
  "가스폭발사고": 'assets/icons/icon_gas.png',
  "압사": 'assets/icons/icon_crush.png',
  "감전사고": 'assets/icons/icon_electric.png',
  "엘리베이터 사고": 'assets/icons/icon_elevator.png',
  "낙석사고": 'assets/icons/icon_rockfall.png',
  "산불사고": 'assets/icons/icon_forestfire.png',
  "산사태": 'assets/icons/icon_landslide.png',
  "낙하사고": 'assets/icons/icon_fall.png',
  "야생동물": 'assets/icons/icon_animal.png',
  "조난사고": 'assets/icons/icon_distress.png',
  "탈수": 'assets/icons/icon_dehydration.png',
  "일사병": 'assets/icons/icon_heatstroke.png',
  "고산병": 'assets/icons/icon_altitudesickness.png',
  "해양 익사": 'assets/icons/icon_drowning.png',
  "해변 낙상": 'assets/icons/icon_beachfall.png',
  "입수 후 저체온증": 'assets/icons/icon_hypothermia.png',
  "지진 해일 사고": 'assets/icons/icon_tsunami.png',
  "해양 생물에 의한 사고": 'assets/icons/icon_marine.png',
  "갯벌 사고": 'assets/icons/icon_mudflats.png',
  "선박 침몰": 'assets/icons/icon_shipwreck.png',
  "낚시 장비 충돌": 'assets/icons/icon_fishing.png',
  "방파제 테트라포드 사고": 'assets/icons/icon_tetrapod.png'
}; //얘 왜 이미지를 못받아옴..?

class LocationBasedInformation extends StatefulWidget {
  const LocationBasedInformation({Key? key}) : super(key: key);

  @override
  _LocationBasedInformationState createState() =>
      _LocationBasedInformationState();
}

class _LocationBasedInformationState extends State<LocationBasedInformation> {
  late final AccidentTypeController
      accidentTypeController; // AccidentScreen 인스턴스 생성

  String? locationType; // 사용자의 위치 타입을 저장하는 상태 변수
  String weather = '';
  final weatherImages = {
    'Clear': 'assets/images/icon_sunny.png',
    'Clouds': 'assets/images/icon_cloud.png',
  };
  final locationImages = {
    '산': 'assets/images/icon_mountain.png',
    '바다': 'assets/images/icon_beach.png',
    '도시': 'assets/images/icon_city.png',
  };
  double temperature = 0.0; //

  @override
  void initState() {
    super.initState();
    accidentTypeController = Get.put(AccidentTypeController());
    determinePosition();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    int randomIndex = 0;
    String randomType = '데이터를 불러오는 중...';
    String imagePath = 'assets/images/icon_earthquake.png';

    if (accidentTypeController.accidentTypes.isNotEmpty) {
      randomIndex =
          Random().nextInt(accidentTypeController.accidentTypes.length);
      randomType = accidentTypeController.accidentTypes[randomIndex];
      imagePath =
          accidentIcons[randomType] ?? 'assets/images/icon_earthquake.png';
    }
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: AppConstants.containerMarginHorizontal,
          vertical: AppConstants.containerMarginVertical),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          color: AppColors.backgroundSecondary,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 1.0,
            ),
          ]),
      //color: AppColors.backgroundSecondary,
      child: Row(
        children: <Widget>[
          RectangleIconCard(
              title: '오늘 날씨',
              iconPath:
                  weatherImages[weather] ?? 'assets/images/icon_umbrella.png',
              description: '${temperature.toStringAsFixed(2)} °C'),
          const IconCardDevide(),
          RectangleIconCard(
              title: '현재 장소',
              iconPath:
                  locationImages[locationType] ?? 'assets/images/icon_city.png',
              description: locationType ?? '탐색중...'),
          const IconCardDevide(),
          RectangleIconCard(
              title: '빈출 사고', iconPath: imagePath, description: randomType)
        ],
      ),
    );
  }

  Future<void> determinePosition() async {
    //사용자 현재 위치 가져오기
    Position position = await Geolocator.getCurrentPosition(); //위치의 위도와 경도를 얻음

    // getCurrentPosition 위치를 기반으로 산, 바다, 도시 중 어디에 있는지 판단
    String locationTypeFromDetermine =
        await determineLocationType(position.latitude, position.longitude);
    // 위치 타입 결정
    setState(() {
      locationType = locationTypeFromDetermine;
    });
    locationTypeController.updateLocationType(locationTypeFromDetermine);
  }

  // Google Elevation API와 Google Places API를 사용하여 위치 타입을 판단하는 함수
  Future<String> determineLocationType(
      double latitude, double longitude) async {
    // Google Elevation API를 호출하여 고도를 얻음
    final elevationResponse = await http.get(
      Uri.parse(
          'https://maps.googleapis.com/maps/api/elevation/json?locations=$latitude,$longitude&key=$googleElevationKey'),
    );
    final elevationData = jsonDecode(elevationResponse.body);
    final elevation = elevationData['results'][0]['elevation'];

    // Google Places API를 호출하여 주변 장소를 얻음
    final placesResponse = await http.get(
      Uri.parse(
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=1500&key=$googlePlacesKey'),
    );
    final placesData = jsonDecode(placesResponse.body);
    final places = placesData['results'];

    // 고도와 주변 장소를 기반으로 위치 타입을 판단
    if (elevation > 1000) {
      // 고도가 1000m 이상이면 산으로 판단
      return '산';
    } else if (places.where((place) {
      if (place['types'] is List) {
        //types:장소의 타입을 나타내는 리스트
        return (place['types'] as List).contains('natural_feature');
      } //types에서 natural_feature를 포함하고 있는지 확인
      else {
        return false;
      }
    }).isNotEmpty) {
      //리스트가 비어있지 않다면
      // 주변에 자연 특징이 있는 장소가 있으면 바다로 판단(natural_feature가 꼭 바다를 의미 하는 건 아님)
      return '바다';
    } else {
      // 그 외의 경우는 도시로 판단
      return '도시';
    }
  }

  Future<void> getWeather() async {
    Position position = await Geolocator.getCurrentPosition();

    final response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$weatherKey'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        weather = data['weather'][0]['main'];
        temperature = data['main']['temp'] - 273.15; // Kelvin to Celsius
      });
    } else {
      print('Failed to load weather data.');
    }
  }
}
