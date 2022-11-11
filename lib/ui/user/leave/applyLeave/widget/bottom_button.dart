import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';
import 'package:projectunity/widget/error_snackbar.dart';

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
    var localization = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: primaryHorizontalSpacing),
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
                          msg: localization.user_apply_leave_success_message);
                    });
                  }
                  return Container();
                },
                orElse: () {
                  return Container();
                });
            return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize:  Size(MediaQuery.of(context).size.width, 50),
                    elevation: 2
                ),
                onPressed: onPress,
                child: Text(
                    localization.user_apply_leave_button_apply_leave,
                    style: AppTextStyle.subtitleTextWhite));
          }),
    );
  }
}
