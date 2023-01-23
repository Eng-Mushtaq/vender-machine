import 'package:flutter/material.dart';

import 'mobileScanner.dart';

class MobileScanner extends StatelessWidget {
  const MobileScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    SafeArea(child:
      mobileScanner(context));
  }
}