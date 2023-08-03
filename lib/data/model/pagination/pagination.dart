import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:equatable/equatable.dart';
import '../leave/leave.dart';

class PaginatedLeaves extends Equatable {
  final DocumentSnapshot<Leave> lastDoc;
  final List<Leave> leaves;

  const PaginatedLeaves({required this.leaves, required this.lastDoc});

  @override
  List<Object?> get props => [leaves, lastDoc];
}
