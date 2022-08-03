import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../configs/colors.dart';
import '../configs/font_size.dart';

Widget buildFieldColumn({required String title, required String value}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildTitle(title: title),
      const SizedBox(
        height: 5,
      ),
      _buildValue(value: value),
    ],
  );
}

Text _buildValue({required String value}) {
  return Text(
    value,
    style: const TextStyle(
      color: AppColors.darkText,
      fontSize: subTitleTextSize,
    ),
  );
}

Text _buildTitle({required String title}) {
  return Text(
    title,
    style: const TextStyle(
      color: AppColors.secondaryText,
      fontSize: bodyTextSize,
    ),
  );
}

Widget buildDivider() {
  return Column(
    children: const [
      SizedBox(
        height: 10,
      ),
      Divider(
        color: AppColors.lightGreyColor,
      ),
      SizedBox(
        height: 10,
      ),
    ],
  );
}
