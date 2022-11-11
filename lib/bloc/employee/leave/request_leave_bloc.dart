import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:projectunity/base_bloc.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/core/utils/const/leave_time_constants.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/model/leave_count.dart';
import 'package:projectunity/navigation/nav_stack/nav_stack_item.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/services/admin/paid_leave/paid_leave_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';
import '../../../navigation/navigation_stack_manager.dart';
import '../../../services/leave/user_leave_service.dart';

@Injectable()
class RequestLeaveBloc extends BaseBLoc {


  //dependency
  final UserManager _userManager;
  final UserLeaveService _userLeaveService;
  final PaidLeaveService _userPaidLeaveService;
  final NavigationStackManager _navigationStackManager;

  RequestLeaveBloc(this._userManager, this._userLeaveService, this._navigationStackManager, this._userPaidLeaveService);


  //private variable
  final BehaviorSubject<int> _leaveType = BehaviorSubject<int>.seeded(0);
  final BehaviorSubject<DateTime> _startDate = BehaviorSubject<DateTime>.seeded(DateTime.now().dateOnly);
  final BehaviorSubject<DateTime> _endDate = BehaviorSubject<DateTime>.seeded(DateTime.now().dateOnly);
  final BehaviorSubject<String> _reason = BehaviorSubject<String>();
  final BehaviorSubject<Map<DateTime,int>> _selectedDates = BehaviorSubject<Map<DateTime,int>>();
  final BehaviorSubject<ApiResponse<bool>> _validLeave = BehaviorSubject<ApiResponse<bool>>();
  final BehaviorSubject<double> _totalLeaves = BehaviorSubject<double>();
  final Map<DateTime,int> _leaveOfDay = {};
  final BehaviorSubject<ApiResponse<LeaveCounts>> _leaveCount = BehaviorSubject<ApiResponse<LeaveCounts>>();



  //getters
  Stream<int> get leaveType => _leaveType.stream;
  Stream<DateTime> get startDate => _startDate.stream;
  Stream<DateTime> get endDate => _endDate.stream;
  Stream<double> get totalLeave => _totalLeaves.stream;
  Stream<Map<DateTime,int>> get selectedDates => _selectedDates.stream;
  Stream<String> get reason => _reason.stream.transform(_validateReason);
  BehaviorSubject<ApiResponse<bool>> get validLeave => _validLeave;
  Stream<ApiResponse<LeaveCounts>> get leaveCount => _leaveCount.stream;


  //setters
  void Function(String reason) get updateReason => _reason.sink.add;
  void Function(int leaveType) get updateLeaveType => _leaveType.sink.add;

  void updateStartLeaveDate(DateTime? date) {
    _startDate.sink.add(date?.dateOnly ?? _startDate.value);
  }

  void updateEndLeaveDate(DateTime? date) {
    _endDate.sink.add(date?.dateOnly ?? _endDate.value);
  }

  void updateLeaveOfDay(DateTime date,int newValue){
    _leaveOfDay.update(date, (value) => newValue, ifAbsent: () => date.isWeekend?noLeave:fullLeave,);
    _selectedDates.add(_leaveOfDay);
    _updateTotalLeaveCount(selectedDates: _leaveOfDay);
  }

  void _updateTotalLeaveCount({required Map<DateTime,int> selectedDates}){
    double totalLeaves = 0.0;
    for (int value in selectedDates.values) {
      if(value == fullLeave){
        totalLeaves += 1;
      } else if(value == firstHalfLeave || value == secondHalfLeave){
        totalLeaves += 0.5;
      }
    }
    _totalLeaves.add(totalLeaves);
  }

