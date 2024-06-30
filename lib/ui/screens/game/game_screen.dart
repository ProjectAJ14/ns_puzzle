import 'dart:developer' as developer;

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nes_ui/nes_ui.dart';

import '../home/widgets/footer.dart';
import 'game_controller.dart';
import 'widgets/boat_widget.dart';
import 'widgets/play_ground_widget.dart';
import 'widgets/subject_widget.dart';

const String instructions = '''There are 3 devils and 3 Ladies. 
       They all have to cross a river in a boat. 
       The boat can only carry two people at a time. 
       As long as there is an equal number of devils and ladies, 
       then devils will not eat Ladies. If the number of devils is 
       greater than the number of ladies on the same side of the river 
       then devils will eat the ladies. So how can we make all the 6 
       people arrive on the other side safely?''';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, snapshot) {
        const factor = 21;
        double subjectWidth = snapshot.maxWidth / factor;
        if (snapshot.maxWidth < snapshot.maxHeight) {
          subjectWidth = snapshot.maxHeight / factor;
        }
        double subjectHeight = (16 * subjectWidth) / 9;
        double boatWidth = subjectWidth * 3.5;
        double boatHeight = subjectHeight * 0.9;
        double boatPadding = subjectWidth * 0.1;

        developer.log('maxWidth ${snapshot.maxWidth}');
        developer.log('maxHeight ${snapshot.maxHeight}');
        developer.log('subjectHeight $subjectHeight');
        developer.log('subjectWidth $subjectWidth');
        developer.log('boatWidth $boatWidth');
        developer.log('boatHeight $boatHeight');
        developer.log('boatPadding $boatPadding');

        return GetBuilder<GameController>(
          init: GameController(),
          builder: (controller) {
            return Scaffold(
              backgroundColor: Colors.blue.shade300,
              body: NesScaffold(
                body: Builder(
                  builder: (context) {
                    void showSnackBar(String message) {
                      NesScaffoldMessenger.of(context).showSnackBar(
                        NesSnackbar(
                          text: message,
                          type: NesSnackbarType.error,
                        ),
                        alignment: Alignment.topRight,
                      );
                    }

                    return Column(
                      children: [
                        Flexible(
                          child: NesContainer(
                            padding: const EdgeInsets.only(),
                            child: Stack(
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
                                            onSubjectTap: (subject) =>
                                                controller.onSubjectTap(
                                              subject,
                                              onError: showSnackBar,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  centerWidget: BoatWidget(
                                    boatWidth: boatWidth,
                                    boatHeight: boatHeight,
                                    boatPadding: boatPadding,
                                    isBoatOnLeftSide:
                                        controller.isBoatOnLeftSide,
                                    alignment: controller.alignment,
                                    children: controller.onBoat
                                        .map(
                                          (subject) => SubjectWidget(
                                            subjectWidth: subjectWidth,
                                            subjectHeight: subjectHeight,
                                            subject: subject,
                                            onSubjectTap: (subject) =>
                                                controller.onSubjectTap(
                                              subject,
                                              onError: showSnackBar,
                                            ),
                                          ),
                                        )
                                        .toList(),
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
                                            onSubjectTap: (subject) =>
                                                controller.onSubjectTap(
                                              subject,
                                              onError: showSnackBar,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  bottomRightSideWidget: Center(
                                    child: NesButton(
                                      type: NesButtonType.warning,
                                      onPressed: () => controller.moveBoat(
                                        onError: showSnackBar,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 50.0,
                                          vertical: 15,
                                        ),
                                        child: Text(
                                          'Move',
                                        ),
                                      ),
                                    ),
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
                                          controller.getScore(),
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
                                    context,
                                    controller.startGame,
                                  ),
                                if (controller.isGameEnded &&
                                    !controller.isWinner)
                                  ..._buildEndGameWidgets(
                                    controller.resetGame,
                                    controller.endGameReason,
                                    controller.leaderBoardClick,
                                  ),
                                if (controller.isGameEnded &&
                                    controller.isWinner)
                                  ..._buildWinnerWidgets(controller),
                              ],
                            ),
                          ),
                        ),
                        const Footer(),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  List<Widget> _buildStartGameWidgets(BuildContext context, startGame) {
    return [
      ModalBarrier(
        dismissible: false,
        color: Colors.black.withOpacity(0.5),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: NesWindow(
              title: 'Instructions',
              child: Center(
                child: FittedBox(
                  child: Text(
                    instructions,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: NesButton(
                onPressed: () => startGame(),
                type: NesButtonType.primary,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 80.0,
                    vertical: 15,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Play',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      NesIcon(iconData: NesIcons.play),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ];
  }

  List<Widget> _buildEndGameWidgets(
    VoidCallback resetGame,
    String endGameReason,
    VoidCallback leaderBoardClick,
  ) {
    return [
      ModalBarrier(
        dismissible: false,
        color: Colors.red.withOpacity(0.5),
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
            Text(
              endGameReason,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w100,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            NesButton(
              type: NesButtonType.normal,
              onPressed: () => resetGame(),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 80.0,
                  vertical: 15,
                ),
                child: Text('Reset Game'),
              ),
            ),
            const SizedBox(height: 10),
            NesButton(
              type: NesButtonType.normal,
              onPressed: () => leaderBoardClick(),
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
      ),
    ];
  }

  List<Widget> _buildWinnerWidgets(
    GameController controller,
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
              'Score :  ${controller.getScore()}',
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
            NesButton(
              type: NesButtonType.normal,
              onPressed: () => controller.resetGame(),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 80.0,
                  vertical: 15,
                ),
                child: Text('Play Again'),
              ),
            ),
            const SizedBox(height: 10),
            NesButton(
              type: NesButtonType.normal,
              onPressed: () => controller.leaderBoardClick(),
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
      ),
    ];
  }
}
