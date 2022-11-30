import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/di/service_locator.dart';
import '../../configs/colors.dart';
import '../../configs/text_style.dart';
import '../onboard/onBoarding_contents.dart';
import 'bloc/onboard_bloc.dart';
import 'bloc/onboard_event.dart';

class OnBoardScreenBlocProvider extends StatelessWidget {
  const OnBoardScreenBlocProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OnBoardBloc>(),
      child: const OnBoardScreen(),
    );
  }
}


class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<OnBoardingContents> onBoardContents =
        OnBoardingContents.contents(context);

    bool isLastPage = context.watch<OnBoardBloc>().state + 1 == onBoardContents.length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Visibility(
                  visible: !isLastPage,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: () {
                          context.read<OnBoardBloc>().add(SetOnBoardCompletedEvent());
                        },
                        child: Text(
                          AppLocalizations.of(context).onBoard_skip_button,
                            style: AppTextStyle.subtitleText.copyWith(color: AppColors.secondaryText)
                        )),
                  )),
            ),
            Expanded(
              flex: 8,
              child: PageView.builder(
                itemCount: onBoardContents.length,
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _controller,
                onPageChanged: (index) {
                  context.read<OnBoardBloc>().add(CurrentPageChangeEvent(page: index));
                },
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        onBoardContents[index].image,
                        height: height / 3,
                        width: width,
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              onBoardContents[index].title,
                              textAlign: TextAlign.center,
                              style: AppTextStyle.onBoardTitle
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(onBoardContents[index].info,
                                  style: AppTextStyle.secondaryBodyText,
                                  textAlign: TextAlign.center),
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
                children: List.generate(
                    onBoardContents.length, (index) => OnBoardPageDotsIndicator(pageIndex: index,))),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.peachColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                onPressed: () {
                  if (isLastPage) {
                    context.read<OnBoardBloc>().add(SetOnBoardCompletedEvent());
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
                    isLastPage
                        ? AppLocalizations.of(context).onBoard_start_button
                        : AppLocalizations.of(context).onBoard_next_button,
                    style: AppTextStyle.onBoardButton,
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

class OnBoardPageDotsIndicator extends StatelessWidget {
  final int pageIndex;
  const OnBoardPageDotsIndicator({Key? key, required this.pageIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardBloc,int>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          color: state == pageIndex ? AppColors.peachColor : Colors.grey,
        ),
        margin: const EdgeInsets.only(right: 5),
        height: 10,
        curve: Curves.easeIn,
        width: state == pageIndex ? 20 : 10,
      ),
    );
  }
}

