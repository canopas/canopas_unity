import 'package:flutter_test/flutter_test.dart';
import 'package:projectunity/data/model/leave/leave.dart';

void main() {
  group("Leaves", () {
    group('from json and from firestore', () {
      test('returns correct Leave object ', () {
        expect(
          Leave.fromJson(<String, dynamic>{
            'leave_id': 'unique-leave-doc-id',
            'uid': 'unique-user-id',
            'type': 1,
            'start_date': DateTime(2000).millisecondsSinceEpoch,
            'end_date': DateTime(2000).millisecondsSinceEpoch,
            'total': 5.5,
            'reason': 'not able to come',
            'status': 1,
            'rejection_reason': 'we have to finish project',
            'applied_on': DateTime(2000).millisecondsSinceEpoch,
            'per_day_duration': const [0, 1, 2, 3],
          }),
          isA<Leave>()
              .having(
                (leave) => leave.leaveId,
                'Unique leave id',
                'unique-leave-doc-id',
              )
              .having((leave) => leave.uid, 'Unique user id', 'unique-user-id')
              .having(
                (leave) => leave.type,
                'Type of leave e.g seek casual',
                LeaveType.urgentLeave,
              )
              .having(
                (leave) => leave.startDate,
                'Leave start date timestamp to int value',
                DateTime(2000),
              )
              .having(
                (leave) => leave.endDate,
                'Leave end date timestamp to int value',
                DateTime(2000),
              )
              .having((leave) => leave.total, 'total leaves- double', 5.5)
              .having(
                (leave) => leave.reason,
                'Reason of leave',
                'not able to come',
              )
              .having(
                (leave) => leave.status,
                'Status of leave: Pending-1, Approved-2, Rejected-3',
                LeaveStatus.pending,
              )
              .having(
                (leave) => leave.appliedOn,
                'Time of applicaton applied-TimeStamp to int',
                DateTime(2000),
              )
              .having(
                (leave) => leave.perDayDuration,
                'Duration of each leave day like 0-no leave, 1- first half',
                [
                  LeaveDayDuration.noLeave,
                  LeaveDayDuration.firstHalfLeave,
                  LeaveDayDuration.secondHalfLeave,
                  LeaveDayDuration.fullLeave,
                ],
              ),
        );
      });
    });
    test('apply correct leave to firestore', () {
      Leave leave = Leave(
        leaveId: 'unique-leave-doc-id',
        uid: 'unique-user-id',
        type: LeaveType.urgentLeave,
        startDate: DateTime(2000),
        endDate: DateTime(2000),
        total: 5,
        reason: 'suffering from viral fever',
        status: LeaveStatus.pending,
        appliedOn: DateTime(2000),
        perDayDuration: const [
          LeaveDayDuration.noLeave,
          LeaveDayDuration.firstHalfLeave,
          LeaveDayDuration.secondHalfLeave,
          LeaveDayDuration.fullLeave,
        ],
      );

      Map<String, dynamic> map = <String, dynamic>{
        'leave_id': leave.leaveId,
        'uid': leave.uid,
        'type': leave.type.value,
        'start_date': leave.startDate.millisecondsSinceEpoch,
        'end_date': leave.endDate.millisecondsSinceEpoch,
        'total': leave.total,
        'reason': leave.reason,
        'status': leave.status.value,
        'applied_on': leave.appliedOn.millisecondsSinceEpoch,
        'per_day_duration': [0, 1, 2, 3],
      };

      expect(leave.toFireStore(leave), map);
    });
  });
}
