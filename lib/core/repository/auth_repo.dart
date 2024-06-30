import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/cubit/user_cubit/user_cubit.dart';
import 'package:food_app/core/models/user_model.dart';
import 'package:food_app/widgets/custom_snackBar.dart';
import 'package:get_storage/get_storage.dart';

class AuthRepo {
  Future<void> registration(
      {required UserModel user,
      required BuildContext context,
      required String uid}) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection('users').doc(uid).set(UserModel(
              email: user.email,
              mobile: user.mobile,
              name: user.name,
              password: user.password,
              uid: uid)
          .toJson());
    } on FirebaseAuthException catch (e) {
      customSnackBar(title: 'Failed', message: e.toString());
    } catch (e) {
      customSnackBar(title: 'Failed', message: 'Something went wrong');
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (value) {
          final box = GetStorage();
          box.write('token', value.credential!.accessToken);
        },
      );
    } on FirebaseAuthException catch (e) {
      customSnackBar(title: 'Failed', message: e.toString());
    } catch (e) {
      customSnackBar(title: 'Failed', message: 'Something went wrong');
    }
  }
}
