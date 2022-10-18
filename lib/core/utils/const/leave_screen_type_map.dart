import 'dart:ui';

import '../../../configs/colors.dart';

//Leave screen type: To navigate to individual screen
const int allLeaves = 1;
const int requestedLeave = 2;
const int upcomingLeave = 3;

Color getLeaveContainerColor(int status) {
  if (status == 2) {
    return AppColors.primaryDarkYellow;
  } else if (status == 3) {
    return AppColors.blackColor;
  }
  return AppColors.lightGreyColor;
}
