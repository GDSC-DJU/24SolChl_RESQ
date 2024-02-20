import 'package:flutter/material.dart';
import 'package:resq/styles/constants.dart';
import 'package:resq/widgets/text_link.dart';

class AppInfo extends StatelessWidget  {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.containerMarginHorizontal,
        vertical: AppConstants.containerMarginVertical,
      ),
      child: const Column(
        children: <Widget>[
          CreditButton(linkText: '깃허브 바로가기', linkUrl: 'https://github.com/GDSC-DJU/24SolChl_RESQ/tree/space',),
          CreditButton(linkText: '라이센스 정보', linkUrl: 'https://github.com/GDSC-DJU/24SolChl_RESQ/tree/space?tab=readme-ov-file#credits',),
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}