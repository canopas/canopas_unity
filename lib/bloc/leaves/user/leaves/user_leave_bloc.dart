import 'package:injectable/injectable.dart';
import 'package:projectunity/core/utils/const/leave_screen_type_map.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../provider/user_data.dart';
import '../../../../services/leave/user_leave_service.dart';

@Singleton()
class UserLeavesBloc{
  final UserManager _userManager;
  final UserLeaveService _userLeaveService;
  UserLeavesBloc(this._userLeaveService, this._userManager);

  var  _allLeaves = BehaviorSubject<ApiResponse<List<Leave>>>();
  var _requestedLeaves = BehaviorSubject<ApiResponse<List<Leave>>>();
  var _upcomingLeave = BehaviorSubject<ApiResponse<List<Leave>>>();

  BehaviorSubject<ApiResponse<List<Leave>>> get allLeaves => _allLeaves;
  BehaviorSubject<ApiResponse<List<Leave>>> get requestedLeaves => _requestedLeaves;
  BehaviorSubject<ApiResponse<List<Leave>>> get upcomingLeaves => _upcomingLeave;

  void _getAllLeaves() async {
    if(_allLeaves.isClosed){
      _initAllLeaves();
    }
    String? id = _userManager.employeeId;
    _allLeaves.add(const ApiResponse.loading());
    try {
      final List<Leave> leaves =
          await _userLeaveService.getAllLeavesOfUser(id);
      _allLeaves.add(ApiResponse.completed(data: leaves));
    } on Exception catch (error) {
      _allLeaves.add(ApiResponse.error(message: error.toString()));
    }
  }

  void _getRequestedLeaves() async {
    if(_requestedLeaves.isClosed){
      _initRequestedLeaves();
    }
    String id = _userManager.employeeId;
    _requestedLeaves.add(const ApiResponse.loading());
    try {
      List<Leave>? list = await _userLeaveService.getRequestedLeave(id);
      _requestedLeaves.add(ApiResponse.completed(data: list));
    } on Exception catch (error) {
      _requestedLeaves.add(ApiResponse.error(message: error.toString()));
    }
  }

  void _getUpcomingLeaves() async {
    if(_upcomingLeave.isClosed){
        _initUpcomingLeaves();
    }
    String employeeId = _userManager.employeeId;
    _upcomingLeave.add(const ApiResponse.loading());
    try {
      final List<Leave> list =
      await _userLeaveService.getUpcomingLeaves(employeeId);
      _upcomingLeave.add(ApiResponse.completed(data: list));
    } on Exception catch (error) {
      _upcomingLeave.add(ApiResponse.error(message: error.toString()));
    }
  }



  void _initRequestedLeaves(){
     _requestedLeaves = BehaviorSubject<ApiResponse<List<Leave>>>();
  }
  void _initUpcomingLeaves(){
    _upcomingLeave = BehaviorSubject<ApiResponse<List<Leave>>>();
  }
  void _initAllLeaves(){
    _allLeaves = BehaviorSubject<ApiResponse<List<Leave>>>();
  }

  void getLeaves({required int leaveScreenType}){
    if(leaveScreenType == LeaveScreenType.requestedLeave) {
      _getRequestedLeaves();
    } else if(leaveScreenType == LeaveScreenType.upcomingLeave){
      _getUpcomingLeaves();
    } else{
      _getAllLeaves();
    }
  }

  getStream({required int leaveScreenType}){
    if(leaveScreenType == LeaveScreenType.requestedLeave) {
      return _requestedLeaves.stream;
    } else if(leaveScreenType == LeaveScreenType.upcomingLeave){
      return _upcomingLeave.stream;
    } else{
      return _allLeaves.stream;
    }
  }

  void dispose(){
    if(!_allLeaves.isClosed){
      _allLeaves.close();
    }
    if(!_requestedLeaves.isClosed){
      _requestedLeaves.close();
    }
    if(!_upcomingLeave.isClosed){
      _upcomingLeave.close();
    }
  }
}
