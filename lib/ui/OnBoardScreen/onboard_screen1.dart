import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectunity/utils/Constant/color_constant.dart';
import 'package:projectunity/utils/Constant/image_constant.dart';

class OnBoardScreen1 extends StatefulWidget {
  const OnBoardScreen1({Key? key}) : super(key: key);

  @override
  _OnBoardScreen1State createState() => _OnBoardScreen1State();
}

class _OnBoardScreen1State extends State<OnBoardScreen1> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Skip',
                      style: GoogleFonts.ibmPlexSans(
                          color: Colors.grey,
                          fontSize: (height >= 850) ? 22 : 17),
                    )),
              ),
            ),
            Expanded(
              flex: 3,
              child: PageView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _controller,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRect(
                        child: Image.asset(
                          onBoardScreen1Image,
                          width: width,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              'Bring A Team Together',
                              style: GoogleFonts.ibmPlexSans(
                                  color: Colors.black54,
                                  fontSize: (height >= 700) ? 35 : 25,
                                  fontWeight: FontWeight.w700),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'Unity is strength..when there is teamwork and collaboration, wonderful things can be achieved.',
                                style: GoogleFonts.ibmPlexSans(
                                    fontSize: (height >= 700) ? 17 : 13,
                                    color: Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMainDots(),
                _buildDots(),
                _buildDots(),
              ],
            )),
            Padding(
              padding: EdgeInsets.only(bottom: height / 50),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color(kPrimaryColour),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Next',
                          style: GoogleFonts.ibmPlexSans(
                              fontWeight: FontWeight.w400,
                              color: Colors.black54,
                              fontSize: (height >= 700) ? 22 : 17),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          size: 17,
                          color: Colors.black54,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

AnimatedContainer _buildMainDots() {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      color: Color(kPrimaryColour),
    ),
    margin: const EdgeInsets.only(right: 5),
    height: 10,
    curve: Curves.easeIn,
    width: 20,
  );
}

AnimatedContainer _buildDots() {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      color: Colors.grey,
    ),
    margin: const EdgeInsets.only(right: 5),
    height: 10,
    curve: Curves.easeIn,
    width: 10,
  );
}

// Positioned(
// bottom: 0.0,
// right: 0.0,
// left: 0.0,
// child: Padding(
// padding: const EdgeInsets.all(30),
// child: DotsIndicator(
// controller: _controller,
// itemCount: 3,
// onPageSelected: (int page) {
// _controller.animateToPage(page,
// duration: const Duration(milliseconds: 300),
// curve: Curves.ease);
// }),
// ),
// ),

class DotsIndicator extends AnimatedWidget {
  final PageController controller;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  final Color color;

  const DotsIndicator(
      {required this.controller,
      required this.itemCount,
      required this.onPageSelected,
      this.color = Colors.grey,
      Key? key})
      : super(listenable: controller, key: key);
  static const double _kDotSize = 8.0;
  static const double _kMaxZoom = 2.0;

  Widget buildDot(int index) {
    double selectedness = Curves.easeOut.transform(max(0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs()));
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return SizedBox(
      width: 25,
      child: Center(
        child: Material(
          color: color,
          type: MaterialType.circle,
          child: SizedBox(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, buildDot),
    );
  }
}
