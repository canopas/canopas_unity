import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../configs/colors.dart';
import '../core/utils/const/other_constant.dart';

class ExpandedAppBar extends StatelessWidget {
  final Widget content;

  const ExpandedAppBar({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: appBarHeight,
      decoration: const BoxDecoration(
          color: AppColors.primaryBlue,
          borderRadius:
              BorderRadius.vertical(bottom: Radius.elliptical(200, 10))),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: content),
    );
  }
}
