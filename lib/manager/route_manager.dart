import 'package:food_app/presentation/home.dart';
import 'package:food_app/presentation/home_screen/home_screen.dart';
import 'package:food_app/presentation/login/login_screen.dart';
import 'package:food_app/presentation/otp_screen/otp_screen.dart';
import 'package:food_app/presentation/registration/registration_screen.dart';
import 'package:food_app/presentation/splash_screen/splash_screen.dart';
import 'package:food_app/presentation/success_screen/success_screen.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>> appRoute() {
  return [
    GetPage(
      name: "/",
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: "/HomeScreen",
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: "/Home",
      page: () => const Home(),
    ),
    GetPage(
      name: "/LoginScreen",
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: "/RegisterScreen",
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: "/SuccessScreen",
      page: () => const SuccessScreen(),
    ),
    GetPage(
      name: "/otpScreen",
      page: () => OTPScreen(
        isLogin: Get.arguments['isLogin'],
        userData: Get.arguments['data'],
      ),
    ),
  ];
}
