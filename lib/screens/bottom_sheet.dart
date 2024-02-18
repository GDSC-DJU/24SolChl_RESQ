import 'package:flutter/material.dart';
import 'package:resq/widgets/list_container.dart';
import 'package:resq/widgets/list_section_head.dart';
import 'package:resq/styles/colors.dart';
import 'package:resq/screens/accident_screen.dart'; // 추가
import 'package:youtube_player_flutter/youtube_player_flutter.dart'; // 추가

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

    // 행동 요령 영상 ID
    String videoId = (accidentDescriptions[incidentName[incidentIndex]]
            as Map<String, dynamic>)['행동 요령 영상 ID']
        .toString();

    // 타이틀
    List<String> titles = (accidentDescriptions[incidentName[incidentIndex]]
            as Map<String, dynamic>)['타이틀']
        .split(', ');

    String title1 = titles[0];
    String title2 = titles.length > 1 ? titles[1] : '';
    String title3 = titles.length > 2 ? titles[2] : '';

    /////////////////////////////////////////////////////////////////////////

    showModalBottomSheet<void>(
      // 시작
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        //2번
        YoutubePlayerController controller = YoutubePlayerController(
          initialVideoId: videoId, // 여기에 YouTube 영상 ID를 넣어주세요.
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        );

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

                      //3번
                      const Row(
                        children: [
                          SizedBox(width: 10),
                          Expanded(
                            // 텍스트를 넓게 확장하여 이미지와 올바르게 나란히 배치
                            child: Text(
                              '예방 및 행동요령',
                              textAlign: TextAlign.center, // 텍스트를 오른쪽 정렬
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      YoutubePlayer(
                        controller: controller,
                        showVideoProgressIndicator: true,
                        onReady: () {
                          print('Player is ready.');
                        },
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
                              //4번
                              Row(
                                crossAxisAlignment: CrossAxisAlignment
                                    .center, // 이미지와 텍스트를 세로 중앙에 맞춤
                                children: [
                                  Image.asset(
                                    'assets/images/icon_city.png', // 실제 이미지 파일명 (변경!!!!)
                                    width: 40, // 이미지의 너비
                                    height: 40, // 이미지의 높이
                                  ),
                                  const SizedBox(width: 10), // 이미지와 텍스트 사이의 간격
                                  Expanded(
                                    // 텍스트가 길어질 경우 오른쪽으로 넘치지 않도록 함
                                    child: ListSectionHead(
                                      headMain: incidentName[
                                          incidentIndex], // 사고이름(추가)
                                      headSub:
                                          '${incidentName[incidentIndex]} 이렇게 대처하세요.',
                                    ),
                                  ),
                                ],
                              ),

                              ListContainer(
                                subTitle: 'STEP 1',
                                title: title1,
                                body: countermeasure1, // 추가(대처방안 1)
                                imagePath: 'assets/icon.png',
                              ),

                              ListContainer(
                                subTitle: 'STEP 2',
                                title: title2,
                                body: countermeasure2, // 추가(대처방안 2)
                                imagePath: 'assets/icon.png',
                              ),

                              ListContainer(
                                subTitle: 'STEP 3',
                                title: title3,
                                body: countermeasure3, // 추가(대처방안 3)
                                imagePath: 'assets/icon.png',
                              ),

                              //5번
                              const SizedBox(height: 25),
                              // 행동 요령

                              const SizedBox(height: 25),
                              // 대비 방안
                              Row(
                                crossAxisAlignment: CrossAxisAlignment
                                    .center, // 이미지와 텍스트를 세로 중앙에 맞춤
                                children: [
                                  Image.asset(
                                    'assets/images/icon_city.png', // 실제 이미지 파일명
                                    width: 40, // 이미지의 너비
                                    height: 40, // 이미지의 높이
                                  ),
                                  const SizedBox(width: 10), // 이미지와 텍스트 사이의 간격
                                  const Expanded(
                                    // 텍스트가 길어질 경우 오른쪽으로 넘치지 않도록 함
                                    child: ListSectionHead(
                                      headMain: '대비 방안',
                                      headSub: '이렇게 대비해보세요!',
                                    ),
                                  ),
                                ],
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
