import 'dart:async';
import 'dart:developer' as developer;

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/subjects.dart';
import '../../../data/models/user.dart';
import '../../../data/services/auth/auth_service.dart';
import '../../../data/services/firestore/firestore_service.dart';
import '../../../data/utils/methods.dart';
import '../../routes/route_constants.dart';

const int totalScore = 100;

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

  String endGameReason = '';

  ConfettiController confettiController =
      ConfettiController(duration: const Duration(seconds: 10));

  Stream<int> gameStream = Stream.periodic(
    const Duration(milliseconds: 1),
    (index) => index,
  ).asBroadcastStream();

  @override
  void onInit() {
    super.onInit();
    gameStream.listen(_gameListener);
  }

  void _gameListener(event) {
    int score = _calculateScore();
    if (score <= 0 && !isGameEnded && isGameStarted) {
      endGame(
        reason: 'You ran out of time!',
      );
    } else {
      developer.log("score: $score");
    }
  }

  @override
  void onClose() {
    confettiController.dispose();
    super.onClose();
  }

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

  String getScore() {
    int score = _calculateScore();
    return score.toTwoDigits();
  }

  String userWonGetScore() {
    int score = _calculateScore();
    fireStore.addUser(
      user: User(
        displayName: auth.userName,
        score: score,
        email: auth.userEmail,
      ),
    );
    return score.toTwoDigits();
  }

  void leaderBoardClick() {
    Get.toNamed(RouteConstants.topUsers);
  }

  int _calculateScore() {
    if (startTime == null) {
      return 0;
    }
    Duration duration;
    if (endTime == null) {
      duration = DateTime.now().difference(startTime!);
    } else {
      duration = endTime!.difference(startTime!);
    }
    int score = totalScore - duration.inSeconds;
    return score;
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
      //Mark all priest as dead
      rightList.whereType<Priest>().forEach((element) {
        element.markDead();
      });
      endGame(
        reason: 'Devils ate the priests on the right side',
      );
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
      //Mark all priest as dead
      leftList.whereType<Priest>().forEach((element) {
        element.markDead();
      });

      endGame(
        reason: 'Devils ate the priests on the left side',
      );
      return;
    }
  }

  void checkWin() {
    // Check if all devils and all priests are on the left side
    int totalDevils = leftSide.whereType<Devil>().length;
    int totalPriests = leftSide.whereType<Priest>().length;
    if (totalDevils + totalPriests == 6) {
      endTime = DateTime.now();
      update();
      confettiController.play();
    }
  }

  void endGame({required String reason}) {
    endGameReason = reason;
    endTime = DateTime.now();
    update();
  }

  void resetGame() {
    Get.offAllNamed(RouteConstants.splashScreen);
  }
}
