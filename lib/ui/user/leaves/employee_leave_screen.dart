import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/configs/text_style.dart';

class UserLeavePage extends StatelessWidget {
  const UserLeavePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class UserLeaveScreen extends StatefulWidget {
  const UserLeaveScreen({Key? key}) : super(key: key);

  @override
  State<UserLeaveScreen> createState() => _UserLeaveScreenState();
}

class _UserLeaveScreenState extends State<UserLeaveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          title: Text(
            'Leaves',
            style: AppFontStyle.appbarHeaderStyle,
          ),
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {},
                child: const Text('Apply', style: AppFontStyle.buttonTextStyle))
          ],
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 110,
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.lightGreyColor, //New
                        blurRadius: 5.0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: AppColors.lightGreyColor, width: 3)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircularPercentIndicator(
                        radius: MediaQuery.of(context).size.width * 0.085,
                        animation: true,
                        animationDuration: 1200,
                        lineWidth: 15.0,
                        percent: 0.4,
                        circularStrokeCap: CircularStrokeCap.butt,
                        backgroundColor: AppColors.lightGreyColor,
                        progressColor: AppColors.redColor,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '4/12',
                            style: AppFontStyle.titleTextStyle,
                          ),
                          Text(
                            "Used Leaves",
                            style: AppFontStyle.subTitleTextStyle,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Divider(
              indent: 10,
              endIndent: 10,
            ),
            ExpandableNotifier(
                child: Padding(
              padding: const EdgeInsets.all(10),
              child: ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Upcoming leaves",
                        style: AppFontStyle.subTitleTextStyle,
                      )),
                  collapsed: Column(
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 70,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('3 days Application',
                                          style: TextStyle(
                                              color: AppColors.greyColor,
                                              fontWeight: FontWeight.w500)),
                                      Text('Wed, 10 Dec',
                                          style: TextStyle(
                                              color: AppColors.blackColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                        'Casual',
                                        style: TextStyle(
                                            color: AppColors.primaryDarkYellow),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.error,
                                        color: AppColors.secondaryText,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Rejected',
                                        style: AppTextStyle.bodyTextDark,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        for (var _ in Iterable.generate(5))
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 70,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('3 days Application',
                                            style: TextStyle(
                                                color: AppColors.greyColor,
                                                fontWeight: FontWeight.w500)),
                                        Text('Wed, 10 Dec',
                                            style: TextStyle(
                                                color: AppColors.blackColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                          'Casual',
                                          style: TextStyle(
                                              color:
                                                  AppColors.primaryDarkYellow),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.error,
                                          color: AppColors.secondaryText,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Rejected',
                                          style: AppTextStyle.bodyTextDark,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        // ListTile(title: Text('List of Item $_'),)],
                      ]),
                  builder: (_, collapsed, expanded) {
                    return Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    );
                  },
                ),
              ),
            )),
            ExpandableNotifier(
                child: Padding(
              padding: const EdgeInsets.all(10),
              child: ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Past leaves",
                        style: AppFontStyle.subTitleTextStyle,
                      )),
                  collapsed: Column(
                    children: <Widget>[
                      for (var _ in Iterable.generate(2))
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 70,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      Text('3 days Application',
                                          style: TextStyle(
                                              color: AppColors.greyColor,
                                              fontWeight: FontWeight.w500)),
                                      Text('Wed, 10 Dec',
                                          style: TextStyle(
                                              color: AppColors.blackColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                        'Casual',
                                        style: TextStyle(
                                            color: AppColors.primaryDarkYellow),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.error,
                                        color: AppColors.secondaryText,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Rejected',
                                        style: AppTextStyle.bodyTextDark,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(5))
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 70,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('3 days Application',
                                          style: TextStyle(
                                              color: AppColors.greyColor,
                                              fontWeight: FontWeight.w500)),
                                      Text('Wed, 10 Dec',
                                          style: TextStyle(
                                              color: AppColors.blackColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                        'Casual',
                                        style: TextStyle(
                                            color: AppColors.primaryDarkYellow),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.error,
                                        color: AppColors.secondaryText,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Rejected',
                                        style: AppTextStyle.bodyTextDark,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    );
                  },
                ),
              ),
            ))
          ],
        ));
  }
}
