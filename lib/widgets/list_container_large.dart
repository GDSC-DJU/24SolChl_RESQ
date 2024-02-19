import 'package:flutter/material.dart';
import 'package:resq/screens/bottom_sheet.dart';

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
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                loadImage(imagePath), // 이 부분을 수정했습니다.
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
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
