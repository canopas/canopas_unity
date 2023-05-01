import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../model/user/user.dart';

@LazySingleton()
class AccountService {
  final FirebaseFirestore fireStore;
  final CollectionReference<User> accountsDb;

  AccountService(this.fireStore)
      : accountsDb = fireStore.collection('accounts').withConverter(
            fromFirestore: User.fromFireStore,
            toFirestore: (User user, _) => user.toJson());

  Future<List<User>> getAllAccounts() async {
    final data = await accountsDb.get();
    return data.docs.map((user) => user.data()).toList();
  }

}
