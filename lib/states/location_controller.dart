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