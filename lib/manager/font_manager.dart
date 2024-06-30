import 'package:flutter/material.dart';
import 'package:food_app/manager/color_manager.dart';

AppFont appFont = AppFont();

class AppFont {
  final TextStyle f20w500Black = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white);
  final TextStyle f17w500Primary = TextStyle(
      fontSize: 17, fontWeight: FontWeight.w500, color: appColors.brandDark);
  final TextStyle f20w500Primary = TextStyle(
      fontSize: 20, fontWeight: FontWeight.w500, color: appColors.brandDark);
  final TextStyle f12w500Orange = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w500, color: appColors.brandDark);
  final TextStyle f14w500Black =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black);
  final TextStyle f14w500Grey =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey);
  final TextStyle f14w700Orange = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w700, color: appColors.brandDark);
  final TextStyle f16w500White =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white);
  final TextStyle f12w700White =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white);
  final TextStyle f14w700 = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w700, color: appColors.brandDark);
  final TextStyle f10w600Orange40 = const TextStyle(
      fontSize: 10, fontWeight: FontWeight.w600, color: Colors.orange);
  final TextStyle f12w500Grey80 = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.grey.withOpacity(0.8));
  final TextStyle f14w500Orange = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, color: Colors.orange);

  final TextStyle f16w400 = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w400, color: appColors.brandDark);

  final TextStyle f16w700black =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black);
}
