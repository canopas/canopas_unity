import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/ui/widget/pick_profile_image/bloc/pick_image_bloc.dart';
import 'package:projectunity/ui/widget/pick_profile_image/bloc/pick_image_event.dart';
import 'package:projectunity/ui/widget/pick_profile_image/bloc/pick_image_state.dart';

import 'picked_image_bloc_test.mocks.dart';

@GenerateMocks([ImagePicker])
void main() {
  late ImagePicker imagePicker;
  late PickImageBloc bloc;

  group("who is out view test", () {
    setUp(() {
      imagePicker = MockImagePicker();
      bloc = PickImageBloc(imagePicker);
    });

    test("pick image from gallery test", () {
      bloc.add(PickImageEvent(imageSource: ImageSource.gallery));
      when(
        imagePicker.pickImage(source: ImageSource.gallery),
      ).thenAnswer((realInvocation) async => XFile('file'));
      expect(
        bloc.stream,
        emits(const PickImageState(pickedImage: 'file', isPickImageDone: true)),
      );
    });

    test("pick image from camera test", () {
      bloc.add(PickImageEvent(imageSource: ImageSource.camera));
      when(
        imagePicker.pickImage(source: ImageSource.camera),
      ).thenAnswer((realInvocation) async => XFile('file'));
      expect(
        bloc.stream,
        emits(const PickImageState(pickedImage: 'file', isPickImageDone: true)),
      );
    });
  });
}
