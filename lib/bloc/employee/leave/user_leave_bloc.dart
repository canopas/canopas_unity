import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:projectunity/base_bloc.dart';
import 'package:projectunity/core/utils/const/leave_screen_type_map.dart';
import 'package:projectunity/event_bus/events.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../provider/user_data.dart';
import '../../../../../services/leave/user_leave_service.dart';
import '../../../exception/error_const.dart';
import '../../../navigation/nav_stack_item.dart';
import '../../../navigation/navigation_stack_manager.dart';

@Injectable()
class UserLeavesBloc extends BaseBLoc{
  final UserManager _userManager;
  final UserLeaveService _userLeaveService;
  final NavigationStackManager _stateManager;

  UserLeavesBloc(this._userLeaveService, this._userManager, this._stateManager);

  var _leaveList = BehaviorSubject<ApiResponse<List<Leave>>>();

  BehaviorSubject<ApiResponse<List<Leave>>> get leaveList => _leaveList;

  List<Leave> _leaves = <Leave>[];

  void getUserLeaves({required int leaveScreenType}) async {
    if (_leaveList.isClosed) {
      _leaveList = BehaviorSubject<ApiResponse<List<Leave>>>();
    }
    _leaveList.add(const ApiResponse.loading());
    try {
      String employeeId = _userManager.employeeId;
      if (leaveScreenType == allLeaves) {
        _leaves = await _userLeaveService.getAllLeavesOfUser(employeeId);
      } else if (leaveScreenType == requestedLeave) {
        _leaves = await _userLeaveService.getRequestedLeave(employeeId);
      } else {
        _leaves = await _getUpcomingLeaves(employeeId);
      }
      _leaveList.add(ApiResponse.completed(data: _leaves));
    } on Exception {
      leaveList.add(const ApiResponse.error(error: firestoreFetchDataError));
    }
  }

  Future<List<Leave>> _getUpcomingLeaves(String employeeId) async {
    List<Leave> _allApprovedLeaves = await _userLeaveService.getUpcomingLeaves(employeeId);
    List<Leave> _upcomingLeave = <Leave>[];
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    for (var leave in _allApprovedLeaves) {
      if(leave.startDate >= currentTime){
        _upcomingLeave.add(leave);
      }
    }
    return _upcomingLeave;
  }
  late StreamSubscription leaveUpdateEventListener;
   _listenEmployeeRemoveEvent() {
     leaveUpdateEventListener = eventBus.on<LeaveUpdateEventListener>().listen((event) {
      if (_leaves.contains(event.leave)) {
        _leaves.remove(event.leave);
        _leaveList.add(ApiResponse.completed(data: _leaves));
      }
    });
  }

  void onApplyForLeaveButtonTap(){
    _stateManager.pop();
    _stateManager.push(const NavStackItem.leaveRequestState());
  }


  final BehaviorSubject<List<int>> _filterByLeaveType = BehaviorSubject<List<int>>.seeded([]);
  Stream<List<int>> get filterByLeaveType => _filterByLeaveType.stream;
   final List<int> _leaveTypes = [];

  final BehaviorSubject<List<int>> _filterByLeaveStatus = BehaviorSubject<List<int>>.seeded([]);
  Stream<List<int>> get filterByLeaveStatus => _filterByLeaveStatus.stream;
  final List<int> _leaveStatus = [];

  final BehaviorSubject<DateTime?> _filterByStartTime = BehaviorSubject<DateTime?>.seeded(null);
  Stream<DateTime?> get filterStartTime => _filterByStartTime.stream;

  final BehaviorSubject<DateTime?> _filterByEndTime = BehaviorSubject<DateTime?>.seeded(null);
  Stream<DateTime?> get filterEndTime => _filterByEndTime.stream;

  bool filterApplied = false;

  changeLeaveTypeFilter(int leaveType){
    if(_leaveTypes.contains(leaveType)){
      _leaveTypes.remove(leaveType);
    } else {
      _leaveTypes.add(leaveType);
    }
    _filterByLeaveType.add(_leaveTypes);
  }

  void changeLeaveStatusFilter(int leaveStatus){
    if(_leaveStatus.contains(leaveStatus)){
      _leaveStatus.remove(leaveStatus);
    } else {
      _leaveStatus.add(leaveStatus);
    }
    _filterByLeaveStatus.add(_leaveStatus);
  }

  void changeStartTimeFilter(DateTime? time){
      _filterByStartTime.add(time);
  }

  void changeEndTimeFilter(DateTime? time){
    _filterByEndTime.add(time);
  }

  void removeFilters(){
    _filterByEndTime.add(null);
    _filterByStartTime.add(null);
    _filterByLeaveType.add([]);
    _filterByLeaveStatus.add([]);
    filterApplied = false;
    _leaveList.add(ApiResponse.completed(data: _leaves));
  }

  bool _dateFilterValidation(Leave leave){
    if(_filterByStartTime.value == null && _filterByEndTime.value == null ){
        return true;
    } else if (_filterByStartTime.value == null) {
        return leave.startDate <= _filterByEndTime.value!.millisecondsSinceEpoch;
    } else if (_filterByEndTime.value == null){
        return leave.startDate >= _filterByStartTime.value!.millisecondsSinceEpoch;
    } else{
      return leave.startDate >= _filterByStartTime.value!.millisecondsSinceEpoch && leave.startDate <= _filterByEndTime.value!.millisecondsSinceEpoch;
    }
  }

  bool _leaveStatusFilterValidation(Leave leave){
    if(_filterByLeaveStatus.value.isEmpty){
      return true;
    } else {
      return _filterByLeaveStatus.value.contains(leave.leaveStatus);
    }
  }

  bool _leaveTypeFilterValidation(Leave leave){
    if(_filterByLeaveType.value.isEmpty){
      return true;
    } else {
      return _filterByLeaveType.value.contains(leave.leaveType);
    }
  }

  applyFilter(){
    if(_filterByLeaveType.value.isEmpty && _filterByLeaveStatus.value.isEmpty && _filterByStartTime.value == null && _filterByEndTime.value == null){
      filterApplied = false;
      _leaveList.add(ApiResponse.completed(data: _leaves));
    } else {
      List<Leave> filteredLeaves = _leaves.where((leave) => _dateFilterValidation(leave) && _leaveStatusFilterValidation(leave) && _leaveTypeFilterValidation(leave)).toList();
      filterApplied = true;
      _leaveList.add(ApiResponse.completed(data: filteredLeaves));
    }
  }

  @override
  void detach() {
    filterApplied = false;
    leaveUpdateEventListener.cancel();
    _leaveList.close();
    _leaves.clear();
    _filterByEndTime.close();
    _filterByStartTime.close();
    _filterByLeaveType.close();
    _filterByLeaveStatus.close();
  }

  @override
  void attach() {
    _listenEmployeeRemoveEvent();
  }
}