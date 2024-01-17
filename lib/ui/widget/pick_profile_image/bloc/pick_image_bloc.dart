import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/ui/widget/pick_profile_image/bloc/pick_image_event.dart';
import 'package:projectunity/ui/widget/pick_profile_image/bloc/pick_image_state.dart';

@Injectable()
class PickImageBloc extends Bloc<PickImageEvents, PickImageState> {
  final ImagePicker _imagePicker;

  PickImageBloc(this._imagePicker) : super(const PickImageState()) {
    on<PickImageEvent>(_pickImage);
  }

  Future<void> _pickImage(
      PickImageEvent event, Emitter<PickImageState> emit) async {
    final XFile? image =
        await _imagePicker.pickImage(source: event.imageSource);
    if (image != null) {
      final file = File(image.path);
      emit(state.copyWith(pickedImage: file.path, isPickImageDone: true));
    }
  }
}
