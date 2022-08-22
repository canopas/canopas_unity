import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
@Singleton()
class AdminLeaveCount {
  final _totalLeavesCount = FirebaseFirestore.instance.collection('totalLeavesCount');

  AdminLeaveCount();

  final BehaviorSubject _totalLeaveCount = BehaviorSubject<int>.seeded(0);

  get totalLeaveCount => _totalLeaveCount;

  fetchTotalLeaveCounts() async {
    _totalLeaveCount.add(await _getUserAllLeaveCount());
  }

  Future<String> updateLeaveCount({required context,required String leaveCount}) async {
    String _docId = await _totalLeavesCount.get().then((val) {
      return val.docs[0].id;
    });
    String res =  await _totalLeavesCount
        .doc(_docId)
        .update({'leaveCount': leaveCount})
        .then((value) =>  '')
        .catchError((error) => AppLocalizations.of(context).admin_update_total_leave_count_error);
    _totalLeaveCount.add(await _getUserAllLeaveCount());
    return res;
  }

  Future<int> _getUserAllLeaveCount() async {
    return await _totalLeavesCount.get().then((val) {
      if (val.docs.isNotEmpty) return int.parse(val.docs[0].data()['leaveCount']);
      return 0;
    });
  }
}
