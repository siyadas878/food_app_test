import 'package:flutter/material.dart';

class DetailTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? subtitle;
  const DetailTile(
      {super.key, required this.icon, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle == null ? null : subtitle,
    );
  }
}
