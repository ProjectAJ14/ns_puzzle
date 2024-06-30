import 'package:ns_utils/extensions/map.dart';

import '../../ui/utils/constant.dart';

class User {
  final String userId;
  final String displayName;
  final String email;
  final int score;

  User({
    required this.userId,
    required this.displayName,
    required this.email,
    this.score = 0,
  });

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      userId: json.getString(Constants.userId),
      displayName: json.getString(Constants.displayName),
      email: json.getString(Constants.email),
      score: json.getInt(Constants.score),
    );
  }
}
