import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/core/models/user_model.dart';
import 'package:food_app/manager/space_manger.dart';
import 'package:food_app/utils/get_dimension.dart';
import 'package:food_app/widgets/google_signin.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../manager/font_manager.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textField.dart';
import '../../widgets/simple_scaffold.dart';
import '../registration/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleScaffold(
      hideBack: true,
      title: "Login",
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login With Mobile Number',
                style: appFont.f14w700Orange,
              ),
              SizedBox(
                height: screenHeight(context) * 0.06,
              ),
              CustomTextField(
                  isNumberOnly: true,
                  controller: phoneController,
                  verticalPadding: 10,
                  floatingTitle: "Phone Number",
                  hint: "Enter Phone Number",
                  icon: Icons.phone,
                  validator: (number) {
                    if (number.toString() == "") {
                      return "Please Enter Number";
                    } else if (phoneController.text.length != 10) {
                      return 'Mobile Number must be of 10 digits';
                    } else {
                      // userPhoneNumber = number;
                      return null;
                    }
                  }),
              appSpaces.spaceForHeight15,
              CustomButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Get.toNamed("/otpScreen", arguments: {
                        'isLogin': true,
                        'data': UserModel(
                            email: '',
                            mobile: phoneController.text,
                            name: '',
                            password: '')
                      });
                    }
                  },
                  title: "Login"),
              appSpaces.spaceForHeight10,
              GoogleSignInWidget(
                ontap: () async {
                  await GoogleSignIn().signOut();

                  await signInWithGoogle().then((value) async {
                    final FirebaseFirestore firestore =
                        FirebaseFirestore.instance;

                    final box = GetStorage();
                    box.write('token', value.credential!.accessToken);
                    box.write('user', value.user!.uid);
                    Get.offAllNamed('/Home');
                    await firestore
                        .collection('users')
                        .doc(value.user!.uid)
                        .set(UserModel(
                                email: value.user!.email,
                                mobile: value.user!.phoneNumber ?? '',
                                name: value.user!.displayName ?? '',
                                password: '',
                                uid: value.user!.uid)
                            .toJson());
                  });
                },
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 35.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed("/RegisterScreen");
                        },
                        child: RichText(
                            text: TextSpan(
                                style: appFont.f14w500Black,
                                text: "Don’t have an account?  ",
                                children: [
                              TextSpan(
                                  style: appFont.f14w700Orange,
                                  text: "Register")
                            ])),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
