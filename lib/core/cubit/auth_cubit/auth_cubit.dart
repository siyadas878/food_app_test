import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:food_app/core/models/user_model.dart';
import 'package:food_app/core/repository/auth_repo.dart';
import 'package:get/get.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AuthCubit({required this.authRepo}) : super(AuthInitial());
  userSignUp(UserModel data, BuildContext context, String uid) async {
    emit(UserSignUpLoadingState());
    try {
      await authRepo.registration(user: data, context: context, uid: uid).then(
        (value) {
          // Get.offAllNamed("/Home");
        },
      );
      emit(UserSignUpSuccessState());
    } catch (e) {
      emit(UserSignUpErrorState());
    }
  }

  userSignIn({required String email, required String password}) async {
    emit(UserSigInLoadingState());
    try {
      await authRepo.login(email: email, password: password);
      emit(UserSignInSuccessState());
    } catch (e) {
      emit(UserSignInErrorState());
    }
  }
}
