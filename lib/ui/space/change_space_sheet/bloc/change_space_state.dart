import 'package:equatable/equatable.dart';
import '../../../../data/model/space/space.dart';

enum Status { initial, loading, failure, success }

class ChangeSpaceState extends Equatable {
  final Status fetchSpaceStatus;
  final Status changeSpaceStatus;
  final String? error;
  final List<Space> spaces;

  const ChangeSpaceState({
    this.error,
    this.spaces = const [],
    this.changeSpaceStatus = Status.initial,
    this.fetchSpaceStatus = Status.failure,
  });

  copyWith({
    Status? fetchSpaceStatus,
    Status? changeSpaceStatus,
    String? error,
    List<Space>? spaces,
  }) =>
      ChangeSpaceState(
        changeSpaceStatus: changeSpaceStatus ?? this.changeSpaceStatus,
        fetchSpaceStatus: fetchSpaceStatus ?? this.fetchSpaceStatus,
        error: error,
        spaces: spaces ?? this.spaces,
      );

  @override
  List<Object?> get props =>
      [fetchSpaceStatus, changeSpaceStatus, error, spaces];
}
