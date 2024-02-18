import 'dart:async'; // StreamSubscription 클래스를 사용하기 위해 dart:async 패키지를 import합니다.
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class GoogleMapDisplay extends StatefulWidget {
  const GoogleMapDisplay({Key? key}) : super(key: key);

  @override
  _GoogleMapDisplayState createState() => _GoogleMapDisplayState();
}

class _GoogleMapDisplayState extends State<GoogleMapDisplay> {
  late GoogleMapController mapController;
  String? locationType;
  String weather = '';
  IconData weatherIcon = Icons.cloud;
  double temperature = 0.0;

  // 실시간 위치 추적을 위한 변수 추가
  // 기본값으로 초기 위치를 설정
  Position _currentPosition = Position(
    latitude: 37.5665, // 기본 위도
    longitude: 126.9780, // 기본 경도
    timestamp: DateTime.now(),
    accuracy: 0.0,
    altitude: 0.0,
    heading: 0.0,
    speed: 0.0,
    speedAccuracy: 0.0,
  );

  StreamSubscription<Position>? _positionStreamSubscription;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();

    // 실시간 위치 추적 설정
    _positionStreamSubscription = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 10, //10미터 이동 감지해서 위치 파악, 실시간성때문에. 테스트 필요함!
    ).listen(
      (Position position) {
        setState(() {
          _currentPosition = position;
          //빈출 사고 유형도 새로 받아오기
          //accident screen도 새로 받아오기
        });
      },
    );
  }

  @override
  void dispose() {
    // 스트림 구독을 취소하여 리소스를 해제
    _positionStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: _currentPosition == null
                ? const Center(child: CircularProgressIndicator())
                : GoogleMap(
                    onMapCreated: onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(_currentPosition.latitude,
                          _currentPosition.longitude),
                      zoom: 11.0,
                    ),
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    zoomControlsEnabled: true,
                  ),
          ),
        ],
      ),
    );
  }
}
