import 'package:flutter_test/flutter_test.dart';
import 'package:projectunity/model/leave/leave.dart';

void main() {
  group("Leaves", () {
    group('from json and from firestore', () {
      test('returns correct Leave object ', () {
        expect(
            Leave.fromJson(const <String, dynamic>{
              'leave_id': 'unique-leave-doc-id',
              'uid': 'unique-user-id',
              'leave_type': 1,
              'start_date': 46546325,
              'end_date': 46431454,
              'total_leaves': 5.5,
              'reason': 'not able to come',
              'leave_status': 1,
              'rejection_reason': 'we have to finish project',
              'applied_on': 12346432,
              'per_day_duration': [0, 1, 1, 2, 0],
            }),
            isA<Leave>()
                .having((leave) => leave.leaveId, 'Unique leave id', 'unique-leave-doc-id')
                .having((leave) => leave.uid, 'Unique user id', 'unique-user-id')
                .having((leave) => leave.leaveType, 'Type of leave e.g seek casual', 1)
                .having((leave) => leave.startDate, 'Leave start date timestamp to int value', 46546325)
                .having((leave) => leave.endDate, 'Leave end date timestamp to int value', 46431454)
                .having((leave) => leave.totalLeaves, 'total leaves- double', 5.5)
                .having((leave) => leave.reason, 'Reason of leave', 'not able to come')
                .having((leave) => leave.leaveStatus, 'Status of leave: Pending-1, Approved-2, Rejected-3', 1)
                .having((leave) => leave.appliedOn, 'Time of applicaton applied-TimeStamp to int', 12346432)
                .having((leave) => leave.perDayDuration, 'Duration of each leave day like 0-no leave, 1- first half',[0, 1, 1, 2, 0] )
        );
      });
    });
    test('apply correct leave to firestore', () {
    Leave leave= Leave(
        leaveId: 'unique-leave-doc-id',
        uid: 'unique-user-id',
        leaveType: 1,
        startDate: 45894351,
        endDate: 456314564,
        totalLeaves: 5,
        reason: 'suffering from viral fever',
        leaveStatus: 5,
        appliedOn: 45643132,
        perDayDuration: [1,2,2]);


    Map<String,dynamic> map=<String, dynamic>{
      'leave_id': leave.leaveId,
      'uid': leave.uid,
      'leave_type': leave.leaveType,
      'start_date': leave.startDate,
      'end_date': leave.endDate,
      'total_leaves': leave.totalLeaves,
      'reason': leave.reason,
      'leave_status': leave.leaveStatus,
      'rejection_reason': leave.rejectionReason,
      'applied_on': leave.appliedOn,
      'per_day_duration': leave.perDayDuration,
    };

    expect(leave.toFireStore(leave),map);
    });
  });
}
