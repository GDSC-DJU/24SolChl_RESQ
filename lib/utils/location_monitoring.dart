import 'dart:async';
import 'package:get/get.dart';
import 'package:resq/states/location_controller.dart';
import 'package:resq/utils/notification.dart';

const MONITORING_INTERVAL = 5; // 모니터링 간격: 5분
const STAYING_CRITERIA = 15; // 위치 변화 기준: 15분

// 사용자 위치 모니터링
void monitorLocation() {
  int minCount = 0;
  String lastPlace = '';
  String currentPlace = '';

  final fullAddressController = Get.find<FullAddressController>();
  late String fullAddress = fullAddressController.fullAddress.value;

  // 일정 간격으로 위치 모니터링
  // 테스트를 할 떄는 Duration의 minutes를 seconds로 변환하여 사용
  Timer.periodic(const Duration(minutes: MONITORING_INTERVAL), (timer) async {
    // 주소에서 숫자 앞부분까지만 트리밍
    int index = fullAddress.indexOf(RegExp(r'[0-9]'));
    if (index != -1) {
      currentPlace = fullAddress.substring(0, index).trim();
    } else {
      currentPlace = fullAddress;
    }

    // 일정시간 후 장소 변화 여부 확인
    if (lastPlace == currentPlace) {
      minCount += MONITORING_INTERVAL;
    } else {
      minCount = 0;
    }
    lastPlace = currentPlace;

    // 일정 시간 장소 이동이 없을 시 알림 표출
    if (minCount >= STAYING_CRITERIA) {
      FlutterLocalNotification myInstance = FlutterLocalNotification();
      FlutterLocalNotification.init();
      FlutterLocalNotification.requestNotificationPermission();

      myInstance.showNotification();
      minCount = 0;
    }
  });
}
