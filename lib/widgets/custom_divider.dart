import 'package:flutter/material.dart';
import 'package:food_app/manager/color_manager.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: appColors.appGrey,
    );
  }
}
