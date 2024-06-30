import 'package:flutter/material.dart';
import 'package:food_app/manager/font_manager.dart';

class EmptyText extends StatelessWidget {
  final String title;
  const EmptyText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: appFont.f14w700Orange,
      ),
    );
  }
}
