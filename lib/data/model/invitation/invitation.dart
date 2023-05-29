import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invitation.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Invitation {
  final String id;
  final String spaceId;
  final String senderId;
  final String receiverEmail;

  const Invitation(
      {required this.id,
      required this.spaceId,
      required this.senderId,
      required this.receiverEmail});

  factory Invitation.fromJson(Map<String, dynamic> json) =>
      _$InvitationFromJson(json);

  Map<String, dynamic> toJson() => _$InvitationToJson(this);

  factory Invitation.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    Map<String, dynamic>? data = snapshot.data();
    return Invitation.fromJson(data!);
  }
}
