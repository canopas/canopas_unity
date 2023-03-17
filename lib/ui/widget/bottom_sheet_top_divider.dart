import 'package:flutter/cupertino.dart';
import '../../configs/colors.dart';
import '../../configs/space_constant.dart';

class BottomSheetTopSlider extends StatelessWidget {
  const BottomSheetTopSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(primaryVerticalSpacing),
          height: 5,
          width: MediaQuery.of(context).size.width * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.primaryGray,
          ),
        ),
      ],
    );
  }
}
