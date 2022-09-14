import 'package:flutter/material.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../core/utils/const/image_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class EmptyAbsenceScreen extends StatefulWidget {
  const EmptyAbsenceScreen({Key? key}) : super(key: key);

  @override
  State<EmptyAbsenceScreen> createState() => _EmptyAbsenceScreenState();
}

class _EmptyAbsenceScreenState extends State<EmptyAbsenceScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           const Image(
            image: AssetImage(emptyLeaveStateImage),
            height: 100,
            width: 100,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(AppLocalizations.of(context).empty_absence_state_message,
            textAlign: TextAlign.center,
            style: AppTextStyle.secondarySubtitle500,),
        ],
      ),
    );
  }
}
