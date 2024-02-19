import 'package:flutter/material.dart';
import 'package:resq/screens/bottom_sheet.dart';
import 'package:resq/styles/theme.dart';

Widget loadImage(String imagePath) {
  if (imagePath.startsWith('http') || imagePath.startsWith('https')) {
    return Image.network(imagePath, width: 100, height: 100);
  } else {
    return Image.asset(imagePath, width: 100, height: 100);
  }
}

BottomSheetClass bottomSheetClass = BottomSheetClass();

class ListContainerLarge extends StatelessWidget {
  final String title;
  final String imagePath;
  final String description;
  final int index;

  const ListContainerLarge(
      {Key? key,
      required this.title,
      required this.index,
      required this.imagePath,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        bottomSheetClass.showBottomSheet(context, index);
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: AppTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                loadImage(imagePath), // �� �κ��� �����߽��ϴ�.
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    description,
                    style: AppTheme.bodyLight,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
