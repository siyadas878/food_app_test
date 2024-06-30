import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/cubit/user_cubit/user_cubit.dart';
import 'package:food_app/manager/font_manager.dart';
import 'package:food_app/manager/image_manger.dart';
import 'package:food_app/manager/space_manger.dart';
import 'package:food_app/utils/logout_popup.dart';
import 'package:food_app/widgets/custom_button.dart';
import 'package:food_app/widgets/loading.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        elevation: 5,
        shadowColor: Colors.grey,
        centerTitle: true,
        title: Text(
          'Profile',
          style: appFont.f16w500White,
        ),
        actions: [
          IconButton(
              onPressed: () {
                logoutPopup(context: context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is SingleUsersLoadingState) {
            return const LoadingWidget();
          } else if (state is SingleUsersSuccessState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage(appImages.user),
                  ),
                  appSpaces.spaceForHeight10,
                  Text(
                    state.user.name ?? 'Name',
                    style: appFont.f14w500Orange,
                  ),
                  appSpaces.spaceForHeight10,
                  Text(
                    state.user.email ?? 'Email',
                    style: appFont.f14w500Orange,
                  ),
                  appSpaces.spaceForHeight10,
                  CustomButton(
                      onTap: () {
                        logoutPopup(context: context);
                      },
                      title: 'Logout')
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                'Error',
                style: appFont.f14w500Orange,
              ),
            );
          }
        },
      ),
    );
  }
}
