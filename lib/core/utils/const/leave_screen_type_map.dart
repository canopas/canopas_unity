import 'dart:ui';
import '../../../configs/colors.dart';

Color getLeaveContainerColor(int status) {
  if (status == 2) {
    return AppColors.primaryDarkYellow.withAlpha(100);
  } else if (status == 3) {
    return AppColors.lightRed.withAlpha(100);
  }
  return AppColors.lightGreyColor.withAlpha(100);
}
