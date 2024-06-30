import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/manager/color_manager.dart';
import 'package:food_app/presentation/cart_screen/cart_screen.dart';
import 'package:food_app/presentation/home_screen/home_screen.dart';
import 'package:food_app/presentation/profile_screen/profile_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  int activeIndex = 0;
  List<Widget> pages = [
    const HomeScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages.elementAt(activeIndex),
        bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: appColors.brandDark,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          selectedItemColor: appColors.brandDark,
          currentIndex: activeIndex,
          onTap: (value) {
            setState(() {
              activeIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: ""),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.cart), label: ""),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person), label: ""),
          ],
        ));
  }
}
