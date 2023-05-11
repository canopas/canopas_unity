import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/core/extensions/string_extension.dart';
import 'package:projectunity/ui/widget/space_logo_view.dart';
import 'package:projectunity/ui/widget/widget_validation.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/space_constant.dart';
import '../../../../../data/configs/text_style.dart';
import '../../../../navigation/app_router.dart';

class EmployeeHomeAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String spaceName;
  final String? spaceDomain;
  final String? spaceLogo;

  const EmployeeHomeAppBar(
      {Key? key,
      required this.preferredSize,
      required this.spaceName,
      this.spaceDomain,
      this.spaceLogo})
      : super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: primaryHorizontalSpacing),
      alignment: Alignment.bottomCenter,
      decoration: const BoxDecoration(color: AppColors.whiteColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SpaceLogoView(spaceLogo: spaceLogo),
              const SizedBox(width: primaryHorizontalSpacing),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(spaceName,
                        style: AppFontStyle.titleDark,
                        overflow: TextOverflow.ellipsis),
                    ValidateWidget(
                      isValid: spaceDomain.isNotNullOrEmpty,
                      child: Text(
                        spaceDomain ?? "",
                        style: AppFontStyle.subTitleGrey,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
              CircleAvatar(
                backgroundColor: const Color(0xfff5f5f5),
                child: IconButton(
                    onPressed: () =>
                        context.pushNamed(Routes.userLeaveCalender),
                    icon: const Icon(
                      Icons.calendar_month_rounded,
                      color: AppColors.darkGrey,
                    )),
              ),
            ],
          ),
          const SizedBox(height: primaryHalfSpacing),
          const Divider(height: 1)
        ],
      ),
    );
  }
}
