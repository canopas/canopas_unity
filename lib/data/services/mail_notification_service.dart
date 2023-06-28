import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:projectunity/data/configs/api.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/model/leave/leave.dart';

@LazySingleton()
class NotificationService {
  final http.Client httpClient;

  NotificationService(this.httpClient);

  @disposeMethod
  Future<void> dispose() async {
   httpClient.close();
  }

  Future<bool> notifyHRForNewLeave(
      {required String name,
      required DateTime startDate,
      required DateTime endDate,
      required String receiver}) async {
    if (kDebugMode) return true;
    try {
      http.Response response =
          await httpClient.post(Uri.https(baseURL, 'api/leave/new'),
              body: json.encode({
                'name': name,
                "date": getFormatDate(startDate: startDate, endDate: endDate),
                "status": LeaveStatus.pending.value,
                'receiver': receiver,
              }));
      return response.statusCode == 200;
    } on Exception {
      return false;
    }
  }

  Future<bool> leaveResponse(
      {required String name,
      required DateTime startDate,
      required DateTime endDate,
      required LeaveStatus status,
      required String receiver}) async {
    try {
      http.Response response =
          await httpClient.post(Uri.https(baseURL, 'api/leave/update'),
              body: json.encode({
                "name": name,
                "date": getFormatDate(startDate: startDate, endDate: endDate),
                "status": status.value,
                "receiver": receiver,
              }));
      return response.statusCode == 200;
    } on Exception {
      return false;
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
}
