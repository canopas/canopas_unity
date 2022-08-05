import 'package:flutter/material.dart';
import 'package:projectunity/configs/font_size.dart';
import 'package:projectunity/di/service_locator.dart';

import '../../configs/colors.dart';
import '../../pref/user_preference.dart';
import '../../stateManager/login_state_manager.dart';
import '../onboard/onBoarding_contents.dart';


class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;
  final LoginState _loginState = getIt<LoginState>();
  final UserPreference _preference = getIt<UserPreference>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    bool _isLastPage = currentPage + 1 == OnBoardingContents.contents.length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Visibility(
                  visible: !_isLastPage,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, right: 20),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: () {
                            _loginState.setOnBoardComplete(true);
                            _preference.setOnBoardCompleted(true);
                          },
                          child: const Text(
                            'SKIP',
                            style: TextStyle(
                                color: Colors.grey, fontSize: subTitleTextSize),
                          )),
                    ),
                  )),
            ),
            Expanded(
              flex: 8,
              child: PageView.builder(
                itemCount: OnBoardingContents.contents.length,
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        OnBoardingContents.contents[index].image,
                        height: height / 3,
                        width: width,
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              OnBoardingContents.contents[index].title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: onboardTitleTextSize,
                                  fontWeight: FontWeight.w700),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                OnBoardingContents.contents[index].info,
                                style: const TextStyle(
                                    fontSize: bodyTextSize, color: Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(OnBoardingContents.contents.length,
                    (index) => _buildDots(index))),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: AppColors.peachColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                onPressed: () {
                  if (_isLastPage) {
                    _loginState.setOnBoardComplete(true);
                    _preference.setOnBoardCompleted(true);
                  } else {
                    _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease);
                  }
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Text(
                    _isLastPage ? 'START' : 'NEXT',
                    style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: subTitleTextSize),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AnimatedContainer _buildDots(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        color: currentPage == index ? AppColors.peachColor : Colors.grey,
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: currentPage == index ? 20 : 10,
    );
  }
}
