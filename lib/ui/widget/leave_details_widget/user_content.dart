import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/configs/text_style.dart';
import '../../../data/configs/space_constant.dart';
import '../../../data/model/employee/employee.dart';
import '../../navigation/app_router.dart';
import '../user_profile_image.dart';

class UserContent extends StatelessWidget {
  final Employee employee;

  const UserContent({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: primaryVerticalSpacing),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.pushNamed(Routes.adminEmployeeDetail,
            params: {RoutesParamsConst.employeeId: employee.id}),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: primaryHalfSpacing, horizontal: primaryVerticalSpacing),
          child: Row(
            children: [
              ImageProfile(radius: 30, imageUrl: employee.imageUrl),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee.name,
                      style: AppFontStyle.labelRegular,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      employee.designation,
                      style: AppFontStyle.bodySmallRegular,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
