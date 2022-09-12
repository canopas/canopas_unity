import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import '../../../model/admin_leave_details/admin_remaining_leave_model.dart';
import '../../../services/leave/user_leave_service.dart';

@Singleton()
class AdminLeaveDetailsScreenBloc{
  final UserLeaveService _userLeaveService;
  AdminLeaveDetailsScreenBloc(this._userLeaveService);

  BehaviorSubject<RemainingLeave> _remainingLeave = BehaviorSubject<RemainingLeave>.seeded(RemainingLeave(remainingLeave: 0, remainingLeavePercentage: 0.0));

   Stream<RemainingLeave> get remainingLeaveStream => _remainingLeave.stream;

  fetchUserRemainingLeaveDetails({required String id}) async {

    int _userAllDays = 0;
    int _userUsedDays = 0;
    int _remainingLeaveRef = 0;

    _init();

    _userAllDays = await _userLeaveService.getUserAllLeaveCount();
    _userUsedDays = await _userLeaveService.getUserUsedLeaveCount(id);
    _remainingLeaveRef = _userAllDays - _userUsedDays;
    double _percentage = ( ( 100 / _userAllDays ) * _remainingLeaveRef ) / 100;
    if(_percentage > 1){
      _percentage = 1;
    } else if(_percentage < 0){
      _percentage = 0;
    }
    _remainingLeave.add(RemainingLeave(remainingLeave: _remainingLeaveRef, remainingLeavePercentage: _percentage ));
  }

  dispose(){
    _remainingLeave.close();
  }
  _init(){
    if(_remainingLeave.isClosed){
      _remainingLeave = BehaviorSubject<RemainingLeave>.seeded(RemainingLeave(remainingLeave: 0, remainingLeavePercentage: 0.0));
    }
  }

}