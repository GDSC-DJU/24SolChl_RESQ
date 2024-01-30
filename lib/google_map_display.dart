import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GoogleMapDisplay extends StatefulWidget {
  const GoogleMapDisplay({Key? key}) : super(key: key);

  @override
  _GoogleMapDisplayState createState() => _GoogleMapDisplayState();
}

class _GoogleMapDisplayState extends State<GoogleMapDisplay> {
  late GoogleMapController mapController;
  String? locationType; // 사용자의 위치 타입을 저장하는 상태 변수

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Card(
          // 사용자의 위치 타입을 화면에 표시하는 카드
          child: ListTile(
            leading: const Icon(Icons.location_on), // 위치 아이콘
            title: Text(
              'You are in the $locationType', // 사용자의 위치 타입
            ),
          ),
        )
      ],
    );
  }

  Future<void> determinePosition() async {
    Position position = await Geolocator.getCurrentPosition();

    // 위치를 기반으로 산, 바다, 도시 중 어디에 있는지 판단
    String locationTypeFromDetermine =
        await determineLocationType(position.latitude, position.longitude);

    setState(() {
      locationType = locationTypeFromDetermine;
    });
  }

  // Google Elevation API와 Google Places API를 사용하여 위치 타입을 판단하는 함수
  Future<String> determineLocationType(
      double latitude, double longitude) async {
    // Google Elevation API를 호출하여 고도를 얻음
    final elevationResponse = await http.get(
      Uri.parse(
          'https://maps.googleapis.com/maps/api/elevation/json?locations=$latitude,$longitude&key=elevation key'),
    );
    final elevationData = jsonDecode(elevationResponse.body);
    final elevation = elevationData['results'][0]['elevation'];

    // Google Places API를 호출하여 주변 장소를 얻음
    final placesResponse = await http.get(
      Uri.parse(
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=1500&key=places key'),
    );
    final placesData = jsonDecode(placesResponse.body);
    final places = placesData['results'];

    // 고도와 주변 장소를 기반으로 위치 타입을 판단
    if (elevation > 1000) {
      // 고도가 1000m 이상이면 산으로 판단
      return 'mountain';
    } else if (places
        .where((place) => place['types'].contains('natural_feature'))
        .isNotEmpty) {
      // 주변에 자연 특징이 있는 장소가 있으면 바다로 판단
      return 'sea';
    } else {
      // 그 외의 경우는 도시로 판단
      return 'city';
    }
  }
}
