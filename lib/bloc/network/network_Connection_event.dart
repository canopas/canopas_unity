import 'package:equatable/equatable.dart';

abstract class NetworkConnectionEvent extends Equatable{
  const NetworkConnectionEvent();
}
class NetworkConnectionObserveEvent extends NetworkConnectionEvent {
  @override
  List<Object?> get props => [];


}
class NetworkConnectionChangeEvent extends NetworkConnectionEvent{
  final bool hasConnection;
  const NetworkConnectionChangeEvent({required this.hasConnection});

  @override
  List<Object?> get props =>[hasConnection] ;

}