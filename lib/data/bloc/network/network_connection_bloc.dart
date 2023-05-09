import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'network_connection_event.dart';
import 'network_connection_state.dart';

@Injectable()
class NetworkConnectionBloc
    extends Bloc<NetworkConnectionEvent, NetworkConnectionState> {
  StreamSubscription? _subscription;
  final Connectivity _connectivity;

  NetworkConnectionBloc(this._connectivity)
      : super(NetworkConnectionInitialState()) {
    on<NetworkConnectionObserveEvent>(_observeConnection);
    on<NetworkConnectionChangeEvent>(_changeConnection);
  }

  Future<void> _observeConnection(NetworkConnectionObserveEvent event,
      Emitter<NetworkConnectionState> emit) async {
    _subscription = _connectivity.onConnectivityChanged.listen((result) {
      _checkNetworkConnection(result);
    });
  }

  void _checkNetworkConnection(ConnectivityResult result) {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      add(const NetworkConnectionChangeEvent(hasConnection: true));
    } else {
      add(const NetworkConnectionChangeEvent(hasConnection: false));
    }
  }

  void _changeConnection(NetworkConnectionChangeEvent event,
      Emitter<NetworkConnectionState> emit) {
    if (event.hasConnection == true) {
      emit(NetWorkConnectionSuccessState());
    } else {
      emit(NetworkConnectionFailureState());
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
