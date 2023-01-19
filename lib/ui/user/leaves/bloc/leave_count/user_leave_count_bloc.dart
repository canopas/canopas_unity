import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/exception/custom_exception.dart';
import 'package:projectunity/ui/user/leaves/bloc/leave_count/user_leave_count_state.dart';
import 'package:projectunity/ui/user/leaves/bloc/leave_count/user_leave_cout_event.dart';

import '../../../../../exception/error_const.dart';
import '../../../../../provider/user_data.dart';
import '../../../../../services/admin/paid_leave_service.dart';
import '../../../../../services/user/user_leave_service.dart';


@Injectable()
class UserLeaveCountBloc extends Bloc<UserLeaveCountEvent,UserLeaveCountState>{
  final UserLeaveService _userLeaveService;
  final UserManager _userManger;
  final PaidLeaveService _paidLeaveService;
  UserLeaveCountBloc(this._userLeaveService, this._userManger,this._paidLeaveService) : super(const UserLeaveCountState()){
    on<UserLeaveCountEvent>( _fetchLeaveCount);
  }

  Future<void> _fetchLeaveCount(UserLeaveCountEvent event, Emitter<UserLeaveCountState> emit)async {
    print('dfjk');
    emit(state.copyWith(status: UserLeaveCountStatus.loading));
    try{
      final double usedLeaves= await _userLeaveService.getUserUsedLeaveCount(_userManger.employeeId);
      final int totalLeaves= await _paidLeaveService.getPaidLeaves();
      final double remainingLeaves= totalLeaves-usedLeaves;
     // final percentage= remainingLeaves/totalLeaves;
      final percentage= 4.5/12;
      emit(state.copyWith(status: UserLeaveCountStatus.success,remaining: 4.5,totalLeaves: 12, leavePercentage: percentage));
    }on Exception {
      emit(state.copyWith(status: UserLeaveCountStatus.failure,error: firestoreFetchDataError));
    }
  }


}