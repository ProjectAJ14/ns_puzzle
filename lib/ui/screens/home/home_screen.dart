import 'dart:developer' as developer;

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neopop/neopop.dart';

import 'home_controller.dart';
import 'widgets/boat_widget.dart';
import 'widgets/play_ground_widget.dart';
import 'widgets/subject_widget.dart';

const String problemStatement = '''There are 3 devils and 3 Priests. 
       They all have to cross a river in a boat. 
       The boat can only carry two people at a time. 
       As long as there is an equal number of devils and priests, 
       then devils will not eat Priest. If the number of devils is 
       greater than the number of priests on the same side of the river 
       then devils will eat the priests. So how can we make all the 6 
       people arrive on the other side safely?''';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, snapshot) {
        var quarterTurns = 0;
        double subjectWidth = snapshot.maxWidth / 24;
        if (snapshot.maxWidth < snapshot.maxHeight) {
          quarterTurns = 1;
          subjectWidth = snapshot.maxHeight / 24;
        }
        double subjectHeight = (16 * subjectWidth) / 9;
        double boatWidth = subjectWidth * 3.5;
        double boatHeight = subjectHeight / 2;
        double boatPadding = subjectWidth * 0.3;

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
                  clipBehavior: Clip.none,
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
                        clipBehavior: Clip.none,
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
                      bottomRightSideWidget: _buildMoveBoatButton(
                        controller,
                      ),
                      bottomCenterWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (controller.isGameStarted &&
                              !controller.isGameEnded)
                            StreamBuilder(
                              stream: controller.gameStream,
                              builder: (context, snapshot) {
                                return Text(
                                  controller.getScore(),
                                  style: const TextStyle(
                                    fontSize: 50,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          if (controller.isGameEnded)
                            Text(
                              controller.getFinalScore(),
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
                    if (controller.isGameEnded && !controller.isWinner)
                      ..._buildEndGameWidgets(
                        controller.resetGame,
                      ),
                    if (controller.isGameEnded && controller.isWinner)
                      ..._buildWinnerWidgets(controller),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildMoveBoatButton(HomeController controller) {
    return Center(
      child: NeoPopTiltedButton(
        onTapUp: () => controller.moveBoat(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50.0,
            vertical: 15,
          ),
          child: Icon(
            controller.isBoatOnLeftSide
                ? Icons.arrow_forward
                : Icons.arrow_back,
            size: 50,
            color: Colors.amber,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildStartGameWidgets(startGame) {
    return [
      ModalBarrier(
        dismissible: false,
        color: Colors.black.withOpacity(0.5),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Center(
            child: FittedBox(
              child: Text(
                problemStatement,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
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
            ),
          )
        ],
      )
    ];
  }

  List<Widget> _buildEndGameWidgets(resetGame) {
    return [
      ModalBarrier(
        dismissible: false,
        color: Colors.red.withOpacity(0.9),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'GAME OVER',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
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

  List<Widget> _buildWinnerWidgets(
    HomeController controller,
  ) {
    return [
      ModalBarrier(
        dismissible: false,
        color: Colors.green.withOpacity(0.8),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'YOU WON!!!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Time taken ${controller.getFinalScore()}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: controller.confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple,
                  Colors.red,
                ],
                numberOfParticles: 100,
                maxBlastForce: 100,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            NeoPopTiltedButton(
              color: Colors.orange,
              onTapUp: () => controller.resetGame(),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 80.0,
                  vertical: 15,
                ),
                child: Text('Play Again'),
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
