import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../../../configs/colors.dart';
import '../../../../configs/text_style.dart';

class UpcomingLeaveCard extends StatelessWidget {
  const UpcomingLeaveCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                    style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.greyColor,fontSize: 18),
                  )),
              collapsed: Column(
                children: <Widget>[
                  for (var _ in Iterable.generate(1))
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
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
        ));
  }
}
