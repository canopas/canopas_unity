import 'package:cloud_firestore/cloud_firestore.dart';
import '../leave/leave.dart';

class LeavesPaginationData{
  final DocumentSnapshot<Leave> lastDoc;
  final List<Leave> leaves;

  LeavesPaginationData({required this.leaves, required this.lastDoc});
}