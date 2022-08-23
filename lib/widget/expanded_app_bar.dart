import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../configs/colors.dart';

class ExpandedAppBar extends StatelessWidget {
  final Widget content;

  const ExpandedAppBar({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      height: 150,
      decoration: const BoxDecoration(
          color: AppColors.primaryBlue,
          borderRadius:
              BorderRadius.vertical(bottom: Radius.elliptical(200, 10))),
      child: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: content),
      ),
    );
  }
}
