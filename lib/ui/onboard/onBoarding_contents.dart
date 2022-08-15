import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../core/utils/const/image_constant.dart';

class OnBoardingContents {
  String title;
  String image;
  String info;

  OnBoardingContents(
      {required this.title, required this.image, required this.info});

  static List<OnBoardingContents> contents(BuildContext context) {
    return [
      OnBoardingContents(
          title: AppLocalizations.of(context).onBoard_screen1_title,
          image: onBoardScreen1Image,
          info: AppLocalizations.of(context).onBoard_screen1_description),
      OnBoardingContents(
          title: AppLocalizations.of(context).onBoard_screen2_title,
          image: onboardScreen2Image,
          info: AppLocalizations.of(context).onBoard_screen2_description),
      OnBoardingContents(
          title: AppLocalizations.of(context).onBoard_screen3_title,
          image: onboardScreen3Image,
          info: AppLocalizations.of(context).onBoard_screen3_description),
    ];
  }
}
