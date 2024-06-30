import 'package:flutter/material.dart';
import 'package:food_app/manager/color_manager.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: appColors.appGrey,
        color: appColors.brandDark,
      ),
    );
  }
}
