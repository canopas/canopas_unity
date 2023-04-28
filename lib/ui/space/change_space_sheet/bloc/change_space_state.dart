import 'package:equatable/equatable.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import '../../../../data/model/space/space.dart';

class ChangeSpaceState extends Equatable {
  final Status fetchSpaceStatus;
  final Status changeSpaceStatus;
  final String? error;
  final List<Space> spaces;

  const ChangeSpaceState({
    this.error,
    this.spaces = const [],
    this.changeSpaceStatus = Status.initial,
    this.fetchSpaceStatus = Status.initial,
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
