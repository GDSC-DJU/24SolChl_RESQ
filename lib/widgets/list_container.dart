import 'package:flutter/material.dart';
import 'package:resq/styles/colors.dart';
import 'package:resq/styles/theme.dart';

class ListContainer extends StatelessWidget {
  final String? subTitle;
  final String title;
  final String? body;
  final String imagePath;

  const ListContainer({
    Key? key,
    this.subTitle,
    required this.title,
    this.body,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0.0),
      decoration: const BoxDecoration(
        color: AppColors.backgroundPrimary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // 가운데 정렬
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0), 
                      color: AppColors.backgroundPrimary,
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.shadowColor, 
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: Image.asset(imagePath, width: 100, height: 100),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (subTitle != null) Text(
                            subTitle!,
                            style: AppTheme.subText.copyWith(color: AppColors.colorSecondary),
                          ),
                          Text(
                            title,
                            style: AppTheme.titleMedium,
                          ),
                          if (body != null) Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: Text(
                              body!,
                              style: AppTheme.bodyLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
