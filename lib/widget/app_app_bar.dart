import 'package:flutter/material.dart';
import '../configs/colors.dart';
import '../configs/text_style.dart';
import '../core/utils/const/space_constant.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  @override
  final Size preferredSize;
  final double bottomTitlePadding;
  final List<Widget> actions;

  const AppAppBar({
    Key? key,
    this.title = "",
    this.actions = const [],
    this.preferredSize = const Size(double.infinity, 120),
    this.bottomTitlePadding = primaryVerticalSpacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(primaryHorizontalSpacing).copyWith(bottom: 0),
      height: preferredSize.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: AppTextStyle.headerDark,
              ),
              const Spacer(),
              ...actions
            ],
          ),
          SizedBox(
            height: bottomTitlePadding,
          ),
          const Divider(
            color: AppColors.dividerColor,
            height: 1,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
