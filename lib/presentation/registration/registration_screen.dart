import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_app/core/models/user_model.dart';
import 'package:food_app/manager/space_manger.dart';
import 'package:food_app/widgets/google_signin.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../manager/font_manager.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textField.dart';
import '../../widgets/simple_scaffold.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String userName = "";
  String linkCode = "";
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    passwordController.clear();
    super.dispose();
  }

  ValueNotifier<UserCredential?> credentialNotifier =
      ValueNotifier<UserCredential?>(null);

  @override
  Widget build(BuildContext context) {
    return SimpleScaffold(
      hideBack: false,
      title: "Register",
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
                controller: nameController,
                floatingTitle: "Name",
                hint: "Enter Name",
                icon: Icons.person,
                validator: (name) {
                  if (name.toString() == "") {
                    return "Please Enter Name";
                  } else {
                    setState(() {
                      userName = name ?? "";
                    });
                  }
                  return null;
                }),
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
            CustomTextField(
                controller: emailController,
                floatingTitle: "Email",
                hint: "Enter Email",
                icon: Icons.email_rounded,
                validator: (mail) {
                  if (mail.toString() == "") {
                    return "Please Enter Email";
                  } else if (mail!.isEmpty ||
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(mail)) {
                    return 'Enter a valid Email!';
                  }
                  return null;
                }),
            CustomTextField(
                controller: passwordController,
                verticalPadding: 10,
                floatingTitle: "Password",
                hint: "Enter Password",
                icon: Icons.lock,
                isPassword: true,
                validator: (password) {
                  if (password.toString() == "") {
                    return "Please Enter Password";
                  } else if (password!.length < 5) {
                    return "Password must be greater than 5";
                  } else {
                    return null;
                  }
                }),
            CustomButton(
                onTap: () async {
                  _handleRegistration();
                },
                title: "Register"),
            appSpaces.spaceForHeight10,
            GoogleSignInWidget(
              ontap: () async {
                await GoogleSignIn().signOut();

                await signInWithGoogle().then((value) async {
                  final FirebaseFirestore firestore =
                      FirebaseFirestore.instance;

                  final box = GetStorage();
                  box.write('token', value.credential!.accessToken);
                  Get.offAllNamed('/Home');
                  await firestore.collection('users').doc(value.user!.uid).set(
                      UserModel(
                              email: value.user!.email,
                              mobile: value.user!.phoneNumber ?? '',
                              name: value.user!.displayName ?? '',
                              password: '',
                              uid: value.user!.uid)
                          .toJson());
                  if (kDebugMode) {
                    print(
                        '${value.user!.displayName}----${value.user!.email}---${value.user!.phoneNumber}');
                  }
                });
              },
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed("/LoginScreen");
                      },
                      child: RichText(
                          text: TextSpan(
                              style: appFont.f14w500Black,
                              text: "Already have an account?  ",
                              children: [
                            TextSpan(
                                style: appFont.f14w700Orange, text: "Login")
                          ])),
                    ),
                    appSpaces.spaceForHeight15,
                  ],
                ),
              ),
            ),
            appSpaces.spaceForHeight15,
          ],
        ),
      ),
    );
  }

  _handleRegistration() {
    final isValid = _formKey.currentState?.validate();
    if (isValid != null && isValid == true) {
      Get.toNamed("/otpScreen", arguments: {
        'isLogin': false,
        'data': UserModel(
            email: emailController.text,
            mobile: phoneController.text,
            name: nameController.text,
            password: passwordController.text)
      });
    }
    _formKey.currentState?.save();
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
