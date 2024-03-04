import 'package:flutter/cupertino.dart';
import '../../data/configs/colors.dart';
import '../../data/configs/space_constant.dart';

class BottomSheetTopSlider extends StatelessWidget {
  const BottomSheetTopSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(primaryVerticalSpacing),
      height: 5,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primaryGray,
      ),
    );
  }
}
