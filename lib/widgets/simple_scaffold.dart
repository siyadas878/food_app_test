import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../manager/color_manager.dart';
import '../manager/font_manager.dart';

class SimpleScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? bottomWidget;
  final Widget? bottomNavBar;
  final bool? hideBack;
  final Function()? onBack;
  const SimpleScaffold(
      {super.key,
      required this.title,
      required this.body,
      this.bottomWidget,
      this.bottomNavBar,
      this.onBack,
      this.hideBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        //elevation: 5,
        shadowColor: Colors.grey,
        leading: hideBack ?? false
            ? const SizedBox()
            : CustomBackButton(
                onTap: () {
                  if (onBack != null) {
                    onBack!();
                  } else {
                    Get.back();
                  }
                },
              ),
        title: Text(
          title,
          style: appFont.f16w500White,
        ),
        centerTitle: true,
      ),
      body: body,
      bottomSheet: bottomWidget,
      bottomNavigationBar: bottomNavBar,
    );
  }
}

class CustomBackButton extends StatelessWidget {
  final Function() onTap;
  const CustomBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 10,
        width: 10,
        margin: const EdgeInsets.all(14),
        padding: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: appColors.appGrey)),
        child: Icon(
          Icons.arrow_back_ios,
          color: appColors.brandDark,
          size: 18,
        ),
      ),
    );
  }
}
