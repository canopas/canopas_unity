import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/base_bloc.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/navigation/nav_stack_item.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import '../../../navigation/navigation_stack_manager.dart';
import '../../../services/leave/user_leave_service.dart';

@Injectable()
class ApplyLeaveBloc extends BaseBLoc {
  final UserManager _userManager;
  final UserLeaveService _userLeaveService;
  final NavigationStackManager _navigationStackManager;

  ApplyLeaveBloc(
      this._userManager, this._userLeaveService, this._navigationStackManager);

  DateTime _startTimeStamp = DateTime.now();
  DateTime _endTimeStamp = DateTime.now();
  double totalLeaves = 0;

  final BehaviorSubject<String> _reason = BehaviorSubject<String>();

  Sink<String> get sinkReason => _reason.sink;

  Stream<String> get reason => _reason.stream.transform(_validateReason);

  final BehaviorSubject<DateTime> _startDate =
      BehaviorSubject<DateTime>.seeded(DateTime.now());

  Stream<DateTime> get startDate => _startDate.stream;

  final BehaviorSubject<DateTime> _endDate =
      BehaviorSubject<DateTime>.seeded(DateTime.now());

  Stream<DateTime> get endDate => _endDate.stream;

  final BehaviorSubject<TimeOfDay> _startLeaveTime =
      BehaviorSubject<TimeOfDay>.seeded(TimeOfDay.now());

  Stream<TimeOfDay> get startLeaveTime => _startLeaveTime.stream;

  final BehaviorSubject<TimeOfDay> _endLeaveTime =
      BehaviorSubject<TimeOfDay>.seeded(TimeOfDay.now());

  Stream<TimeOfDay> get endLeaveTime => _endLeaveTime.stream;

  Stream<int> get leaveType => _leaveType.stream;
  final BehaviorSubject<int> _leaveType = BehaviorSubject<int>.seeded(0);

  final BehaviorSubject<ApiResponse<bool>> _validLeave =
      BehaviorSubject<ApiResponse<bool>>();

  BehaviorSubject<ApiResponse<bool>> get validLeave => _validLeave;

  void updateLeaveTpe(int leaveType) {
    _leaveType.sink.add(leaveType);
  }

  void updateStartLeaveDate(DateTime? date) {
    _startDate.sink.add(date ?? _startDate.value);
  }

  void updateEndLeaveDate(DateTime? date) {
    _endDate.sink.add(date ?? _endDate.value);
  }

  void updateStartTime(TimeOfDay? time) {
    _startLeaveTime.sink.add(time ?? _startLeaveTime.value);
  }

  void updateEndTime(TimeOfDay? time) {
    _endLeaveTime.sink.add(time ?? _endLeaveTime.value);
  }

  final _validateReason =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.isNotEmpty) {
      value.length > 3 ? sink.add(value) : sink.addError(enterValidReason);
    }
  });

  DateTime _mergeDateTime(BehaviorSubject<DateTime> leaveDay,
      BehaviorSubject<TimeOfDay> leaveTime) {
    DateTime date = leaveDay.stream.value;
    TimeOfDay time = leaveTime.stream.value;
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  bool _validLeaveTime(DateTime startDate, DateTime endDate) {
    int durationHour = endDate.difference(startDate).inHours;
    if (durationHour.isNegative) {
      _validLeave.add(const ApiResponse.error(error: invalidLeaveDateError));
      return false;
    } else if (durationHour < 1) {
      _validLeave.add(const ApiResponse.error(error: applyMinimumOneHourError));
      return false;
    }
    totalLeaves = convertDuration(durationHour);
    return true;
  }

  double convertDuration(int durationHour) {
    double totalLeaveDays = durationHour / 24;
    int leaveDays = totalLeaveDays.toInt();
    double diff = totalLeaveDays - leaveDays;
    if (diff != 0.0) {
      int leaveHours = (diff * 24).toInt();
      if (leaveHours < 4) {
        return leaveDays + 0.5;
      }
      return leaveDays + 1;
    }
    return leaveDays.toDouble();
  }

  void validation() async {
    print('validation boc called');
    _startTimeStamp = _mergeDateTime(_startDate, _startLeaveTime);
    _endTimeStamp = _mergeDateTime(_endDate, _endLeaveTime);
    if (!_reason.stream.hasValue || _reason.stream.value.length < 4) {
      _validLeave.add(const ApiResponse.error(error: fillDetailsError));
    } else {
      try {
        bool validTime = _validLeaveTime(_startTimeStamp, _endTimeStamp);
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

  Leave _getLeaveData() {
    Leave leave = Leave(
        leaveId: const Uuid().v4(),
        uid: _userManager.employeeId,
        leaveType: _leaveType.stream.value,
        startDate: _startTimeStamp.timeStampToInt,
        endDate: _endTimeStamp.timeStampToInt,
        totalLeaves: totalLeaves,
        reason: _reason.stream.value,
        leaveStatus: pendingLeaveStatus,
        appliedOn: DateTime.now().timeStampToInt);
    return leave;
  }

  Future<void> _applyForLeave() async {
    Leave leaveData = _getLeaveData();
    await _userLeaveService.applyForLeave(leaveData);
  }

  @override
  void detach() {
    _reason.close();
    _startDate.close();
    _endDate.close();
    _startLeaveTime.close();
    _endLeaveTime.close();
    _leaveType.close();
  }

  void reset() {
    _reason.sink.add('');
    _leaveType.sink.add(0);
    _startDate.sink.add(DateTime.now());
    _endDate.sink.add(DateTime.now());
    _startLeaveTime.sink.add(TimeOfDay.now());
    _endLeaveTime.sink.add(TimeOfDay.now());
  }

  @override
  void attach() {}
}
