import 'package:flutter/material.dart';
import '../../../../configs/colors.dart';

class FilterButton extends StatelessWidget {
  final bool isSelected;
  final void Function()? onPressed;
  final String text;
  const FilterButton({Key? key, required this.isSelected, required this.onPressed, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            elevation: 0,
            fixedSize: const Size.fromHeight(35),
            foregroundColor: (isSelected)?AppColors.primaryBlue:AppColors.secondaryText,
            side: BorderSide(color: (isSelected)?AppColors.primaryBlue:AppColors.secondaryText, width: 1)),
        onPressed: onPressed,
        child: Text(text));
  }
}