import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resq/screens/accident_screen.dart';
import 'package:resq/styles/colors.dart';
import 'package:resq/widgets/appbar.dart';
import 'package:resq/widgets/main_profile.dart';
import 'package:resq/widgets/location_display.dart';
import 'package:resq/widgets/location_based_information.dart';
import 'package:resq/widgets/google_map_display.dart';
import 'package:resq/widgets/call_floating_button.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const ResqAppBar(),
        backgroundColor: AppColors.backgroundPrimary,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const MainProfile(
                profileImageUrl: 'assets/images/avatar_adventurer.png',
                name: '사고',
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LocationDisplay(),
                    Expanded(
                      child: GoogleMapDisplay(),
                    ),
                  ],
                ),
              ),
              const LocationBasedInformation(),
              const AccidentScreen(),
            ],
          ),
        ),
        floatingActionButton: const CallFloatingButton(),
      ),
    );
  }
}
