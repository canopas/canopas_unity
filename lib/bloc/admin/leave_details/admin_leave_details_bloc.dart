import 'package:injectable/injectable.dart';
import 'package:projectunity/base_bloc.dart';
import 'package:projectunity/services/leave/paid_leave_service.dart';
import 'package:rxdart/rxdart.dart';
import '../../../model/admin_leave_details/admin_remaining_leave_model.dart';
import '../../../services/leave/user_leave_service.dart';

@Injectable()
class AdminLeaveDetailsScreenBloc extends BaseBLoc {
  final UserLeaveService _userLeaveService;
  final PaidLeaveService _paidLeaveService;

  AdminLeaveDetailsScreenBloc(this._userLeaveService, this._paidLeaveService);

  final BehaviorSubject<RemainingLeave> _remainingLeave =
      BehaviorSubject<RemainingLeave>.seeded(
          RemainingLeave(remainingLeave: 0, remainingLeavePercentage: 0.0));

  Stream<RemainingLeave> get remainingLeaveStream => _remainingLeave.stream;

  fetchUserRemainingLeaveDetails({required String id}) async {
    int _paidLeaves = 0;
    int _userUsedDays = 0;
    int _remainingLeaveRef = 0;

    _paidLeaves = await _paidLeaveService.getPaidLeaves();
    _userUsedDays = await _userLeaveService.getUserUsedLeaveCount(id);
    _remainingLeaveRef = _paidLeaves - _userUsedDays;
    if (_remainingLeaveRef < 0) {
      _remainingLeaveRef = 0;
    }
    double _percentage = (100 - (100 / _paidLeaves) * _remainingLeaveRef) / 100;
    if (_percentage > 1) {
      _percentage = 1;
    } else if (_percentage < 0) {
      _percentage = 0;
    }
    _remainingLeave.add(RemainingLeave(
        remainingLeave: _remainingLeaveRef,
        remainingLeavePercentage: _percentage));
  }

  @override
  void detach() {
    _remainingLeave.close();
  }

  @override
  void attach() {}
}
