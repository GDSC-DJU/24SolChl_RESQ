import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:resq/styles/theme.dart';
import 'package:resq/styles/colors.dart';

class CreditButton extends StatelessWidget {
  final String linkText;
  final String linkUrl;

  const CreditButton({
    Key? key, 
    required this.linkText, 
    required this.linkUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _launchURL,
      child: Text(linkText, style: AppTheme.subText),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) 
              return AppColors.shadowColor;
            return Colors.transparent; 
          },
        ),
      ),
    );
  }

  _launchURL() async {
    final url = linkUrl;

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
