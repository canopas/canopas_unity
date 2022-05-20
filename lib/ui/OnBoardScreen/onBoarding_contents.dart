import '../../utils/Constant/image_constant.dart';

class OnBoardingContents {
  String title;
  String image;
  String info;

  OnBoardingContents(
      {required this.title, required this.image, required this.info});

  static List<OnBoardingContents> contents = [
    OnBoardingContents(
        title: 'Bring A Team Together',
        image: onBoardScreen1Image,
        info:
            'Unity is strength..when there is teamwork and collaboration, wonderful things can be achieved.'),
    OnBoardingContents(
        title: 'Stay organized with Team',
        image: onboardScreen2Image,
        info:
            'but understanding the contributions our colleagues make to our companies and teams.'),
    OnBoardingContents(
        title: 'Create & Organize your Workspace',
        image: onBoardScreen3Image,
        info:
            'A digital workspace that helps you to visually organize ideas, to map any content & to share inspiration.'),
  ];
}
