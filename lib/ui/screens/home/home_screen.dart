import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neopop/neopop.dart';

import 'home_controller.dart';
import 'widgets/boat_widget.dart';
import 'widgets/play_ground_widget.dart';
import 'widgets/subject_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, snapshot) {
      var quarterTurns = 0;
      double subjectWidth = snapshot.maxWidth / 24;
      if (snapshot.maxWidth < snapshot.maxHeight) {
        quarterTurns = 1;
        subjectWidth = snapshot.maxHeight / 24;
      }
      double subjectHeight = (16 * subjectWidth) / 9;
      double boatWidth = subjectWidth * 3;
      double boatHeight = subjectHeight * 2;
      double boatPadding = subjectWidth * 0.6;

      developer.log(
        'maxWidth ${snapshot.maxWidth}',
      );
      developer.log(
        'maxHeight ${snapshot.maxHeight}',
      );
      developer.log(
        'quarterTurns $quarterTurns',
      );
      developer.log(
        'subjectHeight $subjectHeight',
      );
      developer.log(
        'subjectWidth $subjectWidth',
      );
      developer.log(
        'boatWidth $boatWidth',
      );
      developer.log(
        'boatHeight $boatHeight',
      );
      developer.log(
        'boatPadding $boatPadding',
      );

      return RotatedBox(
        quarterTurns: quarterTurns,
        child: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) {
            return Scaffold(
              backgroundColor: Colors.blue.shade300,
              body: Stack(
                children: [
                  PlayGroundWidget(
                    subjectWidth: subjectWidth,
                    leftSideWidget: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: controller.leftSide
                          .map(
                            (subject) => SubjectWidget(
                              subjectWidth: subjectWidth,
                              subjectHeight: subjectHeight,
                              subject: subject,
                              onSubjectTap: controller.onSubjectTap,
                            ),
                          )
                          .toList(),
                    ),
                    centerWidget: Stack(
                      children: [
                        BoatWidget(
                          boatWidth: boatWidth,
                          boatHeight: boatHeight,
                          boatPadding: boatPadding,
                          isBoatOnLeftSide: controller.isBoatOnLeftSide,
                          alignment: controller.alignment,
                          children: controller.onBoat
                              .map(
                                (subject) => SubjectWidget(
                                  subjectWidth: subjectWidth,
                                  subjectHeight: subjectHeight,
                                  subject: subject,
                                  onSubjectTap: controller.onSubjectTap,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                    rightSideWidget: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: controller.rightSide
                          .map(
                            (subject) => SubjectWidget(
                              subjectWidth: subjectWidth,
                              subjectHeight: subjectHeight,
                              subject: subject,
                              onSubjectTap: controller.onSubjectTap,
                            ),
                          )
                          .toList(),
                    ),
                    bottomLeftSideWidget: _buildMoveBoatButton(
                      controller.moveBoat,
                    ),
                    bottomRightSideWidget: _buildMoveBoatButton(
                      controller.moveBoat,
                    ),
                    bottomCenterWidget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (controller.isGameStarted && !controller.isGameEnded)
                          StreamBuilder(
                            stream: controller.gameStream,
                            builder: (context, snapshot) {
                              return Text(
                                controller.playingTime(),
                                style: const TextStyle(
                                  fontSize: 50,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        if (controller.isGameEnded)
                          Text(
                            controller.gameTime(),
                            style: const TextStyle(
                              fontSize: 50,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (controller.disableInteraction)
                    const ModalBarrier(
                      dismissible: false,
                      color: Colors.transparent,
                    ),
                  if (!controller.isGameStarted)
                    ..._buildStartGameWidgets(
                      controller.startGame,
                    ),
                  if (controller.isGameEnded)
                    ..._buildEndGameWidgets(
                      controller.resetGame,
                    ),
                ],
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildMoveBoatButton(Function moveBoat) {
    return Center(
      child: NeoPopTiltedButton(
        onTapUp: () => moveBoat(),
        child: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 80.0,
            vertical: 15,
          ),
          child: Text('Move boat'),
        ),
      ),
    );
  }

  List<Widget> _buildStartGameWidgets(startGame) {
    return [
      ModalBarrier(
        dismissible: false,
        color: Colors.grey.withOpacity(0.5),
      ),
      Center(
        child: NeoPopTiltedButton(
          color: Colors.green,
          onTapUp: () => startGame(),
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 80.0,
              vertical: 15,
            ),
            child: Text('Start'),
          ),
        ),
      )
    ];
  }

  List<Widget> _buildEndGameWidgets(resetGame) {
    return [
      ModalBarrier(
        dismissible: false,
        color: Colors.red.withOpacity(0.5),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NeoPopTiltedButton(
              color: Colors.orange,
              onTapUp: () => resetGame(),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 80.0,
                  vertical: 15,
                ),
                child: Text('Reset Game'),
              ),
            ),
            NeoPopTiltedButton(
              color: Colors.orange,
              onTapUp: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 80.0,
                  vertical: 15,
                ),
                child: Text('Leader Board'),
              ),
            ),
          ],
        ),
      )
    ];
  }
}
