import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectunity/utils/Constant/image_constant.dart';

class OnBoardScreen1 extends StatefulWidget {
  const OnBoardScreen1({Key? key}) : super(key: key);

  @override
  _OnBoardScreen1State createState() => _OnBoardScreen1State();
}

class _OnBoardScreen1State extends State<OnBoardScreen1> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffffffff),
        body: Stack(
          children: [
            PageView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _controller,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Skip',
                              style: GoogleFonts.ibmPlexSans(
                                  color: Colors.grey, fontSize: 20),
                            )),
                      ),
                    ),
                    ClipRect(
                      child: Image.asset(
                        onBoardScreen1Image,
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        //scale: 0.8,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Bring A Team Together',
                          style: GoogleFonts.ibmPlexSans(
                              fontSize: 35, fontWeight: FontWeight.w700),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Unity is strength..when there is teamwork and collaboration, wonderful things can be achieved.',
                            style: GoogleFonts.ibmPlexSans(
                                fontSize: 16, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              left: 0.0,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: DotsIndicator(
                    controller: _controller,
                    itemCount: 3,
                    onPageSelected: (int page) {
                      _controller.animateToPage(page,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
