// Mocks generated by Mockito 5.3.2 from annotations
// in projectunity/test/unit_test/admin/employee/detail/employee_detail_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:ui' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:projectunity/model/employee/employee.dart' as _i7;
import 'package:projectunity/navigation/nav_stack/nav_stack_item.dart' as _i2;
import 'package:projectunity/navigation/navigation_stack_manager.dart' as _i3;
import 'package:projectunity/services/admin/employee/employee_service.dart'
    as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeNavStackItem_0 extends _i1.SmartFake implements _i2.NavStackItem {
  _FakeNavStackItem_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [NavigationStackManager].
///
/// See the documentation for Mockito's code generation for more information.
class MockNavigationStackManager extends _i1.Mock
    implements _i3.NavigationStackManager {
  MockNavigationStackManager() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i2.NavStackItem> get pages => (super.noSuchMethod(
        Invocation.getter(#pages),
        returnValue: <_i2.NavStackItem>[],
      ) as List<_i2.NavStackItem>);
  @override
  _i2.NavStackItem get currentState => (super.noSuchMethod(
        Invocation.getter(#currentState),
        returnValue: _FakeNavStackItem_0(
          this,
          Invocation.getter(#currentState),
        ),
      ) as _i2.NavStackItem);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  void updateStack(List<_i2.NavStackItem>? newItems) => super.noSuchMethod(
        Invocation.method(
          #updateStack,
          [newItems],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void push(_i2.NavStackItem? item) => super.noSuchMethod(
        Invocation.method(
          #push,
          [item],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void clearAndPush(_i2.NavStackItem? item) => super.noSuchMethod(
        Invocation.method(
          #clearAndPush,
          [item],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addListener(_i4.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i4.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [EmployeeService].
///
/// See the documentation for Mockito's code generation for more information.
class MockEmployeeService extends _i1.Mock implements _i5.EmployeeService {
  MockEmployeeService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Stream<List<_i7.Employee>> getEmployeeStream() => (super.noSuchMethod(
        Invocation.method(
          #getEmployeeStream,
          [],
        ),
        returnValue: _i6.Stream<List<_i7.Employee>>.empty(),
      ) as _i6.Stream<List<_i7.Employee>>);
  @override
  _i6.Future<List<_i7.Employee>> getEmployees() => (super.noSuchMethod(
        Invocation.method(
          #getEmployees,
          [],
        ),
        returnValue: _i6.Future<List<_i7.Employee>>.value(<_i7.Employee>[]),
      ) as _i6.Future<List<_i7.Employee>>);
  @override
  _i6.Future<_i7.Employee?> getEmployee(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getEmployee,
          [id],
        ),
        returnValue: _i6.Future<_i7.Employee?>.value(),
      ) as _i6.Future<_i7.Employee?>);
  @override
  _i6.Future<bool> hasUser(String? email) => (super.noSuchMethod(
        Invocation.method(
          #hasUser,
          [email],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);
  @override
  _i6.Future<void> addEmployee(_i7.Employee? employee) => (super.noSuchMethod(
        Invocation.method(
          #addEmployee,
          [employee],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> deleteEmployee(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteEmployee,
          [id],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
}
