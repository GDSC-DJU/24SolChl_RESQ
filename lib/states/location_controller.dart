import 'package:get/get.dart';

// 현재 위치 상태 관리
class FullAddressController extends GetxController {
  RxString fullAddress = ''.obs;

  void updateLocationType(String newAddress) {
    fullAddress.value = newAddress;
    print("Current Location: $fullAddress");
  }
}

// 장소 타입(산/바다/도시) 상태 관리
class LocationTypeController extends GetxController {
  RxString locationType = ''.obs;

  void updateLocationType(String newType) {
    locationType.value = newType;
    print("now Type: $locationType");
  }
}

// 온도 상태 관리
class TemperatureController extends GetxController {
  RxDouble temperature = 0.0.obs;

  void updateTemperature(double newTemperature) {
    temperature.value = newTemperature;
    print("Current Temperature: $temperature");
  }
}

class AccidentTypeController extends GetxController {
  var accidentTypes = List<String>.empty(growable: true).obs;
  RxString accidentType = ''.obs;

  void updateAccidentType(String newType) {
    accidentType.value = newType; // 빈출 사고 유형을 업데이트하는 메소드
  }
}
