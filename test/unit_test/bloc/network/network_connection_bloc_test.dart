import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/bloc/network/network_connection_bloc.dart';
import 'package:projectunity/data/bloc/network/network_connection_event.dart';
import 'package:projectunity/data/bloc/network/network_connection_state.dart';

import 'network_connection_bloc_test.mocks.dart';

@GenerateMocks([Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late NetworkConnectionBloc networkConnectionBloc;
  late Connectivity connectivity;
  List<ConnectivityResult> connections = [
    ConnectivityResult.wifi,
    ConnectivityResult.mobile
  ];
  setUp(() {
    connectivity = MockConnectivity();
    networkConnectionBloc = NetworkConnectionBloc(connectivity);
  });
  group('Network connection', () {
    test(
        'Emits Initial state when as state os starting state of network connection bloc',
        () {
      expect(networkConnectionBloc.state, NetworkConnectionInitialState());
    });
    test(
        'Emits NetworkConnectionSuccessState if device is connected to either mobile or wifi',
        () async {
      when(connectivity.onConnectivityChanged)
          .thenAnswer((_) => Stream.fromIterable([connections]));
      networkConnectionBloc.add(NetworkConnectionObserveEvent());
      expectLater(
          networkConnectionBloc.stream, emits(NetWorkConnectionSuccessState()));
    });
    test(
        'Emits NetworkConnectionFailureState if device is not connected to mobile or wifi',
        () {
      when(connectivity.onConnectivityChanged)
          .thenAnswer((_) => Stream.fromIterable([
                [ConnectivityResult.ethernet]
              ]));
      networkConnectionBloc.add(NetworkConnectionObserveEvent());
      expectLater(
          networkConnectionBloc.stream, emits(NetworkConnectionFailureState()));
    });
  });
}
