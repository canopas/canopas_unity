import 'dart:ui';
import '../../../configs/colors.dart';

Color getLeaveContainerColor(int status) {
  if (status == 2) {
    return AppColors.primaryDarkYellow;
  } else if (status == 3) {
    return AppColors.lightRed;
  }
  return AppColors.lightGreyColor;
}
