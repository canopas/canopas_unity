import 'package:equatable/equatable.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../data/model/org_forms/org_form_info/org_form_info.dart';

class AdminFormListState extends Equatable {
  final Status status;
  final String? error;
  final List<OrgFormInfo> forms;

  const AdminFormListState({
    this.error,
    this.status = Status.initial,
    this.forms = const [],
  });

  AdminFormListState copyWith({
    Status? status,
    String? error,
    List<OrgFormInfo>? forms,
  }) => AdminFormListState(
    status: status ?? this.status,
    error: error,
    forms: forms ?? this.forms,
  );

  @override
  List<Object?> get props => [status, error, forms];
}
