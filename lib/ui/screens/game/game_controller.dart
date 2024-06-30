import 'dart:async';
import 'dart:developer' as developer;

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/repo/repos.dart';
import '../../../app/services/services.dart';
import '../../../data/models/subjects.dart';
import '../../../data/models/user.dart';
import '../../utils/methods.dart';
import '../../routes/route_constants.dart';

const int totalScore = 100;

class GameController extends GetxController {
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

  //TODO: Optimize this stream
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
    Lady(),
    Lady(),
    Lady(),
  ];

  List<Subject> onBoat = [];

  void moveBoat({required Function(String) onError}) {
    if (onBoat.isEmpty) {
      onError('No one is on the boat');
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

  void onSubjectTap(
    Subject subject, {
    required Function(String) onError,
  }) {
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
        onError('Boat is full!');
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
        onError('Invalid move!');
      }
    }
    update();
    checkWin();
  }

  String getScore() {
    int score = _calculateScore();
    return score.toTwoDigits();
  }

  void leaderBoardClick() {
    Get.toNamed(RouteConstants.leaderboard);
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
    // Check if devils are more than ladies on right side including the boat
    List<Subject> rightList = [...rightSide];
    if (isBoatOnRightSide) {
      rightList.addAll(onBoat);
    }
    int totalDevils = rightList.whereType<Devil>().length;
    int totalLadies = rightList.whereType<Lady>().length;
    if (totalDevils > totalLadies && totalLadies > 0) {
      //Mark all ladies as dead
      for (var element in rightList) {
        if (element is Lady) {
          element.markDead();
        } else if (element is Devil) {
          element.animate = true;
        }
      }
      endGame(reason: 'Devils killed the ladies on the right side');
      return;
    }
    // Check if devils are more than ladies on left side including the boat
    List<Subject> leftList = [...leftSide];
    if (isBoatOnLeftSide) {
      leftList.addAll(onBoat);
    }
    totalDevils = leftList.whereType<Devil>().length;
    totalLadies = leftList.whereType<Lady>().length;
    if (totalDevils > totalLadies && totalLadies > 0) {
      //Mark all ladies as dead
      for (var element in rightList) {
        if (element is Lady) {
          element.markDead();
        } else if (element is Devil) {
          element.animate = true;
        }
      }

      endGame(reason: 'Devils killed the ladies on the left side');
      return;
    }
  }

  void checkWin() {
    // Check if all devils and all ladies are on the left side
    int totalDevils = leftSide.whereType<Devil>().length;
    int totalLadies = leftSide.whereType<Lady>().length;
    if (totalDevils + totalLadies == 6) {
      endTime = DateTime.now();
      update();
      confettiController.play();
      fireStoreRepo.addUser(
        user: User(
          userId: authService.userId,
          displayName: authService.userName,
          score: _calculateScore(),
          email: authService.userEmail,
          image: authService.photoURL,
        ),
      );
    }
  }

  void endGame({required String reason}) {
    fireStoreRepo.addUser(
      user: User(
        userId: authService.userId,
        displayName: authService.userName,
        score: 0,
        email: authService.userEmail,
        image: authService.photoURL,
      ),
    );
    endGameReason = reason;
    endTime = DateTime.now();
    update();
  }

  void resetGame() {
    leftSide = [];
    rightSide = [
      Devil(),
      Devil(),
      Devil(),
      Lady(),
      Lady(),
      Lady(),
    ];
    onBoat = [];
    startTime = null;
    endTime = null;
    alignment = Alignment.bottomRight;
    endGameReason = '';
    confettiController.stop();
    update();
  }
}
