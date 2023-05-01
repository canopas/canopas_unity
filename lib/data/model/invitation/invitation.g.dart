// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invitation _$InvitationFromJson(Map<String, dynamic> json) => Invitation(
      id: json['id'] as String,
      spaceId: json['space_id'] as String,
      senderId: json['sender_id'] as String,
      receiverEmail: json['receiver_email'] as String,
    );

Map<String, dynamic> _$InvitationToJson(Invitation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'space_id': instance.spaceId,
      'sender_id': instance.senderId,
      'receiver_email': instance.receiverEmail,
    };
