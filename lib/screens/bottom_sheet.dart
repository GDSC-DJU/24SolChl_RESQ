import 'package:flutter/material.dart';
import 'package:resq/widgets/list_container.dart';
import 'package:resq/widgets/list_section_head.dart';
import 'package:resq/styles/colors.dart';

class BottomSheetClass{
  void showBottomSheet(BuildContext context) {
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
                padding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 18.0),
                child: Column(
                  children: <Widget>[
                    // 핸들
                    Container(
                      width: 40,
                      height: 4,
                      margin: EdgeInsets.only(bottom: 18.0),
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
                          return const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // 대처 방안
                              ListSectionHead(
                                headMain: '산불 화재 사고',
                                headSub: '산불 이후 이렇게 대처하세요.',
                              ),
                              ListContainer(
                                subTitle: 'STEP 1',
                                title: '즉시 신고해요!',
                                body: '산불이 발생한 경우, 즉시 119에 신고하고 대피하세요!.',
                                imagePath: 'assets/icon.png',
                              ),
                              ListContainer(
                                subTitle: 'STEP 2',
                                title: '바람을 파악해요!',
                                body: '바람의 방향과 속도를 파악하고, 바람 반대 방향으로 등에 두고 대피하세요!',
                                imagePath: 'assets/icon.png',
                              ),
                              ListContainer(
                                subTitle: 'STEP 3',
                                title: '어디로 대피해야 하나요?',
                                body:
                                    '대피 장소는 불이 지나간 장소, 낮은 장소, 바위 뒤 등으로 산불보다 높은 장소를 피하고 불길로부터 멀리 떨어져야 해요!',
                                imagePath: 'assets/icon.png',
                              ),
                              ListContainer(
                                subTitle: 'STEP 4',
                                title: '덮쳐온다면 엎드려요!',
                                body:
                                    '불길이 가까워진다면 물이나 흙으로 몸, 얼굴 등을 적시거나 가리고, 불길이 지나갈 때까지 엎드려 있어요!',
                                imagePath: 'assets/icon.png',
                              ),
                              SizedBox(height: 25),
                              // 대표 사례
                              ListSectionHead(
                                headMain: '대표 사례',
                              ),
                              SizedBox(height: 12),
                              Text(
                                '2020년 강원도 삼척시에서 발생한 대규모 산불\n' '(영상1첨가)',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                '하와이 섬에서 발생한 대규모 산불\n' '(영상2첨가)',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 25),
                              // 대비 방안
                              ListSectionHead(
                                headMain: '대비 방안',
                                headSub: '이렇게 대비해보세요!',
                              ),
                              SizedBox(height: 12),
                              ListContainer(
                                subTitle: 'STEP 1',
                                title: '산에 불을 지르거나 담배를 피우는 행위를 삼가야 해요!',
                                imagePath: 'assets/icon.png',
                              ),
                              ListContainer(
                                subTitle: 'STEP 2',
                                title: '산불이 발생하기 쉬운 봄철에는 산행을 자제해요!',
                                imagePath: 'assets/icon.png',
                              ),
                              ListContainer(
                                subTitle: 'STEP 3',
                                title: '산불 발생 시 대피방법을 숙지하고 있어야 해요!',
                                imagePath: 'assets/icon.png',
                              ),
                              // 추가적인 컨텐츠를 여기에 배치할 수 있습니다
                            ],
                          );
                        },
                      )
                    ),
                  ],
                )
              ),    
            );
          },
        );
      },
    );
  }
}
