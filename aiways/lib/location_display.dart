import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationDisplay extends StatefulWidget {
  const LocationDisplay({Key? key}) : super(key: key);

  @override
  _LocationDisplayState createState() => _LocationDisplayState();
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
      //denied -> 권한 거부 상태
      permission = await Geolocator.requestPermission();
      //위치 권한을 얻지 못하면 권한 요청
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
}
