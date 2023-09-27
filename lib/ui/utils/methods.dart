import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/services.dart';

String getExceptionMessage(
  String id, {
  String? message,
  dynamic error,
  StackTrace? stackTrace,
}) {
  String finalMessage = message ?? 'Something went wrong!';

  if (error != null) {
    ///LOG THE ERROR
    developer.log(
      'ERROR[$id][${error?.runtimeType}]',
      error: error,
      stackTrace: stackTrace,
    );
    if (error is PlatformException) {
      if (error.message != null) {
        finalMessage = error.message!;
      }
    } else if (error is firebase_auth.FirebaseAuthException) {
      if (error.code != 'unknown' && error.message != null) {
        finalMessage = error.message!;
      }
    } else if (error is firebase_auth.FirebaseException) {
      if (error.code != 'unknown' && error.message != null) {
        finalMessage = error.message!;
      }
    }
  }

  return finalMessage;
}

extension DurationExtensions on Duration {
  /// Converts the duration into a readable string
  /// 05:15
  String toHoursMinutes() {
    String twoDigitMinutes = inMinutes.remainder(60).toTwoDigits();
    return "${inHours.toTwoDigits()}:$twoDigitMinutes";
  }

  /// Converts the duration into a readable string
  /// 05:15:35
  String toHoursMinutesSeconds() {
    String twoDigitMinutes = inMinutes.remainder(60).toTwoDigits();
    String twoDigitSeconds = inSeconds.remainder(60).toTwoDigits();
    return "${inHours.toTwoDigits()}:$twoDigitMinutes:$twoDigitSeconds";
  }

  /// Converts the duration into a readable string
  /// 05:15:35:000
  String toHoursMinutesSecondsMilliseconds() {
    String twoDigitMinutes = inMinutes.remainder(60).toTwoDigits();
    String twoDigitSeconds = inSeconds.remainder(60).toTwoDigits();
    String threeDigitMilliseconds =
        inMilliseconds.remainder(1000).toThreeDigits();
    return "${inHours.toTwoDigits()}:$twoDigitMinutes:$twoDigitSeconds"
        ":$threeDigitMilliseconds";
  }
}

// An extension on int that returns a string in the format of 00
extension IntExtensions on int {
  String toTwoDigits() {
    if (this >= 10) return "$this";
    return "0$this";
  }

  String toThreeDigits() {
    if (this >= 100) return "$this";
    if (this >= 10) return "0$this";
    return "00$this";
  }
}
