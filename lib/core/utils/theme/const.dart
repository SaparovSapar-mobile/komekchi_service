import 'package:flutter/material.dart';

import 'app_colors.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      color: AppColor.pageBg(context),
      height: 6,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
    );
  }
}
