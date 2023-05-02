import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/utils/const/firestore.dart';
import 'package:projectunity/data/model/invitation/invitation.dart';

@LazySingleton()
class InvitationService {
  final FirebaseFirestore fireStore;
  late final CollectionReference<Invitation> _invitationDb;

  InvitationService(this.fireStore)
      : _invitationDb = fireStore
            .collection(FireStoreConst.invitationsCollection)
            .withConverter(
                fromFirestore: Invitation.fromFirestore,
                toFirestore: (Invitation invitation, _) => invitation.toJson());

  Future<List<Invitation>> fetchSpacesForUserEmail(String email) async {
    final data = await _invitationDb
        .where(FireStoreConst.receiverEmail, isEqualTo: email)
        .get();
    return data.docs.map((invitation) => invitation.data()).toList();
  }

  Future<void> addInvitation(
      {required String senderId,
      required String spaceId,
      required String receiverEmail}) async {
    final id = _invitationDb.doc().id;
    final Invitation invitation = Invitation(
        id: id,
        spaceId: spaceId,
        senderId: senderId,
        receiverEmail: receiverEmail);
    await _invitationDb.doc(id).set(invitation);
  }

  Future<void> deleteInvitation({required String id}) async {
    await _invitationDb.doc(id).delete();
  }
}
