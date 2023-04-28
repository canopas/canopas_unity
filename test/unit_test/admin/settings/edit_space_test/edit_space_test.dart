import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/space/space.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/data/services/space_service.dart';
import 'package:projectunity/ui/admin/setting/edit_space/bloc/edit_space_bloc.dart';
import 'package:projectunity/ui/admin/setting/edit_space/bloc/edit_space_event.dart';
import 'package:projectunity/ui/admin/setting/edit_space/bloc/edit_space_state.dart';

import 'edit_space_test.mocks.dart';

@GenerateMocks([SpaceService, UserManager])
void main() {
  late SpaceService spaceService;
  late UserManager userManager;
  late EditSpaceBloc bloc;


  final space = Space(id: "id",
      name: "name",
      domain: "oldDomain",
      createdAt: DateTime.now(),
      paidTimeOff: 12,
      ownerIds: ["uid"]);

  setUp(() {
    userManager = MockUserManager();
    spaceService = MockSpaceService();
    bloc = EditSpaceBloc(spaceService, userManager);
    when(userManager.currentSpace).thenReturn(space);
  });

  group("Edit space test", ()
  {
    test("Delete space success test", () async {
      bloc.add(DeleteSpaceEvent());
      expect(bloc.stream, emitsInOrder([
            const EditSpaceState(deleteWorkSpaceStatus: Status.loading),
            const EditSpaceState(deleteWorkSpaceStatus: Status.success),
          ]));
      await untilCalled(spaceService.deleteSpace("id", ["uid"]));
      verify(spaceService.deleteSpace("id", ['uid'])).called(1);
      await untilCalled(userManager.removeSpace());
      verify(userManager.removeSpace()).called(1);
    });

    test("Delete space failure test", () async {
      bloc.add(DeleteSpaceEvent());
      when(spaceService.deleteSpace('id', ['uid'])).thenThrow(
          Exception("error"));
      expect(bloc.stream, emitsInOrder([
            const EditSpaceState(deleteWorkSpaceStatus: Status.loading),
            const EditSpaceState(
                deleteWorkSpaceStatus: Status.error,
                error: firestoreFetchDataError),
          ]));
    });

    test("update space details success test", () async {
      bloc.add(SaveSpaceDetails(
          paidTimeOff: "13", spaceName: "newName", spaceDomain: "newDomain"));
      expect(bloc.stream, emitsInOrder([
            const EditSpaceState(updateSpaceStatus: Status.loading),
            const EditSpaceState(updateSpaceStatus: Status.success),
          ]));
    });
  });
}