  void _updateRemainingLeaveCount() async {
    _leaveCount.add(const ApiResponse.loading());
    double usedLeaveCount = await _userLeaveService.getUserUsedLeaveCount(_userManager.employeeId);
    int paidLeaveCount = await _userPaidLeaveService.getPaidLeaves();
    double remainingLeaveCount = paidLeaveCount - usedLeaveCount;
    LeaveCounts leaveCounts = LeaveCounts(remainingLeaveCount: remainingLeaveCount<0?0:remainingLeaveCount,paidLeaveCount: paidLeaveCount,usedLeaveCount: usedLeaveCount);
    _leaveCount.add(ApiResponse.completed(data: leaveCounts));
  }


  //validations
  final _validateReason = StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.isNotEmpty) {
      value.length > 3 ? sink.add(value) : sink.addError(enterValidReason);
    } else {
      sink.add(value);
    }
  });

  bool _validLeaveTime(DateTime startDate, DateTime endDate) {
    int durationHour = endDate.difference(startDate).inDays;
    if (durationHour.isNegative) {
      _validLeave.add(const ApiResponse.error(error: invalidLeaveDateError));
      return false;
    }
     DateTime lastDate = _leaveOfDay.entries.where((day) => day.value != noLeave).last.key;
     DateTime firstDate = _leaveOfDay.entries.where((day) => day.value != noLeave).first.key;
    _endDate.add(lastDate);
    _startDate.add(firstDate);
    return true;
  }
  

  void validation() async {
    if (!_reason.stream.hasValue || _reason.stream.value.length < 4) {
      _validLeave.add(const ApiResponse.error(error: fillDetailsError));
    } else if(_totalLeaves.value == 0){
      _validLeave.add(const ApiResponse.error(error: applyMinimumHalfDay));
    } else {
      try {
        bool validTime = _validLeaveTime(_startDate.value, _endDate.value);
        if (validTime) {
          _validLeave.add(const ApiResponse.loading());
          await _applyForLeave();
          _validLeave.add(ApiResponse.completed(data: validTime));
          _navigationStackManager.pop();
          _navigationStackManager.push(const NavStackItem.userAllLeaveState());
        }
      } on Exception catch (error) {
        _validLeave.add(ApiResponse.error(error: error.toString()));
      }
    }
  }

  //functionality
  _listenStream(){
     Rx.combineLatest2(_startDate,_endDate, (DateTime startDate, DateTime endDate) {
      List<DateTime> dates = [];
      if(startDate.isAfter(endDate) || startDate.isAtSameMomentAs(endDate)){
        dates = [startDate];
      }else {
        dates = List.generate(endDate.difference(startDate).inDays, (days) => startDate.add(Duration(days: days)))..add(endDate);
      }
      for (var date in dates) {
        _leaveOfDay.putIfAbsent(date.dateOnly, () => date.isWeekend?noLeave:fullLeave);
      }
      _leaveOfDay.removeWhere((key, value) => !dates.contains(key));
      return _leaveOfDay;
    } ).listen((event) {
      _selectedDates.add(event);
      _updateTotalLeaveCount(selectedDates: event);
     });
  }

  Leave _getLeaveData() {
    return Leave(
        leaveId: const Uuid().v4(),
        uid: _userManager.employeeId,
        leaveType: _leaveType.stream.value,
        startDate: _startDate.value.timeStampToInt,
        endDate: _endDate.value.timeStampToInt,
        totalLeaves: _totalLeaves.value,
        reason: _reason.stream.value,
        leaveStatus: pendingLeaveStatus,
        appliedOn: DateTime.now().timeStampToInt,
        perDayDuration: _selectedDates.value.values.toList(),
    );
  }

  Future<void> _applyForLeave() async {
    Leave leaveData = _getLeaveData();
    await _userLeaveService.applyForLeave(leaveData);
  }

  @override
  void detach() {
    _leaveCount.close();
    _leaveType.close();
    _startDate.close();
    _endDate.close();
    _totalLeaves.close();
    _selectedDates.close();
    _reason.close();
    _validLeave.close();
    _leaveOfDay.clear();
  }


  @override
  void attach() {
    _listenStream();
    _updateRemainingLeaveCount();
  }
}
