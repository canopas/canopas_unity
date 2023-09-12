import 'dart:convert';
import 'dart:developer';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:projectunity/data/configs/api.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/model/leave/leave.dart';

@LazySingleton()
class NotificationService {
  final FirebaseCrashlytics _crashlytics;
  final http.Client _httpClient;

  NotificationService(this._httpClient, this._crashlytics);

  @disposeMethod
  Future<void> dispose() async {
    _httpClient.close();
  }

  Future<void> notifyHRForNewLeave(
      {required String name,
      required String reason,
      required DateTime startDate,
      required String duration,
      required DateTime endDate,
      required String receiver}) async {
    if (kDebugMode) return;
    try {
      http.Response response =
          await _httpClient.post(Uri.https(baseURL, 'api/leave/new'),
              body: json.encode({
                'name': name,
                "date": getFormatDate(startDate: startDate, endDate: endDate),
                "status": LeaveStatus.pending.value,
                'reason': reason,
                'duration': duration,
                'receiver': receiver,
              }));
      if (response.statusCode == 200) {
        log('New Leave notification mail send successfully',
            name: 'Notification');
      }
    } on Exception catch (e) {
     await _crashlytics.log(e.toString());
    }
  }

  Future<void> leaveResponse(
      {required String name,
      required DateTime startDate,
      required DateTime endDate,
      required LeaveStatus status,
      required String receiver}) async {
    try {
      http.Response response =
          await _httpClient.post(Uri.https(baseURL, 'api/leave/update'),
              body: json.encode({
                "name": name,
                "date": getFormatDate(startDate: startDate, endDate: endDate),
                "status": status.value,
                "receiver": receiver,
              }));
      if (response.statusCode == 200) {
        log('Leave request update notification mail send successfully',
            name: 'Notification');
      }
    } on Exception catch (e) {
      await _crashlytics.log(e.toString());
    }
  }

  String getFormatDate({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    if (startDate.dateOnly.isAtSameMomentAs(endDate.dateOnly)) {
      return DateFormat('dd MMM yyyy').format(startDate);
    }
    return '${DateFormat('dd MMM yyyy').format(startDate)} to ${DateFormat('dd MMM yyyy').format(endDate)}';
  }

  Future<void> sendInviteNotification(
      {required String companyName, required String receiver}) async {
    try {
      http.Response response =
          await _httpClient.post(Uri.https(baseURL, '/api/invitation'),
              body: json.encode({
                "receiver": receiver,
                "companyname": companyName,
                "spacelink": "https://unity.canopas.com/home",
              }));
      if (response.statusCode == 200) {
        log('Invite notification mail send successfully', name: 'Notification');
      }
    } on Exception catch (e) {
     await  _crashlytics.log(e.toString());
    }
  }

  Future<void> sendSpaceInviteAcceptNotification(
      {required String sender, required String receiver}) async {
    try {
      http.Response response =
          await _httpClient.post(Uri.https(baseURL, '/api/acceptence'),
              body: json.encode({
                "receiver": receiver,
                "sender": sender,
              }));
      if (response.statusCode == 200) {
        log('Accept invitation notification mail send successfully',
            name: 'Notification');
      }
    } on Exception catch (e) {
      await _crashlytics.log(e.toString());
    }
  }
}
