import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/manager/font_manager.dart';
import 'package:food_app/manager/image_manger.dart';
import 'package:food_app/manager/space_manger.dart';
import 'package:food_app/utils/get_dimension.dart';
import 'package:food_app/widgets/custom_button.dart';
import 'package:get/get.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: screenHeight(context) * 0.15,
              width: screenHeight(context) * 0.15,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(appImages.success),
              )),
            ),
            appSpaces.spaceForHeight15,
            Text(
              'Payment Sccessful',
              style: appFont.f14w700Orange,
            )
          ],
        ),
      ),
      bottomSheet: SizedBox(
        height: 80,
        child: CustomButton(
            verticalPadding: 0,
            onTap: () async {
              Get.offNamed('/Home');
            },
            maxWidth: true,
            title: "Got to Home"),
      ),
    );
  }
}
