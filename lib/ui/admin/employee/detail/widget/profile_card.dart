import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/utils/const/role.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import '../../../../../../configs/colors.dart';
import '../../../../../../model/employee/employee.dart';
import '../../../../../../widget/user_profile_image.dart';
import '../bloc/employee_detail_bloc.dart';
import '../bloc/employee_detail_event.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key, required this.employee}) : super(key: key);

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Stack(
      alignment: const Alignment(0, -1),
      children: [
        Container(
          height: 150,
          decoration: const BoxDecoration(
              color: AppColors.primaryBlue,
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.elliptical(200, 10))),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 0),
                color: AppColors.greyColor.withOpacity(0.15),
                spreadRadius: 3,
                blurRadius: 5,
              )
            ],
          ),
          margin: const EdgeInsets.only(
              top: 70.0,
              bottom: 5,
              left: primaryHorizontalSpacing,
              right: primaryHorizontalSpacing),
          padding:
              const EdgeInsets.all(primaryHorizontalSpacing).copyWith(top: 70),
          child: Column(
            children: [
              Text(
                employee.name,
                style: AppTextStyle.headerDark600,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                employee.designation,
                style: AppTextStyle.secondarySubtitle500,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextColumn(
                    title: localization.employee_role_tag,
                    subtitle:
                        localization.user_detail_role_type(employee.roleType),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: 1,
                    color: AppColors.greyColor,
                  ),
                  TextColumn(
                    title: localization.employee_employeeID_tag,
                    subtitle: employee.employeeId,
                  ),
                ],
              ),
              const SizedBox(
                height: primaryHorizontalSpacing,
              ),
              OutlinedButton(
                  onPressed: (){
                    context.read<EmployeeDetailBloc>().add(DeleteEmployeeEvent(employeeId: employee.id));
                    context.pop();
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fixedSize: Size(MediaQuery.of(context).size.width, 40),
                    side: BorderSide.none,
                    backgroundColor: AppColors.redColor.withOpacity(0.20),
                    foregroundColor: Colors.black,
                  ),
                  child: Text(
                    AppLocalizations.of(context).user_leave_detail_button_delete,
                    style: AppTextStyle.subtitleText,
                  ),
              ),
              OutlinedButton(
                  onPressed: () {
                    context.read<EmployeeDetailBloc>().add(EmployeeDetailsChangeRoleTypeEvent());
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fixedSize: Size(MediaQuery.of(context).size.width, 40),
                    side: BorderSide.none,
                    backgroundColor: employee.roleType!=kRoleTypeAdmin?AppColors.primaryBlue.withOpacity(0.20):AppColors.redColor.withOpacity(0.20),
                    foregroundColor: Colors.black,
                  ),
                  child: Text(employee.roleType!=kRoleTypeAdmin?localization.employee_details_make_admin_tag:localization.employee_details_remove_admin_tag,style: AppTextStyle.subtitleText,))
            ],
          ),
        ),
        ProfilePic(imageUrl: employee.imageUrl),
      ],
    );
  }
}

class TextColumn extends StatelessWidget {
  const TextColumn({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(title, style: AppTextStyle.secondarySubtitle500),
          const SizedBox(height: 6),
          Text(
            subtitle ?? "-",
            style: AppTextStyle.titleText,
          ),
        ],
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({Key? key, required this.imageUrl}) : super(key: key);

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: primaryHorizontalSpacing),
      child: CircleAvatar(
        radius: 55,
        backgroundColor: AppColors.whiteColor,
        child: ImageProfile(imageUrl: imageUrl, radius: 50),
      ),
    );
  }
}
