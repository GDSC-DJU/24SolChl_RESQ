import 'package:flutter/material.dart';
import '../styles/colors.dart';

class ResqAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const double appBarHeight = 90.0;

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(appBarHeight),
        child: Container(
          height: appBarHeight,
          decoration: const BoxDecoration(
            color: AppColors.backgroundPrimary,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 4.0,
                spreadRadius: -4,
                offset: Offset(0, 4)
              ),
            ],
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: kToolbarHeight,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.fromLTRB(10,8,10,8),
              child: Image.asset(
                'assets/images/logo.png', 
                fit: BoxFit.cover,
                height: 32,
              ),
            ),
          ),
        ),
      

    );
  }
}
