import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:resq/styles/colors.dart';

class CallFloatingButton extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _launchURL,
      tooltip: '119 전화 하기',
      backgroundColor: AppColors.colorPrimary,
      foregroundColor: AppColors.backgroundSecondary,
      splashColor: AppColors.colorSecondary,
      child: const Icon(Icons.call),
    );
  }

  void _launchURL() async {
    const url = 'tel:119';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
