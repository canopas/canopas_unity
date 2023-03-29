import 'package:equatable/equatable.dart';

class CreateWorkSpaceState extends Equatable {
  final int page;

  const CreateWorkSpaceState({
    this.page = 0,
  });

  copyWith({
    int? page,
  }) =>
      CreateWorkSpaceState(
        page: page ?? this.page,
      );

  @override
  List<Object?> get props => [page];
}
