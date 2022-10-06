import 'package:injectable/injectable.dart';
import 'package:projectunity/base_bloc.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:rxdart/rxdart.dart';
import '../../../exception/error_const.dart';
import '../../../navigation/navigation_stack_manager.dart';
import '../../../services/leave/paid_leave_service.dart';

@Injectable()
class AdminPaidLeaveCountBloc extends BaseBLoc{
  final PaidLeaveService _paidLeaveService;
  final NavigationStackManager _stateManager;
  AdminPaidLeaveCountBloc(this._paidLeaveService, this._stateManager);

  final BehaviorSubject<ApiResponse<int>> _totalLeaveCount = BehaviorSubject<ApiResponse<int>>.seeded(const ApiResponse.idle());
  Stream<ApiResponse<int>> get totalLeaveCount => _totalLeaveCount.stream;

  final BehaviorSubject<bool> _isEnable = BehaviorSubject<bool>();
  Stream<bool> get isEnable => _isEnable.stream;


  Future<void> updateLeaveCount({required int leaveCount}) async {
    try{
      _totalLeaveCount.add(const ApiResponse.loading());
      await _paidLeaveService.updateLeaveCount(leaveCount);
      _stateManager.pop();
    } on Exception catch(_){
      _totalLeaveCount.add(const ApiResponse.error(error: firestoreFetchDataError));
    }
  }

  changeButtonState(String text){
    if(text.isEmpty){
      _isEnable.add(false);
    } else {
      _isEnable.add(true);
    }
  }

  Future<void> _getUserAllLeaveCount() async {
    _totalLeaveCount.add(const ApiResponse.loading());
    _totalLeaveCount.add(ApiResponse.completed(data: await _paidLeaveService.getPaidLeaves()));
  }

  @override
  void attach() async {
     await _getUserAllLeaveCount();
  }

  @override
  void detach() {
    _totalLeaveCount.close();
    _isEnable.close();
  }

}
