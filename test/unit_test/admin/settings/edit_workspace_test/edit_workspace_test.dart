import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/services/workspace_service.dart';
import 'package:projectunity/ui/admin/setting/edit_work_space/bloc/edit_workspace_bloc.dart';
import 'package:projectunity/ui/admin/setting/edit_work_space/bloc/edit_workspace_event.dart';

import 'edit_workspace_test.mocks.dart';

@GenerateMocks([WorkspaceService])
void main() {
  late WorkspaceService workspaceService;
  late EditWorkSpaceBloc bloc;

  setUpAll(() {
    workspaceService = MockWorkspaceService();
    bloc = EditWorkSpaceBloc(workspaceService);
  });

  group("delete workspace test", () {
    test("initial load data test", () async {
      bloc.add(DeleteWorkspaceEvent(workspaceId: "id"));
      await untilCalled(workspaceService.deleteWorkspace("id"));
      verify(workspaceService.deleteWorkspace("id")).called(1);
    });
  });
}
