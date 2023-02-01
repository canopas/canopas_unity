import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/services/user/user_leave_service.dart';
import 'package:projectunity/ui/user/leaves/bloc/leave_count/user_leave_count_bloc.dart';
import 'package:projectunity/ui/user/leaves/bloc/leaves/user_leave_bloc.dart';
import 'package:projectunity/ui/user/leaves/bloc/leaves/user_leave_event.dart';
import 'package:projectunity/ui/user/leaves/bloc/leaves/user_leave_state.dart';

import '../../../admin/leave_request_details/admin_leave_request_details_bloc_test.mocks.dart';

@GenerateMocks([UserLeaveService,UserManager])
void main(){
  late UserLeaveService _userLeaveService;
  late UserManager _userManager;
  late UserLeaveBloc userLeaveBloc;
 String employeeId= 'CA 1044';
 DateTime today= DateTime.now();

Leave upcomingLeave= Leave(
    leaveId: 'Leave Id',
    uid: "user id",
    leaveType: 1,
    startDate: today.add(const Duration(days: 1)).timeStampToInt,
    endDate: today.add(const Duration(days: 2)).timeStampToInt,
    totalLeaves: 2,
    reason: 'Suffering from viral fever',
    leaveStatus: approveLeaveStatus,
    appliedOn: today.timeStampToInt,
    perDayDuration: [1,1]);

  Leave pastLeave= Leave(
      leaveId: 'Leave-Id',
      uid: "user id",
      leaveType: 1,
      startDate: today.subtract(Duration(days: 2)).timeStampToInt,
      endDate: today.add(Duration(days: 1)).timeStampToInt,
      totalLeaves: 1,
      reason: 'Suffering from viral fever',
      leaveStatus: approveLeaveStatus,
      appliedOn: today.timeStampToInt,
      perDayDuration: [1]);
  setUp(() {
      _userLeaveService= MockUserLeaveService();
      _userManager= MockUserManager();
      userLeaveBloc= UserLeaveBloc(_userManager, _userLeaveService);
  });

    group('UserLeaveBloc stream test', () {
      test('Emits loading state as initial state of UserLeavesBloc', () {
        expect(userLeaveBloc.state, UserLeaveInitialState());
      });

      test('Emits loading state and success state after add UserLeaveEvent respectively', () {
        userLeaveBloc.add(FetchUserLeaveEvent());
        when(_userManager.employeeId).thenReturn(employeeId);
        when(_userLeaveService.getAllLeavesOfUser(employeeId)).thenAnswer((_) async=>[upcomingLeave,pastLeave] );
        expectLater(userLeaveBloc.stream, emitsInOrder([UserLeaveLoadingState(),
                                                        UserLeaveSuccessState(pastLeaves: [pastLeave], upcomingLeaves: [upcomingLeave])]));
      });
      test('Emits error state when Exception is thrown', () {
        userLeaveBloc.add(FetchUserLeaveEvent());

        when(_userManager.employeeId).thenReturn(employeeId);
        when(_userLeaveService.getAllLeavesOfUser(employeeId)).thenThrow(Exception('Couldn\'t load'));
        expectLater(userLeaveBloc.stream, emitsInOrder([UserLeaveLoadingState(),UserLeaveErrorState(error: firestoreFetchDataError)]));

      });
    }) ;

}