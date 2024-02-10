import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resq/widgets/google_map_display.dart';
import 'package:resq/widgets/location_display.dart';
import 'package:resq/widgets/appbar.dart';
import 'package:resq/widgets/main_profile.dart';
import 'package:resq/widgets/location_based_information.dart';
import 'package:resq/widgets/call_floating_button.dart';
import 'package:resq/styles/colors.dart';
import 'accident_screen.dart';

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
        appBar: ResqAppBar(),
        backgroundColor: AppColors.backgroundPrimary,
        body: SingleChildScrollView(
          child: Column(
            children: [
              MainProfile(
                profileImageUrl: 'assets/images/avatar_adventurer.png',
                name: '홍길동',
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
              LocationBasedInformation(),
              const AccidentScreen(),
            ],
          ),
        ),
        floatingActionButton: CallFloatingButton(),
      ),
    );
  }
}
