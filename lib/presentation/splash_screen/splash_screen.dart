import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/manager/color_manager.dart';
import 'package:food_app/manager/font_manager.dart';
import 'package:food_app/manager/space_manger.dart';
import 'package:food_app/utils/get_dimension.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    splashFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.restaurant_rounded,
          size: 50,
          color: appColors.brandDark,
        ),
        appSpaces.spaceForHeight15,
        Text(
          'Food App',
          style: appFont.f20w500Primary,
          maxLines: 2,
          textAlign: TextAlign.center,
        )
      ],
    )));
  }

  splashFunction() async {
    Future.delayed(const Duration(seconds: 5)).then((value) {
      final box = GetStorage();
      var token = box.read('token');
      var uid = box.read('user');
      print('token=====================${token.toString()}');
      print('uid=====================${uid.toString()}');
      if (token == null) {
        Get.offAllNamed("/LoginScreen");
      } else {
        Get.offAllNamed("/Home");
      }
    });
  }
}
