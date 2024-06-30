import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(defaultValue: '')
  final String userId;

  @JsonKey(defaultValue: '', name: 'display_name')
  final String displayName;

  @JsonKey(defaultValue: '')
  final String email;

  @JsonKey(defaultValue: '')
  final String image;

  @JsonKey(defaultValue: 0)
  final int score;

  User({
    required this.userId,
    required this.displayName,
    required this.email,
    this.image = '',
    this.score = 0,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
