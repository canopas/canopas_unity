import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ui/user/leaves/apply_leave/bloc/apply_leave_bloc.dart';
import '../../ui/widget/circular_progress_indicator.dart';
import '../app_text_style.dart';
import '../colors.dart';

class AppButton extends StatelessWidget {
  final String? tag;
  final VoidCallback? onTap;
  final bool loading;
  final Widget? child;

  const AppButton(
      {Key? key,  this.tag, this.onTap, this.loading = false, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: primaryLightColor,
                fixedSize: Size(MediaQuery.of(context).size.width, 50),
                elevation: 2),
            onPressed: onTap,
            child: loading
                ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: FittedBox(child: AppCircularProgressIndicator(
                    color: surfaceColor,
                  )),
                )
                :Center(
                  child: child?? Text(tag??'',
                      style:
                          AppTextStyle.style14.copyWith(color: surfaceColor)),
                ));
  }
}
