import 'package:equatable/equatable.dart';

abstract class CreateWorkSpaceEvents extends Equatable {}

class PageChangeEvent extends CreateWorkSpaceEvents {
  final int page;

  PageChangeEvent({required this.page});

  @override
  List<Object?> get props => [page];
}
