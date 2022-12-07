// Mocks generated by Mockito 5.3.2 from annotations
// in projectunity/test/unit_test/admin/settings/paid_leave_count_setting_bloc/admin_setting_paid_leave_count_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:ui' as _i6;

import 'package:mockito/mockito.dart' as _i1;
import 'package:projectunity/navigation/nav_stack/nav_stack_item.dart' as _i2;
import 'package:projectunity/navigation/navigation_stack_manager.dart' as _i5;
import 'package:projectunity/services/admin/paid_leave/paid_leave_service.dart'
    as _i3;

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

/// A class which mocks [PaidLeaveService].
///
/// See the documentation for Mockito's code generation for more information.
class MockPaidLeaveService extends _i1.Mock implements _i3.PaidLeaveService {
  MockPaidLeaveService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<int> getPaidLeaves() => (super.noSuchMethod(
        Invocation.method(
          #getPaidLeaves,
          [],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);
  @override
  _i4.Stream<int> getPadLeavesAsStream() => (super.noSuchMethod(
        Invocation.method(
          #getPadLeavesAsStream,
          [],
        ),
        returnValue: _i4.Stream<int>.empty(),
      ) as _i4.Stream<int>);
  @override
  _i4.Future<void> updateLeaveCount(int? leaveCount) => (super.noSuchMethod(
        Invocation.method(
          #updateLeaveCount,
          [leaveCount],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [NavigationStackManager].
///
/// See the documentation for Mockito's code generation for more information.
class MockNavigationStackManager extends _i1.Mock
    implements _i5.NavigationStackManager {
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
  void addListener(_i6.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i6.VoidCallback? listener) => super.noSuchMethod(
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
