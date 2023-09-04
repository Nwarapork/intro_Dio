import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';
@JsonSerializable()
class UserModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  UserModel(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body,
      });
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
    /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}