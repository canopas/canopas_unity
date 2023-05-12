import 'package:equatable/equatable.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../../data/model/space/space.dart';

class DrawerState extends Equatable {
  final List<Space> spaces;
  final String? error;
  final Status fetchSpacesStatus;
  final Status changeSpaceStatus;
  final Status signOutStatus;

  const DrawerState({
    this.signOutStatus = Status.initial,
    this.changeSpaceStatus = Status.initial,
    this.spaces = const [],
    this.error,
    this.fetchSpacesStatus = Status.initial,
  });

  DrawerState copyWith({
    Status? signOutStatus,
    Status? changeSpaceStatus,
    String? error,
    Status? fetchSpacesStatus,
    List<Space>? spaces,
  }) =>
      DrawerState(
        signOutStatus: signOutStatus ?? this.signOutStatus,
        changeSpaceStatus: changeSpaceStatus ?? this.changeSpaceStatus,
        error: error,
        spaces: spaces ?? this.spaces,
        fetchSpacesStatus: fetchSpacesStatus ?? this.fetchSpacesStatus,
      );

  @override
  List<Object?> get props =>
      [spaces, error, fetchSpacesStatus, changeSpaceStatus, signOutStatus];
}
