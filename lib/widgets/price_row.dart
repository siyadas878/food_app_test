import 'package:flutter/material.dart';
import 'package:food_app/manager/font_manager.dart';

class InvoiceRow extends StatelessWidget {
  final String title;
  final String price;
  const InvoiceRow({super.key, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: appFont.f14w500Grey,
        ),
        const Spacer(),
        Text(
          "₹ $price",
          style: appFont.f16w700black,
        ),
      ],
    );
  }
}
