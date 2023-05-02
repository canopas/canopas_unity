import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/core/extensions/string_extension.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/space_constant.dart';
import '../../../../../data/configs/text_style.dart';
import '../../../../../data/configs/theme.dart';
import '../../../../navigation/app_router.dart';
import '../../../../widget/widget_validation.dart';

class AdminHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String spaceName;
  final String? spaceDomain;
  final String? spaceLogo;
  const AdminHomeAppBar({Key? key, required this.preferredSize, required this.spaceName, this.spaceDomain, this.spaceLogo})
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
              ValidateWidget(
                isValid: spaceLogo.isNotNullOrEmpty,
                child: CachedNetworkImage(
                  imageUrl: spaceLogo ?? "",
                  imageBuilder: (context, imageProvider) => Container(
                    margin: const EdgeInsets.only(right: primaryHorizontalSpacing),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.whiteColor,
                      boxShadow: AppTheme.commonBoxShadow,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: imageProvider),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(spaceName,
                      style: AppFontStyle.titleDark,
                      overflow: TextOverflow.ellipsis),
                  ValidateWidget(
                    isValid: spaceDomain.isNotNullOrEmpty,
                    child: Text(spaceDomain ?? "",
                      style: AppFontStyle.subTitleGrey,
                    ),
                  )
                ],
              ),
              const Spacer(),
              CircleAvatar(
                backgroundColor: const Color(0xfff5f5f5),
                child: IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: AppColors.darkGrey,
                    ),
                    onPressed: () => context.goNamed(Routes.addMember)),
              ),
            ],
          ),
          const SizedBox(height: primaryHalfSpacing),
          const Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}
