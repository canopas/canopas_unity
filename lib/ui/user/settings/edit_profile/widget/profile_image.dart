import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectunity/data/configs/text_style.dart';
import 'package:projectunity/ui/user/settings/edit_profile/bloc/employee_edit_profile_bloc.dart';
import 'package:projectunity/ui/user/settings/edit_profile/bloc/employee_edit_profile_event.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../widget/user_profile_image.dart';
import '../bloc/employee_edit_profile_state.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class ProfileImage extends StatelessWidget {
  final String? imageURl;

  const ProfileImage({Key? key, required this.imageURl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
              radius: 70,
              backgroundColor: AppColors.textFieldBg,
              child: BlocBuilder<EmployeeEditProfileBloc,
                      EmployeeEditProfileState>(
                  buildWhen: (previous, current) =>
                      (previous.imageURL != current.imageURL) &&
                      current.imageURL != null,
                  builder: (context, state) {
                    if (state.imageURL != null) {
                      return ImageProfile(
                          radius: 65, pickedImage: state.imageURL);
                    }
                    return ImageProfile(imageUrl: imageURl, radius: 65);
                  })),
          FloatingActionButton(
              onPressed: () {
                showBottomSheet(
                    context: context,
                    builder: (context) {
                      return const ChooseFromBottomSheet();
                    });
              },
              shape: const CircleBorder(
                  side: BorderSide(color: AppColors.textFieldBg, width: 2)),
              backgroundColor: AppColors.whiteColor,
              elevation: 2,
              mini: true,
              child: const Icon(
                Icons.edit,
                color: AppColors.darkGrey,
              )),
        ],
      ),
    );
  }
}

class ChooseFromBottomSheet extends StatelessWidget {
  const ChooseFromBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SelectButton(
            label: locale.user_setting_take_photo_tag,
            icon: Icons.camera_alt_rounded,
            source: ImageSource.camera,
          ),
          SelectButton(
            label: locale.user_setting_gallery_tag,
            icon: Icons.perm_media_rounded,
            source: ImageSource.gallery,
          ),
        ],
      ),
    );
  }
}

class SelectButton extends StatelessWidget {
  final String label;
  final ImageSource source;
  final IconData icon;

  const SelectButton(
      {Key? key, required this.label, required this.source, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
            ),
            child: Icon(icon),
            onPressed: () {
              BlocProvider.of<EmployeeEditProfileBloc>(context)
                  .add(ChangeImageEvent(imageSource: source));
            }),
        const SizedBox(
          height: 5,
        ),
        Text(
          label,
          style: AppFontStyle.subTitleGrey,
        )
      ],
    );
  }
}
