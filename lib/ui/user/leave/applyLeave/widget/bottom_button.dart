import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';
import 'package:projectunity/widget/error_snackbar.dart';

import '../../../../../configs/colors.dart';




class ApplyButton extends StatelessWidget {
  const ApplyButton({
    Key? key,
    required this.stream,
    required this.onPress,
  }) : super(key: key);

  final Stream<ApiResponse<bool>> stream;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    var _localization = AppLocalizations.of(context);
    return Expanded(
        flex: 2,
        child: StreamBuilder<ApiResponse<bool>>(
            initialData: const ApiResponse.idle(),
            stream: stream,
            builder: (context, snapshot) {
              snapshot.data!.maybeWhen(
                  loading: () => const kCircularProgressIndicator(),
                  completed: (bool success) {
                    if (success) {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        showSnackBar(
                            context: context,
                            msg:
                                _localization.user_apply_leave_success_message);
                      });
                    }
                    return Container();
                  },
                  orElse: () {
                    return Container();
                  });
              return ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                        _localization.user_apply_leave_button_apply_leave,
                        style: AppTextStyle.leaveRequestBottomBarTextStyle),
                  ),
                  onPressed: onPress);
              ;
            }));
  }
}

class ResetButton extends StatelessWidget {
  final VoidCallback onPress;

  const ResetButton({
    Key? key,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _localization = AppLocalizations.of(context);
    return Expanded(
      flex: 1,
      child: ElevatedButton(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(_localization.user_apply_leave_button_reset,
              style: AppTextStyle.leaveRequestBottomBarTextStyle),
        ),
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryText,
        ),
      ),
    );
  }
}
