import 'package:flutter/material.dart';
import 'package:projectunity/data/l10n/app_localization.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
import '../../../data/di/service_locator.dart';
import '../../../data/provider/user_state.dart';

class PageNotFoundScreen extends StatefulWidget {
  const PageNotFoundScreen({super.key});

  @override
  State<PageNotFoundScreen> createState() => _PageNotFoundScreenState();
}

class _PageNotFoundScreenState extends State<PageNotFoundScreen> {
  final userStateNotifier = getIt<UserStateNotifier>();

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
                    style: TextStyle(
                        color: context.colorScheme.primary,
                        fontSize: 50,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(locale.page_not_found_error_title,
                    style: AppTextStyle.style20.copyWith(
                        fontWeight: FontWeight.w700,
                        color: context.colorScheme.textPrimary)),
                const SizedBox(height: 10),
                Text(locale.page_not_found_error_message,
                    style: AppTextStyle.style18
                        .copyWith(color: context.colorScheme.textPrimary),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
