import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/org_forms/org_form_info/org_form_info.dart';
import 'package:projectunity/data/repo/form_repo.dart';
import 'package:projectunity/ui/user/forms/form_list_screen/bloc/user_forms_list_screen_bloc.dart';
import 'package:projectunity/ui/user/forms/form_list_screen/bloc/user_forms_list_screen_event.dart';
import 'package:projectunity/ui/user/forms/form_list_screen/bloc/user_forms_list_screen_state.dart';

import 'user_form_list_test.mocks.dart';

@GenerateMocks([FormRepo])
void main() {
  late FormRepo formRepo;
  late UserFormListBloc bloc;

  group('Admin forms list test', () {
    OrgFormInfo formInfo1 = OrgFormInfo(
        createdAt: DateTime.now().dateOnly,
        id: 'form-info-1-id',
        title: "Dummy Form",
        description: 'Dummy Description',
        oneTimeResponse: false,
        headerImage: "image-url");

    setUp(() {
      formRepo = MockFormRepo();
      bloc = UserFormListBloc(formRepo);
    });

    test('Initial state test', () {
      expect(
          bloc.state,
          const UserFormListState(
              error: null, status: Status.initial, forms: []));
    });

    test('Fetch forms success test', () {
      when(formRepo.getForms())
          .thenAnswer((realInvocation) async => [formInfo1]);
      bloc.add(UserFormListInitialLoadEvent());
      expect(
          bloc.stream,
          emitsInOrder([
            const UserFormListState(status: Status.loading),
            UserFormListState(status: Status.success, forms: [formInfo1]),
          ]));
    });

    test('Fetch forms failure test', () {
      when(formRepo.getForms()).thenThrow(Exception(firestoreFetchDataError));
      bloc.add(UserFormListInitialLoadEvent());
      expect(
          bloc.stream,
          emitsInOrder([
            const UserFormListState(status: Status.loading),
            const UserFormListState(
                status: Status.error, error: firestoreFetchDataError),
          ]));
    });
  });
}
