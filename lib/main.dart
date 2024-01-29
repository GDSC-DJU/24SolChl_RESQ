import 'package:flutter/material.dart';
import './notification.dart';
import 'dart:async'; // 타이머 함수 사용

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 3)); // 3초 대기 (스플래시 화면)
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int tempFlag = 0;

  @override
  void initState() {
    // 초기화
    FlutterLocalNotification.init();

    // 3초 후 권한 요청
    Future.delayed(const Duration(seconds: 3),
        FlutterLocalNotification.requestNotificationPermission());
    super.initState();

    // 변수 모니터링
    startMonitoring();
  }

  // 변수 확인 후 알림 띄우기
  void checkAndShowNotification() {
    if (tempFlag >= 3) {
      // tempFlag가 3이면 알림 표출
      FlutterLocalNotification.showNotification();
      // 알림 표출 후 리셋
      setState(() {
        tempFlag = 0;
      });
    }
  }

  // 매초마다 변수 변화 모니터링
  void startMonitoring() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      checkAndShowNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => {
                setState(() {
                  tempFlag += 1;
                })
              },
              child: const Text("3번 클릭 후 알림 보내기"),
            ),
            Text('Flag: $tempFlag',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
