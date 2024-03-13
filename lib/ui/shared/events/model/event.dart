import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String name;
  final String? imageUrl;
  final DateTime dateTime;

  const Event({required this.name, required this.dateTime, this.imageUrl});

  @override
  List<Object?> get props => [name, imageUrl, dateTime];
}
