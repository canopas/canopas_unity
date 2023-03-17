import 'package:equatable/equatable.dart';

abstract class NetworkConnectionState extends Equatable {
  const NetworkConnectionState();
}

class NetworkConnectionInitialState extends NetworkConnectionState {
  @override
  List<Object?> get props => [];
}

class NetworkConnectionFailureState extends NetworkConnectionState {
  @override
  List<Object?> get props => [];
}

class NetWorkConnectionSuccessState extends NetworkConnectionState {
  @override
  List<Object?> get props => [];
}
