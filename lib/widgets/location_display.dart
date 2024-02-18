import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:resq/states/location_controller.dart';
import 'package:resq/styles/theme.dart';
import 'package:resq/styles/constants.dart';
import 'package:resq/utils/location_monitoring.dart';

const GEOCODE_API = "AIzaSyBd0AOAQD8FDGzLRJBlRFzsMP9qDcOUBrs";

class LocationDisplay extends StatefulWidget {
  const LocationDisplay({Key? key}) : super(key: key);

  @override
  _LocationDisplayState createState() => _LocationDisplayState();

  static determinePosition() {}
}

class _LocationDisplayState extends State<LocationDisplay> {
  late String location = '';
  final fullAddressController = Get.put(FullAddressController());

  @override
  void initState() {
    super.initState();
    determinePosition().then((result) {
      setState(() {
        location = result;
      });
      fullAddressController.updateLocationType(location);
      monitorLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.containerMarginHorizontal,
        vertical: AppConstants.containerMarginVertical
      ),
      child: Text(
        ' |  현재 위치: $location',
        style: AppTheme.subText, 
        textAlign: TextAlign.left
      ),

    );
  }

  Future<String> determinePosition() async {
    //사용자 현재 위치 가져옴
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    //위치 서비스가 활성화 돼 있는지 확인
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // denied -> 권한 거부 상태
      permission = await Geolocator.requestPermission();
      // 위치 권한을 얻지 못하면 권한 요청
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    String roadAddress = await getStreetAddress(
        // 도로명 주소 함수 호출
        position.latitude,
        position.longitude); // 도로명 주소 획득
    return roadAddress;
  }

  Future<String> getStreetAddress(double latitude, double longitude) async {
    //도로명 주소 획득 함수
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$GEOCODE_API&language=ko'));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseJson = jsonDecode(response.body);
      String roadAddress = responseJson['results'][0]['formatted_address'];
      return roadAddress;
    } else {
      throw Exception('Failed to load street address');
    }
  }
}
