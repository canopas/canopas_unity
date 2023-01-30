import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/exception/custom_exception.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/ui/user/leaves/bloc/leaves/user_leave_event.dart';
import 'package:projectunity/ui/user/leaves/bloc/leaves/user_leave_state.dart';

import '../../../../../model/leave/leave.dart';
import '../../../../../provider/user_data.dart';
import '../../../../../services/user/user_leave_service.dart';


@Injectable()
class UserLeaveBloc extends Bloc<UserLeaveEvent,UserLeaveState>{
  final UserLeaveService _userLeaveService;
  final UserManager _userManager;
  UserLeaveBloc(this._userManager,this._userLeaveService) : super(UserLeaveInitialState()){
    on<UserLeaveEvent>(_fetchLeaves);
  }

  Future<void> _fetchLeaves(UserLeaveEvent event,Emitter<UserLeaveState> emit)async{
    emit(UserLeaveLoadingState());
    try{
      List<Leave> allLeaves= await _userLeaveService.getAllLeavesOfUser(_userManager.employeeId);
      List<Leave> pastLeaves= allLeaves.where((leave) => leave.startDate<=DateTime.now().timeStampToInt).toList();
      List<Leave> upcomingLeaves= allLeaves.where((leave) => leave.startDate>=DateTime.now().timeStampToInt).toList();
    print(allLeaves.length);
      emit(UserLeaveSuccessState(pastLeaves:pastLeaves, upcomingLeaves:upcomingLeaves));
    }on Exception {
      emit(UserLeaveErrorState(error: firestoreFetchDataError));
    }
  }

}