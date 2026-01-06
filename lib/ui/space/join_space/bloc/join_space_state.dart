import 'package:equatable/equatable.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../../data/model/space/space.dart';

class JoinSpaceState extends Equatable {
  final Status fetchSpaceStatus;
  final Status selectSpaceStatus;
  final Status signOutStatus;
  final List<Space> ownSpaces;
  final List<Space> requestedSpaces;
  final String? error;

  const JoinSpaceState({
    this.selectSpaceStatus = Status.initial,
    this.fetchSpaceStatus = Status.initial,
    this.signOutStatus = Status.initial,
    this.ownSpaces = const [],
    this.requestedSpaces = const [],
    this.error,
  });

  JoinSpaceState copyWith({
    Status? signOutStatus,
    Status? fetchSpaceStatus,
    Status? selectSpaceStatus,
    List<Space>? ownSpaces,
    List<Space>? requestedSpaces,
    String? error,
  }) => JoinSpaceState(
    error: error,
    signOutStatus: signOutStatus ?? this.signOutStatus,
    selectSpaceStatus: selectSpaceStatus ?? this.selectSpaceStatus,
    fetchSpaceStatus: fetchSpaceStatus ?? this.fetchSpaceStatus,
    requestedSpaces: requestedSpaces ?? this.requestedSpaces,
    ownSpaces: ownSpaces ?? this.ownSpaces,
  );

  @override
  List<Object?> get props => [
    fetchSpaceStatus,
    ownSpaces,
    requestedSpaces,
    error,
    selectSpaceStatus,
    signOutStatus,
  ];
}
