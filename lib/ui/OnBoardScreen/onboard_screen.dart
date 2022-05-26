import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/ui/OnBoardScreen/onBoarding_contents.dart';
import 'package:projectunity/user/user_preference.dart';
import 'package:projectunity/utils/Constant/color_constant.dart';

import '../../Navigation/login_state.dart';

final buttonStyle = ElevatedButton.styleFrom(
    primary: const Color(kPrimaryColour),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)));

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
            Visibility(
                visible: !_isLastPage,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: () {
                          _controller.jumpToPage(2);
                        },
                        child: Text(
                          'SKIP',
                          style: GoogleFonts.ibmPlexSans(
                              color: Colors.grey, fontSize: 17),
                        )),
                  ),
                )),
            Expanded(
              flex: 4,
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
                              style: GoogleFonts.ibmPlexSans(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                OnBoardingContents.contents[index].info,
                                style: GoogleFonts.ibmPlexSans(
                                    fontSize: 14, color: Colors.grey),
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
                style: buttonStyle,
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
                    style: GoogleFonts.ibmPlexSans(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: 17),
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
        color: currentPage == index ? const Color(kPrimaryColour) : Colors.grey,
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: currentPage == index ? 20 : 10,
    );
  }
}
