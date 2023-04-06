import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/services/space_service.dart';
import 'package:projectunity/ui/admin/setting/edit_space/bloc/edit_space_bloc.dart';
import 'package:projectunity/ui/admin/setting/edit_space/bloc/edit_space_event.dart';
import 'edit_workspace_test.mocks.dart';

@GenerateMocks([SpaceService])
void main() {
  late SpaceService workspaceService;
  late EditSpaceBloc bloc;

  setUpAll(() {
    workspaceService = MockSpaceService();
    bloc = EditSpaceBloc(workspaceService);
  });

  group("delete workspace test", () {
    test("initial load data test", () async {
      bloc.add(DeleteSpaceEvent(workspaceId: "id"));
      await untilCalled(workspaceService.deleteSpace("id"));
      verify(workspaceService.deleteSpace("id")).called(1);
    });
  });
}
