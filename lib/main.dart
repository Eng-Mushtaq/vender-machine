import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vender_machine/Screens/login/login.dart';
import 'package:vender_machine/Screens/onboarding/screen_one.dart';
import 'package:vender_machine/providers/auth.dart';
import 'Controller/binding.dart';
import 'Controller/navBarController.dart';
import 'Screens/bottomNavBar.dart';
import 'Screens/splashScreen.dart';
import 'constants.dart';
import 'firebase_options.dart';
import 'providers/products.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(
          create: (_) => Products()..fetchAndSetProducts(),
        ),
        ChangeNotifierProvider(create: (_) => BottomBarController()),
      ],
      child: GetMaterialApp(
        
        locale: const Locale('ar'),
        // initialBinding:Binding(),
        title: 'Vender Machine',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
