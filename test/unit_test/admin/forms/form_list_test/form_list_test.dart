import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/org_forms/org_form_info/org_form_info.dart';
import 'package:projectunity/data/repo/form_repo.dart';
import 'package:projectunity/ui/admin/forms/form_list/bloc/admin_form_list_bloc.dart';
import 'package:projectunity/ui/admin/forms/form_list/bloc/admin_form_list_event.dart';
import 'package:projectunity/ui/admin/forms/form_list/bloc/admin_form_list_state.dart';

import 'form_list_test.mocks.dart';

@GenerateMocks([FormRepo])
void main() {
  late FormRepo formRepo;
  late AdminFormListBloc bloc;

  group('Admin forms list test', () {
    OrgFormInfo formInfo1 = OrgFormInfo(
      createdAt: DateTime.now().dateOnly,
      id: 'form-info-1-id',
      title: "Dummy Form",
      description: 'Dummy Description',
      oneTimeResponse: false,
      headerImage: "image-url",
    );

    group('Admin forms list Initial load test', () {
      setUp(() {
        formRepo = MockFormRepo();
        bloc = AdminFormListBloc(formRepo);
      });

      test('Initial state test', () {
        expect(
          bloc.state,
          const AdminFormListState(
            error: null,
            status: Status.initial,
            forms: [],
          ),
        );
      });

      test('Fetch forms success test', () {
        when(
          formRepo.getForms(),
        ).thenAnswer((realInvocation) async => [formInfo1]);
        bloc.add(AdminFormListInitialLoadEvent());
        expect(
          bloc.stream,
          emitsInOrder([
            const AdminFormListState(status: Status.loading),
            AdminFormListState(status: Status.success, forms: [formInfo1]),
          ]),
        );
      });

      test('Fetch forms failure test', () {
        when(formRepo.getForms()).thenThrow(Exception(firestoreFetchDataError));
        bloc.add(AdminFormListInitialLoadEvent());
        expect(
          bloc.stream,
          emitsInOrder([
            const AdminFormListState(status: Status.loading),
            const AdminFormListState(
              status: Status.error,
              error: firestoreFetchDataError,
            ),
          ]),
        );
      });
    });

    group('Admin forms list test', () {
      OrgFormInfo formInfo2 = OrgFormInfo(
        createdAt: DateTime.now().dateOnly,
        id: 'form-info-2-id',
        title: "Dummy Form",
        description: 'Dummy Description',
        oneTimeResponse: false,
        headerImage: "image-url",
      );

      setUpAll(() {
        formRepo = MockFormRepo();
        bloc = AdminFormListBloc(formRepo);
      });

      test('Fetch forms success test', () {
        when(
          formRepo.getForms(),
        ).thenAnswer((realInvocation) async => [formInfo1]);
        bloc.add(AdminFormListInitialLoadEvent());
        expect(
          bloc.stream,
          emitsInOrder([
            const AdminFormListState(status: Status.loading),
            AdminFormListState(status: Status.success, forms: [formInfo1]),
          ]),
        );
      });

      test('Fetch forms success test', () {
        when(
          formRepo.getFormInfo(formId: 'form-info-2-id'),
        ).thenAnswer((realInvocation) async => formInfo2);
        bloc.add(UpdateFormEvent('form-info-2-id'));
        expect(
          bloc.stream,
          emits(
            AdminFormListState(
              status: Status.success,
              forms: [formInfo1, formInfo2],
            ),
          ),
        );
      });
    });
  });
}
