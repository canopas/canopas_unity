import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';

class OrgFormDropDownButton<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>>? items;
  final void Function(T?)? onChanged;

  const OrgFormDropDownButton(
      {super.key, this.value, this.items, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 150,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: context.colorScheme.outlineColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          iconSize: 0.0,
          icon: const SizedBox(),
          borderRadius: BorderRadius.circular(5),
          alignment: Alignment.center,
          value: value,
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
