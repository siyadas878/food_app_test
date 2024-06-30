import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/cubit/auth_cubit/auth_cubit.dart';
import 'package:food_app/core/models/user_model.dart';
import 'package:food_app/manager/space_manger.dart';
import 'package:food_app/utils/get_dimension.dart';
import 'package:food_app/widgets/custom_snackBar.dart';
import 'package:food_app/widgets/simple_scaffold.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:pinput/pinput.dart';
import '../../manager/color_manager.dart';
import '../../manager/font_manager.dart';

class OTPScreen extends StatefulWidget {
  final UserModel userData;
  final bool isLogin;
  const OTPScreen({
    required this.userData,
    required this.isLogin,
    super.key,
  });

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  AppColors appColors = AppColors();
  FirebaseAuth auth = FirebaseAuth.instance;
  String? verId;
  String receivedOtp = "";
  int _remainingTime = 60;
  Timer? _timer;

  @override
  void initState() {
    _sendOtp();
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: TextStyle(
          fontSize: 28,
          color: appColors.brandDark,
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(5),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      color: Colors.white,
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(5),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    int minutes = _remainingTime ~/ 60;
    int seconds = _remainingTime % 60;

    return SimpleScaffold(
      title: 'OTP Verification',
      hideBack: false,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          children: [
            SizedBox(
              height: screenHeight(context) * 0.2,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Center(
                child: Text(
                  "Enter 6-digit  code We have sent to ",
                  style: appFont.f14w500Black,
                ),
              ),
            ),
            Center(
                child: Text(
              '',
              style: appFont.f14w700Orange,
            )),
            const SizedBox(
              height: 20,
            ),
            Pinput(
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              controller: _textEditingController,
              length: 6,
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
              onCompleted: (pin) {},
            ),
            appSpaces.spaceForHeight15,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$minutes:${seconds.toString().padLeft(2, '0')}',
                  style: appFont.f14w500Black,
                ),
              ],
            ),
            appSpaces.spaceForHeight10,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Didn't receive the OTP?",
                      style: appFont.f14w500Black,
                    )),
                InkWell(
                    onTap: () {
                      _sendOtp();
                    },
                    child: Text(
                      "Resend OTP",
                      style: appFont.f12w500Orange,
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is UserSignUpSuccessState) {
                      Get.offAllNamed("/Home");
                    }
                  },
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        verifyOTP(
                            verId.toString(), _textEditingController.text);
                      },
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: appColors.brandDark,
                        child: state is! UserSignUpLoadingState
                            ? const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 35,
                              )
                            : const CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _sendOtp() async {
    String number = widget.userData.mobile ?? '';

    await auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      phoneNumber: '+91 $number',
      verificationCompleted: (PhoneAuthCredential credential) async {
        setState(() {
          _textEditingController.text = credential.smsCode.toString();
          receivedOtp = credential.smsCode.toString();
        });
        verifyOTP(credential.verificationId.toString(),
            credential.smsCode.toString());

        setState(() {
          _textEditingController.text = credential.smsCode.toString();
          receivedOtp = credential.smsCode.toString();
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        customSnackBar(
          title: 'Error',
          message: "OTP Verification Failed",
          isError: true,
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          verId = verificationId;
        });
        customSnackBar(title: 'Successful', message: 'Otp send successfully');
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP(String verificationId, String smsCode) {
    AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    auth.signInWithCredential(credential).then((value) {
      widget.isLogin
          ? Get.offAllNamed("/Home")
          : BlocProvider.of<AuthCubit>(context).userSignUp(
              UserModel(
                email: widget.userData.email,
                name: widget.userData.name,
                password: widget.userData.password,
                mobile: widget.userData.mobile,
              ),
              context,
              value.user!.uid);
      final box = GetStorage();
      box.write('token', value.credential!.accessToken);
      box.write('user', value.user!.uid);
    }).catchError((e) {});
  }
}
