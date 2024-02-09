import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_launcher/url_launcher.dart';
import 'firebase_options.dart';
import 'widgets/google_map_display.dart';
import 'widgets/location_display.dart';
import 'widgets/appbar.dart';
import 'widgets/main_profile.dart';
import 'styles/colors.dart';
import 'screens/accident_screen.dart';
import 'screens/home.dart';

void main() async {
  // 비동기로 파이어 베이스 실행
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Home());
}
