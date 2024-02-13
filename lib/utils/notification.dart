import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:resq/states/location_controller.dart';

class FlutterLocalNotification {
  final locationTypeController = Get.find<LocationTypeController>();
  late String locationType = locationTypeController.locationType.value;
  
  FlutterLocalNotification();

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static init() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    DarwinInitializationSettings iosInitializationSettings =
        const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static requestNotificationPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  // 알림 보내기
  Future<void> showNotification() async {
    print("mylocationType: $locationType");

    Map<String, String> locationMessages = {
      '산': '지금 산 속으로 여행을 떠나셨네요! 보물들을 찾기 전 조심해야 할 것들을 알려드릴게요!',
      '바다': '신비한 바다 속 세계로 떠나셨군요! 해저동물들과 깊은 바다의 위험에 대비해볼까요?',
      '도시': '활기찬 도시로의 여행을 시작하셨습니다! 복잡한 도시에서도 주의해야 할 것들이 있답니다!',
    };
    const locationUndefinedMessage = '새로운 곳으로 향하셨네요! 낯선 장소에서의 위험에 대비해보세요.';
    
    const notiTitle = "RESQ";
    String notiBody =
        locationMessages[locationType] ?? locationUndefinedMessage;

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel id', 'channel name',
            channelDescription: 'channel description',
            importance: Importance.max,
            priority: Priority.max,
            showWhen: false);

    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: DarwinNotificationDetails(badgeNumber: 1));

    await flutterLocalNotificationsPlugin.show(
        0, notiTitle, notiBody, notificationDetails);
  }
}
