import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/subjects.dart';
import '../../../data/utils/methods.dart';
import '../../routes/route_constants.dart';

class HomeController extends GetxController {
  AlignmentGeometry alignment = Alignment.bottomRight;

  bool get isBoatOnLeftSide => alignment == Alignment.bottomLeft;

  bool get isBoatOnRightSide => alignment == Alignment.bottomRight;

  bool get isBoatFull => onBoat.length == 2;

  bool get isBoatNotFull => !isBoatFull;

  bool disableInteraction = false;

  DateTime? startTime;
  DateTime? endTime;

  bool get isGameStarted => startTime != null;

  bool get isGameEnded => endTime != null;

  bool get isWinner => isGameEnded && leftSide.length == 6;

  ConfettiController confettiController =
      ConfettiController(duration: const Duration(seconds: 10));

  @override
  void onClose() {
    confettiController.dispose();
    super.onClose();
  }

  Stream<int> gameStream = Stream.periodic(
    const Duration(milliseconds: 1),
    (index) => index,
  );

  List<Subject> leftSide = [];
  List<Subject> rightSide = [
    Devil(),
    Devil(),
    Devil(),
    Priest(),
    Priest(),
    Priest(),
  ];

  List<Subject> onBoat = [];

  void moveBoat() {
    if (onBoat.isEmpty) {
      Get.snackbar(
        'Error',
        'No one is on the boat',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 10,
      );
      return;
    }
    disableInteraction = true;
    update();
    if (isBoatOnLeftSide) {
      alignment = Alignment.bottomRight;
    } else {
      alignment = Alignment.bottomLeft;
    }
    update();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        checkGameEnd();
        disableInteraction = false;
        update();
      },
    );
  }

  void startGame() {
    startTime = DateTime.now();
    update();
  }

  void onSubjectTap(Subject subject) {
    //Is the subject on the boat?
    if (onBoat.contains(subject)) {
      //Remove from boat
      onBoat.remove(subject);
      if (isBoatOnLeftSide) {
        leftSide.insert(0, subject);
      } else {
        rightSide.insert(0, subject);
      }
    } else {
      if (isBoatFull) {
        Get.snackbar(
          'Error',
          'The boat is full',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 10,
        );
        return;
      }
      //Is the subject on the left side? and is the boat on the left side?
      if (leftSide.contains(subject) && isBoatOnLeftSide) {
        //Remove from left side
        leftSide.remove(subject);
        onBoat.insert(0, subject);
      } else if (rightSide.contains(subject) && isBoatOnRightSide) {
        //Remove from right side
        rightSide.remove(subject);
        onBoat.insert(0, subject);
      } else {
        Get.snackbar(
          'Error',
          'The Boat is not on the correct side',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 10,
        );
      }
    }
    update();
    checkWin();
  }

  String playingTime() {
    if (startTime == null) {
      return '00:00:00:000';
    }
    return DateTime.now()
        .difference(startTime!)
        .toHoursMinutesSecondsMilliseconds();
  }

  String gameTime() {
    if (endTime == null) {
      return '00:00:00:000';
    }
    return endTime!.difference(startTime!).toHoursMinutesSecondsMilliseconds();
  }

  void checkGameEnd() {
    // Check if devils are more than priests on right side including the boat
    List<Subject> rightList = [...rightSide];
    if (isBoatOnRightSide) {
      rightList.addAll(onBoat);
    }
    int totalDevils = rightList.whereType<Devil>().length;
    int totalPriests = rightList.whereType<Priest>().length;
    if (totalDevils > totalPriests && totalPriests > 0) {
      endGame();
      return;
    }
    // Check if devils are more than priests on left side including the boat
    List<Subject> leftList = [...leftSide];
    if (isBoatOnLeftSide) {
      leftList.addAll(onBoat);
    }
    totalDevils = leftList.whereType<Devil>().length;
    totalPriests = leftList.whereType<Priest>().length;
    if (totalDevils > totalPriests && totalPriests > 0) {
      endGame();
      return;
    }
  }

  void checkWin() {
    // Check if all devils and all priests are on the left side
    int totalDevils = leftSide.whereType<Devil>().length;
    int totalPriests = leftSide.whereType<Priest>().length;
    if (totalDevils + totalPriests == 6) {
      confettiController.play();
      endGame();
    }
  }

  void endGame() {
    endTime = DateTime.now();
    update();
  }

  void resetGame() {
    Get.offAllNamed(RouteConstants.splashScreen);
  }
}
