import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/core/extensions/string_extension.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/space_constant.dart';
import '../../../../../data/configs/text_style.dart';
import '../../../../../data/event_bus/events.dart';
import '../../../../navigation/app_router.dart';
import '../../../../widget/space_logo_view.dart';
import '../../../../widget/widget_validation.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class AdminHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String spaceName;
  final String? spaceDomain;
  final String? spaceLogo;

  const AdminHomeAppBar(
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
              InkWell(
                  onTap: () {
                    eventBus.fire(OpenDrawerEvent());
                  },
                  child: SpaceLogoView(spaceLogo: spaceLogo)),
              const SizedBox(width: primaryHorizontalSpacing),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      spaceName,
                      style: AppFontStyle.titleDark,
                      overflow: TextOverflow.ellipsis,
                    ),
                    ValidateWidget(
                      isValid: spaceDomain.isNotNullOrEmpty,
                      child: Text(
                        spaceDomain ?? "",
                        style: AppFontStyle.subTitleGrey,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                  onPressed: () => context.goNamed(Routes.addMember),
                  child: Text(
                    AppLocalizations.of(context).admin_home_invite_member_appbar_tag,
                    style: AppFontStyle.buttonTextStyle,
                  )),
            ],
          ),
          const SizedBox(height: primaryHalfSpacing),
          const Divider(height: 1),
        ],
      ),
    );
  }
}
