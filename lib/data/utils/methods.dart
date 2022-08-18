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
    String twoDigitMinutes = _toTwoDigits(inMinutes.remainder(60));
    return "${_toTwoDigits(inHours)}:$twoDigitMinutes";
  }

  /// Converts the duration into a readable string
  /// 05:15:35
  String toHoursMinutesSeconds() {
    String twoDigitMinutes = _toTwoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = _toTwoDigits(inSeconds.remainder(60));
    return "${_toTwoDigits(inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  /// Converts the duration into a readable string
  /// 05:15:35:000
  String toHoursMinutesSecondsMilliseconds() {
    String twoDigitMinutes = _toTwoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = _toTwoDigits(inSeconds.remainder(60));
    String threeDigitMilliseconds =
        _toThreeDigits(inMilliseconds.remainder(1000));
    return "${_toTwoDigits(inHours)}:$twoDigitMinutes:$twoDigitSeconds"
        ":$threeDigitMilliseconds";
  }

  String _toTwoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String _toThreeDigits(int n) {
    if (n >= 100) return "$n";
    if (n >= 10) return "0$n";
    return "00$n";
  }
}
