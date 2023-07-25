import 'package:flutter/material.dart';
import 'package:projectunity/data/configs/colors.dart';
import 'package:projectunity/data/configs/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../data/di/service_locator.dart';
import '../../../data/provider/user_status_notifier.dart';

class PageNotFoundScreen extends StatefulWidget {
  const PageNotFoundScreen({Key? key}) : super(key: key);

  @override
  State<PageNotFoundScreen> createState() => _PageNotFoundScreenState();
}

class _PageNotFoundScreenState extends State<PageNotFoundScreen> {
  final userStateNotifier = getIt<UserStatusNotifier>();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Text(locale.page_not_found_error_code,
                    style: const TextStyle(
                        color: AppColors.primaryBlue,
                        fontSize: 50,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                 Text(locale.page_not_found_error_title,
                    style: AppFontStyle.titleDark),
                const SizedBox(height: 10),
                 Text(
                    locale.page_not_found_error_message,
                    style: AppFontStyle.subTitleGrey,
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
