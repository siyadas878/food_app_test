import 'package:flutter/material.dart';
import 'package:food_app/manager/color_manager.dart';
import 'package:food_app/manager/font_manager.dart';
import 'package:food_app/manager/image_manger.dart';
import 'package:food_app/manager/space_manger.dart';

class GoogleSignInWidget extends StatelessWidget {
  final Function()? ontap;
  const GoogleSignInWidget({
    required this.ontap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: Divider(
                color: appColors.brandDark,
              ),
            ),
            appSpaces.spaceForWidth10,
            Text(
              'OR',
              style: appFont.f14w500Orange,
            ),
            appSpaces.spaceForWidth10,
            SizedBox(
              width: 100,
              child: Divider(
                color: appColors.brandDark,
              ),
            ),
          ],
        ),
        appSpaces.spaceForHeight15,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: ontap,
                child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset(appImages.google))),
          ],
        )
      ],
    );
  }
}
