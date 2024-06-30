import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/cubit/auth_cubit/auth_cubit.dart';
import 'package:food_app/core/cubit/cart_cubit/cart_cubit.dart';
import 'package:food_app/core/cubit/restaurant_cubit/restaurant_cubit.dart';
import 'package:food_app/core/cubit/user_cubit/user_cubit.dart';
import 'package:food_app/core/repository/auth_repo.dart';
import 'package:food_app/core/repository/cart_repo.dart';
import 'package:food_app/core/repository/restaurant_repo.dart';
import 'package:food_app/core/repository/user_repo.dart';
import 'package:food_app/manager/color_manager.dart';
import 'package:food_app/manager/route_manager.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => RestaurantRepo()),
        RepositoryProvider(create: (context) => AuthRepo()),
        RepositoryProvider(create: (context) => CartRepo()),
        RepositoryProvider(create: (context) => UserRepo()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => RestaurantCubit(
                  restaurantRepo: context.read<RestaurantRepo>())),
          BlocProvider(
              create: (context) =>
                  AuthCubit(authRepo: context.read<AuthRepo>())),
          BlocProvider(
              create: (context) =>
                  CartCubit(cartRepo: context.read<CartRepo>())),
          BlocProvider(
              create: (context) =>
                  UserCubit(userRepo: context.read<UserRepo>())),
        ],
        child: GetMaterialApp(
          title: 'food app',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(color: appColors.brandDark),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
            useMaterial3: true,
          ),
          initialRoute: '/',
          getPages: appRoute(),
        ),
      ),
    );
  }
}
