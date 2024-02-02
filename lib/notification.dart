import 'dart:async'; 
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'location_display.dart';


class FlutterLocalNotification {
  FlutterLocalNotification._();
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


  void monitorLocation() {

    // LocationDisplay 클래스의 인스턴스 생성
    LocationDisplay locationDisplay = LocationDisplay();

    // 인스턴스를 사용하여 position() 메서드 호출
    Timer.periodic(Duration(seconds: 1), (timer) async {
      // LocationDisplay 클래스의 _LocationDisplayState 클래스의 position() 메서드 호출
      String location = await LocationDisplay.determinePosition();
      print("current location in noti: $location");
      //String currentLocation = await determinePosition();
      // locationDisplay.determinePosition().then((value) {
      //   print('Current position: $value');
      // }).catchError((error) {
      //   print('Error occurred: $error');
      // });
    });
  }

  // 알림 보내기
  static Future<void> showNotification() async {

    const notiTitle = "AIWays";
    const notiBody = "애리 탐험가님!\n지금 산 속으로 여행을 떠나셨네요! 보물들을 찾기 전 조심해야 할 것들을 알려드릴게요!";

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

  void main(){
    monitorLocation();
  }
}