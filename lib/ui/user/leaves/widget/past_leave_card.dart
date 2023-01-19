import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../configs/colors.dart';
import '../../../../configs/text_style.dart';

class PastLeaveCard extends StatelessWidget {
  const PastLeaveCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: ScrollOnExpand(
          scrollOnExpand: true,
          scrollOnCollapse: false,
          child: ExpandablePanel(
            theme: const ExpandableThemeData(
              headerAlignment: ExpandablePanelHeaderAlignment.center,
              tapBodyToCollapse: true,
            ),
            header:  Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Past leaves",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                    ),
                    IconButton(onPressed: (){}, icon: Icon(Icons.filter_list_outlined),color: AppColors.greyColor,)
                  ],
                )),
            collapsed: Column(
              children: <Widget>[
                for (var _ in Iterable.generate(2))
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
                              children: const [
                                Text('3 days Application',
                                    style: TextStyle(
                                        color: AppColors.greyColor,
                                        fontWeight: FontWeight.w500)),
                                Text('Wed, 10 Dec',
                                    style: TextStyle(
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
            builder: (_, collapsed, expanded) {
              return Expandable(
                collapsed: collapsed,
                expanded: expanded,
                theme: const ExpandableThemeData(crossFadePoint: 0),
              );
            },
          ),
        ));
  }
}
