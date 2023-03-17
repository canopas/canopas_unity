import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/space_constant.dart';
import '../../../../../data/configs/text_style.dart';
import '../../../../../data/configs/theme.dart';
import '../../../../../data/core/utils/const/image_constant.dart';
import '../../../../navigation/app_router.dart';

class EmployeeHomeAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const EmployeeHomeAppBar({Key? key, required this.preferredSize})
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
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.whiteColor,
                  boxShadow: AppTheme.commonBoxShadow,
                  image: const DecorationImage(
                      image: NetworkImage(ImageConst.companyLogo)),
                ),
              ),
              const SizedBox(width: primaryHorizontalSpacing),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context).company_name,
                      style: AppFontStyle.titleDark,
                      overflow: TextOverflow.ellipsis),
                  Text(
                    AppLocalizations.of(context).company_subtitle,
                    style: AppFontStyle.subTitleGrey,
                  )
                ],
              ),
              const Spacer(),
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
          const Divider(
            color: AppColors.dividerColor,
            height: 1,
            thickness: 1,
          )
        ],
      ),
    );
  }
}
