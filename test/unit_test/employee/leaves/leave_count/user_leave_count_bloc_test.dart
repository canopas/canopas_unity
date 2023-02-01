
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/services/admin/paid_leave_service.dart';
import 'package:projectunity/services/user/user_leave_service.dart';
import 'package:projectunity/ui/user/leaves/bloc/leave_count/user_leave_count_bloc.dart';
import 'package:projectunity/ui/user/leaves/bloc/leave_count/user_leave_count_state.dart';
import 'package:projectunity/ui/user/leaves/bloc/leave_count/user_leave_cout_event.dart';
import 'user_leave_count_bloc_test.mocks.dart';
@GenerateMocks([UserLeaveService, UserManager, PaidLeaveService])
void main(){
  late UserLeaveService _userLeaveService;
  late UserManager _userManager;
  late PaidLeaveService _paidLeaveService;
  late UserLeaveCountBloc userLeaveCountBloc;
  UserLeaveCountState loadingState= const UserLeaveCountState(
      status: UserLeaveCountStatus.loading,
      used: 0,
      totalLeaves: 12,
      leavePercentage: 1,
      error: null);

  final String employeeId= 'Employee Id';


  setUp(() {
    _userLeaveService= MockUserLeaveService();
    _userManager= MockUserManager();
    _paidLeaveService= MockPaidLeaveService();
    userLeaveCountBloc= UserLeaveCountBloc(_userLeaveService, _userManager, _paidLeaveService);

  });

  group('User Leave count State', () {
    test('Emits initial  state when screen is open and fetching data from service', () {
      UserLeaveCountState initialState= const UserLeaveCountState(status: UserLeaveCountStatus.initial,used: 0,totalLeaves: 12,leavePercentage: 1,error: null);
     expect(userLeaveCountBloc.state, initialState);
    });
    test('emits loading state and success state after add FetchUserLeaveCountEvent respectively', () {
      userLeaveCountBloc.add(FetchLeaveCountEvent());

      when(_userManager.employeeId).thenReturn(employeeId);
      when(_userLeaveService.getUserUsedLeaveCount(employeeId)).thenAnswer((_) async=> 7);
      when(_paidLeaveService.getPaidLeaves()).thenAnswer((_) async=> 12);
      var percentage= 7/12;

      UserLeaveCountState successState = UserLeaveCountState(status: UserLeaveCountStatus.success,used: 7,totalLeaves: 12,leavePercentage: percentage,error: null);
      expectLater(userLeaveCountBloc.stream, emitsInOrder([loadingState,successState]));

    });

    test('emits error state when Exception is thrown', () {
      userLeaveCountBloc.add(FetchLeaveCountEvent());

      when(_userManager.employeeId).thenReturn('Ca 1044');
      when(_userLeaveService.getUserUsedLeaveCount('Ca 1044')).thenAnswer((_) async=> 7);
      when(_paidLeaveService.getPaidLeaves()).thenThrow(Exception('Couldn\'t load'));
      UserLeaveCountState errorState= const UserLeaveCountState(status: UserLeaveCountStatus.failure,used: 0,totalLeaves: 12,leavePercentage: 1,error: 'Couldn\'t load');
      expectLater(userLeaveCountBloc.stream, emitsInOrder([loadingState,errorState]));

    });
  });


}