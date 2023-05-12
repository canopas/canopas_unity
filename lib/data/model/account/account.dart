import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'account.g.dart';

@JsonSerializable(includeIfNull: false)
class Account extends Equatable {
  final String uid;
  final String email;
  final String? name;
  final List<String> spaces;

  const Account(
      {required this.uid,
      required this.email,
      this.name,
      this.spaces = const []});

  factory Account.fromJson(Map<String, dynamic> map) => _$AccountFromJson(map);

  Map<String, dynamic> toJson() => _$AccountToJson(this);

  factory Account.fromFireStore(DocumentSnapshot<Map<String, dynamic>> snapshot,
          SnapshotOptions? options) =>
      Account.fromJson(snapshot.data()!);

  @override
  List<Object?> get props => [uid, email, spaces,name];
}
