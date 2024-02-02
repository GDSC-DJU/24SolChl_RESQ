import 'dart:async'; 
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import './notification.dart';

const MONITORING_INTERVAL = 5; // 모니터링 간격: 5분
const STAYING_CRITERIA = 15; // 위치 변화 기준: 15분 

class LocationDisplay extends StatefulWidget {
  const LocationDisplay({Key? key}) : super(key: key);

  @override
  _LocationDisplayState createState() => _LocationDisplayState();

  static determinePosition() {}

}

class _LocationDisplayState extends State<LocationDisplay> {
  late String location = '';

  @override
  void initState() {
    super.initState();
    determinePosition().then((result) {
      setState(() {
        location = result;
      });
      monitorLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('현재위치: $location', style: const TextStyle(fontSize: 15.0));
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
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    //해당 위치 지명으로 가져오기
    return placemarks.first.street ?? 'Unknown location';
  }

  void monitorLocation() {
    int minCount = 0;
    String lastPlace = '';
    String currentPlace = '';

    // 5분 간격으로 위치 모니터링
    // 테스트를 할 떄는 Duration(minutes: 5) -> Duration(seconds: 5)로 변환하여 사용
    Timer.periodic(const Duration(seconds: MONITORING_INTERVAL), (timer) async {

      // 주소에서 숫자 앞부분까지만 트리밍
      int index = location.indexOf(RegExp(r'[0-9]'));
      if (index != -1) {
        currentPlace = location.substring(0, index).trim();
      } else {
        currentPlace = location;
      }

      // 일정시간 후 장소 변화 여부 확인
      if(lastPlace == currentPlace){
        minCount += MONITORING_INTERVAL;
      } else{
        minCount = 0;
      }
      lastPlace = currentPlace;

      // 일정 시간 장소 이동이 없을 시 알림 표출
      if(minCount >= STAYING_CRITERIA){
        // 초기화
        FlutterLocalNotification.init();

        FlutterLocalNotification.requestNotificationPermission();
        FlutterLocalNotification.showNotification();
        minCount = 0;
      }
      
    });
  }
}
