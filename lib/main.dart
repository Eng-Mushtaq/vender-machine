import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vender_machine/Screens/login/login.dart';
import 'package:vender_machine/Screens/onboarding/screen_one.dart';
import 'Controller/binding.dart';
import 'constants.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
       locale: const Locale('ar'),
      initialBinding:Binding(),
      title: 'Vender Machine',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)
      ),
      home: const OnboardingScreenOne(),
    );
  }
}
