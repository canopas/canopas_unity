import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/model/leave/leave_request_data.dart';

@Singleton()
class ApplyLeaveStateProvider extends ChangeNotifier {
  int? _leaveType;
  final int _employeeId = 0;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  String _reasonOfLeave = '';
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();

  int? get leaveType => _leaveType;

  void setLeaveType(int? value) {
    _leaveType = value;
    notifyListeners();
  }

  String get reasonOfLeave => _reasonOfLeave;

  setReasonOfLeave(String value) {
    _reasonOfLeave = value;
    notifyListeners();
  }

  TimeOfDay get startTime => _startTime;

  void setStartTime(TimeOfDay timeOfDay) {
    _startTime = timeOfDay;
    notifyListeners();
  }

  TimeOfDay get endTime => _endTime;

  void setEndTime(TimeOfDay timeOfDay) {
    _endTime = timeOfDay;
    notifyListeners();
  }

  DateTime get startLeaveDate => _startDate;

  void setStartLeaveDate(DateTime date) {
    _startDate = date;
    notifyListeners();
  }

  DateTime get endLeaveDate => _endDate;

  void setEndLeaveDate(DateTime date) {
    _endDate = date;
    notifyListeners();
  }

  int timeStampToInt(DateTime dateTime) {
    Timestamp timeStamp = Timestamp.fromDate(dateTime);
    int dateToInt = timeStamp.millisecondsSinceEpoch;
    return dateToInt;
  }

  DateTime startDateTime() => DateTime(_startDate.year, _startDate.month,
      _startDate.day, _startTime.hour, _startTime.minute);

  DateTime endDateTime() => DateTime(_endDate.year, _endDate.month,
      _endDate.day, _endTime.hour, _endTime.minute);

  double getTotalOfLeaves() {
    int totalHours = endDateTime().difference(startDateTime()).inHours;
    double totalLeaves = getLeaveByHours(totalHours);
    notifyListeners();
    return totalLeaves;
  }

  double getLeaveByHours(int leaveHours) {
    int fullDays = leaveHours ~/ 24;
    var remainder = leaveHours.remainder(24);
    double remainingHours(remainder) {
      if (remainder == 0) {
        return 0;
      } else if (remainder < 6) {
        return 0.5;
      } else {
        return 1;
      }
    }

    return fullDays + remainingHours(remainder);
  }

  double get totalDays => getTotalOfLeaves();

  LeaveRequestData getLeaveRequestData({required String userId}) {
    LeaveRequestData leaveRequestData = LeaveRequestData(
        uid: userId,
        leaveType: _leaveType,
        startDate: timeStampToInt(startDateTime()),
        endDate: timeStampToInt(endDateTime()),
        totalLeaves: totalDays,
        reason: _reasonOfLeave,
        emergencyContactPerson: _employeeId,
        appliedOn: timeStampToInt(DateTime.now()),
        leaveStatus: 1);
    return leaveRequestData;
  }

  void resetForm() {
    _leaveType = null;
    _startDate = DateTime.now();
    _endDate = DateTime.now();
    _startTime = TimeOfDay.now();
    _endTime = TimeOfDay.now();
    _reasonOfLeave = '';
    notifyListeners();
  }
}
