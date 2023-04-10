import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String uid;
  final String email;
  final List<String> spaces;

  const User({required this.uid, required this.email, this.spaces = const []});

  factory User.fromJson(Map<String, dynamic> map) => _$UserFromJson(map);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.fromFireStore(DocumentSnapshot<Map<String, dynamic>> snapshot,
          SnapshotOptions? options) =>
      User.fromJson(snapshot.data()!);

  @override
  List<Object?> get props => [uid, email, spaces];
}
