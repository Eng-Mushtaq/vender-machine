import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/rounded_button.dart';
import '../../../components/rounded_input.dart';
import '../../../components/rounded_password_input.dart';
import '../../bottomNavBar.dart';

class RegisterForm extends StatelessWidget {
   const RegisterForm({
    Key? key,
    @required this.isLogin,
    @required this.animationDuration,
    @required this.size,
    @required this.defaultLoginSize,
  }) : super(key: key);

  final bool? isLogin;
  final Duration? animationDuration;
  final Size? size;
  final double? defaultLoginSize;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isLogin! ? 0.0 : 1.0,
      duration: animationDuration! * 5,
      child: Visibility(
        visible: !isLogin!,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: size!.width,
            height: defaultLoginSize,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   const SizedBox(height: 10),
                   const Text(
                    'مرحبا بك',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                   const SizedBox(height: 40),
                  Image.asset(
                    'assets/images/register.png',
                    height: 270,
                    width: 270,
                  ),
                   const SizedBox(height: 40),
                  const RoundedInput(icon: Icons.mail, hint: 'الاسم'),
                   const RoundedInput(icon: Icons.face_rounded, hint: ' اسم المستخدم'),
                   const RoundedPasswordInput(hint: 'كلمة المرور'),
                   const SizedBox(height: 10),
                  RoundedButton(
                    title: 'انشاء الحساب',
                    onPress: () {
                      Get.to( ButtomNavBar());
                    },
                  ),
                   const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
