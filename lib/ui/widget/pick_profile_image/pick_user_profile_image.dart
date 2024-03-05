import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/core/extensions/string_extension.dart';
import 'package:projectunity/ui/widget/pick_profile_image/bloc/pick_image_state.dart';
import '../../../data/di/service_locator.dart';
import '../pick_image_bottom_sheet.dart';
import '../user_profile_image.dart';
import 'bloc/pick_image_bloc.dart';
import 'bloc/pick_image_event.dart';

class ProfileImagePicker extends StatelessWidget {
  final String? imageURl;
  final void Function(String image) onPickImageChange;
  const ProfileImagePicker(
      {super.key, this.imageURl, required this.onPickImageChange});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PickImageBloc>(),
      child: ProfileImage(
          imageURl: imageURl, onPickImageChange: onPickImageChange),
    );
  }
}

class ProfileImage extends StatelessWidget {
  final String? imageURl;
  final void Function(String image) onPickImageChange;

  const ProfileImage(
      {super.key, required this.imageURl, required this.onPickImageChange});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
              radius: 70,
              backgroundColor: context.colorScheme.containerNormal,
              child: BlocConsumer<PickImageBloc, PickImageState>(
                  listener: (context, state) {
                    if (state.isPickImageDone && state.pickedImage != null) {
                      onPickImageChange(state.pickedImage!);
                      context.pop();
                    }
                  },
                  buildWhen: (previous, current) =>
                      previous.pickedImage != current.pickedImage,
                  builder: (context, state) {
                    if (state.pickedImage.isNotNullOrEmpty) {
                      return ImageProfile(
                          radius: 65, pickedImage: state.pickedImage);
                    }
                    return ImageProfile(imageUrl: imageURl, radius: 65);
                  })),
          FloatingActionButton(
              onPressed: () {
                showBottomSheet(
                    context: context,
                    builder: (_) {
                      return PickImageBottomSheet(
                        onButtonTap: (ImageSource source) => context
                            .read<PickImageBloc>()
                            .add(PickImageEvent(imageSource: source)),
                      );
                    });
              },
              shape: CircleBorder(
                  side: BorderSide(
                      color: context.colorScheme.containerNormal, width: 2)),
              backgroundColor: context.colorScheme.surface,
              elevation: 2,
              mini: true,
              child: Icon(
                Icons.edit,
                color: context.colorScheme.containerHigh,
              )),
        ],
      ),
    );
  }
}
