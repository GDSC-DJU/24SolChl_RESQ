import 'package:flutter/material.dart';
import 'package:resq/widgets/list_container.dart';
import 'package:resq/widgets/list_section_head.dart';
import 'package:resq/styles/colors.dart';
import 'package:resq/screens/accident_screen.dart'; // 추가

class BottomSheetClass {
  void showBottomSheet(BuildContext context, int index) {
    List<String> incidentName =
        accidentTypes; // 전역 변수 accidentTypes를 가져옴 (선택된 3개 사고유형)
    int incidentIndex = index; // 위젯에서 선택한 사고 유형의 인덱스를 저장

// 대처방안
    List<String> countermeasures =
        (accidentDescriptions[incidentName[incidentIndex]]
                as Map<String, dynamic>)['대처방안']
            .split('., ');
    String countermeasure1 = countermeasures[0];
    String countermeasure2 =
        countermeasures.length > 1 ? countermeasures[1] : '';
    String countermeasure3 =
        countermeasures.length > 2 ? countermeasures[2] : '';

// 대비방안
    List<String> precautions =
        (accidentDescriptions[incidentName[incidentIndex]]
                as Map<String, dynamic>)['대비방안']
            .split('., ');
    String precaution1 = precautions[0];
    String precaution2 = precautions.length > 1 ? precautions[1] : '';
    String precaution3 = precautions.length > 2 ? precautions[2] : '';

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: AppColors.backgroundPrimary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 9.0, horizontal: 18.0),
                  child: Column(
                    children: <Widget>[
                      // 핸들
                      Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 18.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      // 스크롤 가능한 위젯
                      Expanded(
                          child: ListView.builder(
                        controller: scrollController,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // 대처 방안
                              ListSectionHead(
                                headMain:
                                    incidentName[incidentIndex], // 사고이름(추가)
                                headSub:
                                    '${incidentName[incidentIndex]} 이렇게 대처하세요.',
                              ),

                              ListContainer(
                                subTitle: 'STEP 1',
                                title: '즉시 신고해요!',
                                body: countermeasure1, // 추가(대처방안 1)
                                imagePath: 'assets/icon.png',
                              ),

                              ListContainer(
                                subTitle: 'STEP 2',
                                title: '바람을 파악해요!',
                                body: countermeasure2, // 추가(대처방안 2)
                                imagePath: 'assets/icon.png',
                              ),

                              ListContainer(
                                subTitle: 'STEP 3',
                                title: '어디로 대피해야 하나요?',
                                body: countermeasure3, // 추가(대처방안 3)
                                imagePath: 'assets/icon.png',
                              ),

                              // 대비 방안
                              const ListSectionHead(
                                headMain: '대비 방안',
                                headSub: '이렇게 대비해보세요!',
                              ),
                              const SizedBox(height: 12),

                              ListContainer(
                                subTitle: 'STEP 1',
                                title: precaution1, // 추가(대비방안 1)
                                imagePath: 'assets/icon.png',
                              ),

                              ListContainer(
                                subTitle: 'STEP 2',
                                title: precaution2, // 추가(대비방안 2)
                                imagePath: 'assets/icon.png',
                              ),

                              ListContainer(
                                subTitle: 'STEP 3',
                                title: precaution3, // 추가(대비방안 3)
                                imagePath: 'assets/icon.png',
                              ),
                              // 추가적인 컨텐츠를 여기에 배치할 수 있습니다
                            ],
                          );
                        },
                      )),
                    ],
                  )),
            );
          },
        );
      },
    );
  }
}
