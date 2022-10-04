import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@Injectable()
class NetworkServiceBloc {
  Connectivity connectivity = Connectivity();

  final BehaviorSubject<bool> _connection = BehaviorSubject<bool>();

  BehaviorSubject<bool> get connection => _connection;

  void getConnectivityStatus() async {
    inItConnection();
    connectivity.onConnectivityChanged.listen((result) {
      _checkNetworkConnection(result);
    });
  }

  Future<void> inItConnection() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkNetworkConnection(result);
  }

  Future<void> _checkNetworkConnection(ConnectivityResult result) async {
    bool hasConnection = false;
    try {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        hasConnection = true;
      }
    } on Exception {
      hasConnection = false;
    }
    _connection.add(hasConnection);

  }
}
