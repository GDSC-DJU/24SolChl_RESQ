import 'package:flutter/material.dart';
import '../styles/colors.dart';
import '../styles/theme.dart';

class MainProfile extends StatelessWidget {
  final String profileImageUrl;
  final String name;

  MainProfile({required this.profileImageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 25, 15, 25),
      color: AppColors.backgroundPrimary,
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center, 
            children: [
              Container(
                width: 58.0,
                height: 58.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.colorSecondary, AppColors.colorPrimary],
                  ),
                ),
              ),
              Container(
                width: 54.0,
                height: 54.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.backgroundPrimary,
                ),
                child: CircleAvatar(
                  foregroundImage: AssetImage(profileImageUrl),
                  backgroundColor: Colors.transparent,
                  radius: 27.0,
                ),
              ),
            ],
          ),

          const SizedBox(width: 15.0),
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '안녕하세요, ', style: AppTheme.headlineMedium),
                TextSpan(text: name, style: AppTheme.headlineBold),
                TextSpan(text: ' 탐험가님!', style: AppTheme.headlineMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}