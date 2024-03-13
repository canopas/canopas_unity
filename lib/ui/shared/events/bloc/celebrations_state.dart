import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/core/utils/bloc_status.dart';
import '../../../../data/model/employee/employee.dart';
import '../model/event.dart';
part 'celebrations_state.freezed.dart';

@freezed
class CelebrationsState with _$CelebrationsState{
  const factory CelebrationsState({
    @Default(Status.initial) Status status,
    required DateTime currentWeek,
    @Default(false) bool showAllBdays,
    @Default(false) bool showAllAnniversaries,
    @Default([]) List<Event> birthdays,
    @Default([]) List<Event> anniversaries,
    String? error
})= _CelebrationsState;
}