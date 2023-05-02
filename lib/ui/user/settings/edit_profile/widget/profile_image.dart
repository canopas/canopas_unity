import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectunity/ui/user/settings/edit_profile/bloc/employee_edit_profile_bloc.dart';
import 'package:projectunity/ui/user/settings/edit_profile/bloc/employee_edit_profile_event.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../widget/pick_image_bottom_sheet.dart';
import '../../../../widget/user_profile_image.dart';
import '../bloc/employee_edit_profile_state.dart';

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
                      return PickImageBottomSheet(
                        onButtonTap: (ImageSource source) {
                          BlocProvider.of<EmployeeEditProfileBloc>(context)
                              .add(ChangeImageEvent(imageSource: source));
                        },
                      );
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


