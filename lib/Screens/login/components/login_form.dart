import 'package:flutter/material.dart';

import '../../../components/rounded_button.dart';
import '../../../components/rounded_input.dart';
import '../../../components/rounded_password_input.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
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
      opacity: isLogin! ? 1.0 : 0.0,
      duration: animationDuration! * 4,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: size!.width,
          height: defaultLoginSize,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'مرحبا بعودتك',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(height: size!.height * 0.08),
                Image.asset(
                  'assets/images/login.png',
                  height: size!.height * 0.3,
                ),
                SizedBox(height: size!.height * 0.05),
                const RoundedInput(icon: Icons.mail, hint: 'اسم المستخدم'),
                const RoundedPasswordInput(hint: 'كلمة المرور'),
                const SizedBox(height: 10),
                RoundedButton(title: 'تسجيل الدخول'),
                // SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
