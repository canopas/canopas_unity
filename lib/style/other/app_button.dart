import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';

import '../../ui/widget/circular_progress_indicator.dart';
import '../app_text_style.dart';

class AppButton extends StatelessWidget {
  final String? tag;
  final VoidCallback? onTap;
  final bool loading;
  final Widget? child;
  final Color? backgroundColor;

  const AppButton({
    super.key,
    this.tag,
    this.onTap,
    this.loading = false,
    this.child,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? context.colorScheme.primary,
        fixedSize: Size(MediaQuery.of(context).size.width, 50),
        elevation: 2,
      ),
      onPressed: onTap,
      child: loading
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: FittedBox(
                child: AppCircularProgressIndicator(
                  color: context.colorScheme.surface,
                ),
              ),
            )
          : Center(
              child:
                  child ??
                  Text(
                    tag ?? '',
                    style: AppTextStyle.style14.copyWith(
                      color: context.colorScheme.surface,
                    ),
                  ),
            ),
    );
  }
}
