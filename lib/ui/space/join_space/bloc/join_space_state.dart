import 'package:equatable/equatable.dart';
import '../../../../data/model/space/space.dart';

enum Status { initial, failure, loading, success }

class JoinSpaceState extends Equatable {
  final Status getSpaceStatus;
  final List<Space> spaces;
  final String? error;

  const JoinSpaceState({
    this.getSpaceStatus = Status.initial,
    this.spaces = const [],
    this.error,
  });

  copy({Status? getSpaceStatus, List<Space>? spaces, String? error}) =>
      JoinSpaceState(
          error: error,
          getSpaceStatus: getSpaceStatus ?? this.getSpaceStatus,
          spaces: spaces ?? this.spaces);

  @override
  List<Object?> get props => [getSpaceStatus, spaces, error];
}
