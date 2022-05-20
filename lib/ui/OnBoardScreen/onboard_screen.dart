import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectunity/ui/OnBoardScreen/onBoarding_contents.dart';
import 'package:projectunity/utils/Constant/color_constant.dart';

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
                    onPressed: () {
                      _controller.jumpToPage(2);
                    },
                    child: Text(
                      'Skip',
                      style: GoogleFonts.ibmPlexSans(
                          color: Colors.grey,
                          fontSize: (height >= 850) ? 22 : 17),
                    )),
              ),
            ),
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
                                  fontSize: (height >= 750) ? 35 : 25,
                                  fontWeight: FontWeight.w700),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                OnBoardingContents.contents[index].info,
                                style: GoogleFonts.ibmPlexSans(
                                    fontSize: (height >= 750) ? 17 : 14,
                                    color: Colors.grey),
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
            Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(OnBoardingContents.contents.length,
                        (index) => _buildDots(index)))),
            currentPage + 1 == OnBoardingContents.contents.length
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(
                      width: width / 2,
                      child: ElevatedButton(
                        style: buttonStyle,
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Start',
                            style: GoogleFonts.ibmPlexSans(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                                fontSize: (height >= 700) ? 22 : 17),
                          ),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(
                      width: width / 4,
                      child: ElevatedButton(
                        style: buttonStyle,
                        onPressed: () {
                          _controller.jumpToPage(currentPage + 1);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Next',
                                style: GoogleFonts.ibmPlexSans(
                                    fontWeight: FontWeight.w500,
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
