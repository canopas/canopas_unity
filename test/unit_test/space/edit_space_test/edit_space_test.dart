import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/space/space.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/services/space_service.dart';
import 'package:projectunity/data/services/storage_service.dart';
import 'package:projectunity/ui/admin/drawer_options/edit_space/bloc/edit_space_bloc.dart';
import 'package:projectunity/ui/admin/drawer_options/edit_space/bloc/edit_space_event.dart';
import 'package:projectunity/ui/admin/drawer_options/edit_space/bloc/edit_space_state.dart';

import 'edit_space_test.mocks.dart';



@GenerateMocks([SpaceService, UserStateNotifier, ImagePicker, StorageService])
void main() {
  late SpaceService spaceService;
  late UserStateNotifier userStateNotifier;
  late StorageService storageService;
  late ImagePicker imagePicker;
  late EditSpaceBloc bloc;

  final space = Space(
      id: "space-id",
      name: "name",
      domain: "oldDomain",
      createdAt: DateTime.now(),
      paidTimeOff: 12,
      ownerIds: ["uid"]);

  setUp(() {
    userStateNotifier = MockUserStateNotifier();
    spaceService = MockSpaceService();
    imagePicker = MockImagePicker();
    storageService = MockStorageService();
    bloc = EditSpaceBloc(
        spaceService, userStateNotifier, imagePicker, storageService);
    when(userStateNotifier.currentSpace).thenReturn(space);
    when(userStateNotifier.currentSpaceId).thenReturn(space.id);
  });

  group("Edit space test", () {
    test("Pick Image Test", () async {
      XFile xFile = XFile('path');
      bloc.add(PickImageEvent(imageSource: ImageSource.gallery));
      when(imagePicker.pickImage(source: ImageSource.gallery))
          .thenAnswer((realInvocation) async => xFile);
      expect(
          bloc.stream,
          emits(EditSpaceState(
            logo: xFile.path,
            isLogoPickedDone: true,
          )));
    });

    test("Delete space success test", () async {
      bloc.add(DeleteSpaceEvent());
      expect(
          bloc.stream,
          emitsInOrder([
            const EditSpaceState(deleteWorkSpaceStatus: Status.loading),
            const EditSpaceState(deleteWorkSpaceStatus: Status.success),
          ]));
      await untilCalled(spaceService.deleteSpace("space-id", ["uid"]));
      verify(spaceService.deleteSpace("space-id", ['uid'])).called(1);
      await untilCalled(userStateNotifier.removeEmployeeWithSpace());
      verify(userStateNotifier.removeEmployeeWithSpace()).called(1);
    });

    test("Delete space failure test", () async {
      bloc.add(DeleteSpaceEvent());
      when(spaceService.deleteSpace('space-id', ['uid']))
          .thenThrow(Exception("error"));
      expect(
          bloc.stream,
          emitsInOrder([
            const EditSpaceState(deleteWorkSpaceStatus: Status.loading),
            const EditSpaceState(
                deleteWorkSpaceStatus: Status.error,
                error: firestoreFetchDataError),
          ]));
    });

    test("update space details success test", () async {
      final file = XFile('path');
      when(storageService.uploadProfilePic(path: 'images/space-id/space-logo', imagePath: 'path')).thenAnswer((realInvocation) async => 'image_url');
      final updatedSpace = Space(
          ownerIds: space.ownerIds,
          id: space.id,
          name: 'newName',
          paidTimeOff: int.parse('13'),
          createdAt: space.createdAt,
          domain: 'newDomain',
          logo: 'image-url');

      bloc.emit(EditSpaceState(logo: file.path));

      bloc.add(SaveSpaceDetails(
          paidTimeOff: "13", spaceName: "newName", spaceDomain: "newDomain"));

      expect(
          bloc.stream,
          emitsInOrder([
            EditSpaceState(logo: file.path, updateSpaceStatus: Status.loading),
            EditSpaceState(logo: file.path, updateSpaceStatus: Status.success),
          ]));

      await (spaceService.updateSpace(updatedSpace));
      verify.call(spaceService.updateSpace(updatedSpace));
      await (userStateNotifier.updateSpace(updatedSpace));
      verify.call(userStateNotifier.updateSpace(updatedSpace));
    });
  });
}
