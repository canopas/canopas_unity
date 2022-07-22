import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigation_stack_item.freezed.dart';

abstract class NavigationStackItem {}

@freezed
class NavigationStack<T> with _$NavigationStack {
  const factory NavigationStack.admin() = AdminState;

  const factory NavigationStack.employee() = EmployeeState;
}
