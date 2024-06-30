import 'package:flutter/material.dart';
import 'package:food_app/manager/font_manager.dart';
import 'package:food_app/manager/space_manger.dart';
import 'package:food_app/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

logoutPopup({required BuildContext context}) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 50,
        child: Center(
            child: SizedBox(
                width: 150,
                child: Center(
                  child: SizedBox(
                      child: Text(
                    'Are you sure to Logout',
                    textAlign: TextAlign.center,
                    style: appFont.f16w700black,
                  )),
                ))),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              title: 'Back',
              onTap: () async {
                Get.back();
              },
            ),
            appSpaces.spaceForWidth5,
            CustomButton(
                delete: true,
                title: 'Logout',
                onTap: () async {
                  final box = GetStorage();
                  box.remove('token').then(
                    (value) async {
                      await GoogleSignIn().signOut();
                      box.remove('user');
                      Get.offAllNamed('/LoginScreen');
                    },
                  );
                }),
          ],
        )
      ],
    ),
  );
}
