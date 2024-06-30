import 'package:flutter/material.dart';
import 'package:get/get.dart';

customSnackBar(
    {required String title,
    required String message,
    int? duration,
    bool? isError}) {
  return Get.snackbar(
    title,
    message,
    borderRadius: 20,
    borderWidth: 3,
    backgroundColor: Colors.white.withOpacity(0.7),
    borderColor: isError ?? false ? Colors.red : Colors.black,
    duration: Duration(seconds: duration ?? 2),
    titleText: Center(
        child: Text(
      title,
    )),
    messageText: Center(
        child: Text(
      message,
      textAlign: TextAlign.center,
    )),
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
    colorText: Colors.white,
  );
}
