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
  String? locationType; // 사용자의 위치 타입을 저장하는 상태 변수
  String weather = '';
  IconData weatherIcon = Icons.cloud;
  double temperature = 0.0; // 온도를 저장할 변수 추가

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  } //콜백함수, google map 위젯 생성될 때 호출, google map
  //제어 가능

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<Position>(
                future: Geolocator.getCurrentPosition(),
                builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
                  if (snapshot.hasData) {
                    return GoogleMap(
                      onMapCreated: onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                            snapshot.data!.latitude, snapshot.data!.longitude),
                        zoom: 11.0,
                      ),
                      myLocationButtonEnabled: true, // 현재 위치로 이동하는 버튼 활성화
                      myLocationEnabled: true, // 사용자의 현재 위치를 표시함
                      zoomControlsEnabled: true, // 줌 인/아웃 버튼 활성화
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ), 
      );
  }
}
