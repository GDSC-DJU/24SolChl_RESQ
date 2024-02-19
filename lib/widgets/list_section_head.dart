import 'package:flutter/material.dart';
import 'package:resq/styles/colors.dart';
import 'package:resq/styles/theme.dart';

class ListSectionHead extends StatelessWidget {
  final String headMain; // 첫 번째 텍스트
  final String headSub; // 두 번째 텍스트

  const ListSectionHead({
    Key? key,
    required this.headMain,
    this.headSub = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 30),
      Row(children: <Widget>[
        Text(
          headMain,
          style: AppTheme.headlineBold,
        ),
        const Expanded(
            child: Divider(
          thickness: 1,
          color: AppColors.shadowColor,
          indent: 10,
        ))
      ]),
      Text(
        headSub,
        style: AppTheme.bodyLight,
      ),
      const SizedBox(height: 30),
    ]);
  }
}
