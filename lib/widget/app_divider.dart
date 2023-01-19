import 'package:flutter/material.dart';
import '../configs/colors.dart';
import '../core/utils/const/space_constant.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
        color: AppColors.dividerColor,
        indent: primaryHorizontalSpacing,
        endIndent: primaryHorizontalSpacing,
        thickness: 1,
        height: 1);
  }
}