import 'package:flutter/material.dart';
import '../../../../configs/text_style.dart';
import '../../../../core/utils/const/space_constant.dart';

class FilterTitle extends StatelessWidget {
  final String text;
  const FilterTitle({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: primaryVerticalSpacing,top: primaryHorizontalSpacing),
        child: Text(text,style: AppTextStyle.titleBlack600, textAlign: TextAlign.left,));
  }
}