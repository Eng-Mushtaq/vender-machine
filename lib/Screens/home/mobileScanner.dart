import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scan/scan.dart';

import '../bottomNavBar.dart';

MobileScannerController cameraController = MobileScannerController();

Widget mobileScanner(BuildContext context) {
  return Scaffold(
    // appBar: AppBar(
    //   title: const Text('Mobile Scanner'),
    //   actions: [
    //     IconButton(
    //       color: Colors.white,
    //       icon: ValueListenableBuilder(
    //         valueListenable: cameraController.torchState,
    //         builder: (context, state, child) {
    //           switch (state as TorchState) {
    //             case TorchState.off:
    //               return const Icon(Icons.flash_off, color: Colors.grey);
    //             case TorchState.on:
    //               return const Icon(Icons.flash_on, color: Colors.yellow);
    //           }
    //         },
    //       ),
    //       iconSize: 32.0,
    //       onPressed: () => cameraController.toggleTorch(),
    //     ),
    //     IconButton(
    //       color: Colors.white,
    //       icon: ValueListenableBuilder(
    //         valueListenable: cameraController.cameraFacingState,
    //         builder: (context, state, child) {
    //           switch (state as CameraFacing) {
    //             case CameraFacing.front:
    //               return const Icon(Icons.camera_front);
    //             case CameraFacing.back:
    //               return const Icon(Icons.camera_rear);
    //           }
    //         },
    //       ),
    //       iconSize: 32.0,
    //       onPressed: () => cameraController.switchCamera(),
    //     ),
    //   ],
    // ),
    body: Stack(
      children: [
        AiBarcodeScanner(
          
          validateText: 'https://',
          validateType: ValidateType.startsWith,
          onScan: (String value) {
            Get.offAll(
              ButtomNavBar(qrCode: 'machine 2'),
            );
          },
          onDetect: ((barcode, args) {
            if (barcode.rawValue!.isNotEmpty) {
              Get.offAll(
                ButtomNavBar(qrCode: 'machine 2'),
              );
            } else {
              Get.showSnackbar(const GetSnackBar(
                backgroundColor: Colors.grey,
                // backgroundGradient: Gradient(colors: [],),
                message: 'حدث خطأ',
                messageText: Text('لم يتم التعرف أي باركود'),
              ),);
              Get.offAll(
                ButtomNavBar(qrCode: null),
              );
            }
          }),
        ),

        // MobileScanner(
        //   allowDuplicates: true,
        //   controller: cameraController,
        //   onDetect: (barcode, args) {
        //     if (barcode.rawValue == null) {
        //       debugPrint('Failed to scan Barcode');
        //       Get.showSnackbar(const GetSnackBar(
        //         backgroundColor: Colors.grey,
        //         // backgroundGradient: Gradient(colors: [],),
        //         message: 'حدث خطأ',
        //         messageText: Text('لم يتم التعرف أي باركود'),
        //       ));
        //     } else {
        //       final String code = barcode.rawValue!;
        //       debugPrint('Barcode found! $code');
        //       Get.offAll(
        //         ButtomNavBar(qrCode: 'machine 2'),
        //       );
        //     }
        //   },
        // ),
        Positioned(
          bottom: 100,
          child: IconButton(
            icon: const Icon(
              Icons.image,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () async {
              List<Media>? res = await ImagesPicker.pick();
              if (res != null) {
                String? str = await Scan.parse(res[0].path);
                if (str != null) {
                  Get.offAll(
                    ButtomNavBar(qrCode: 'machine 2'),
                  );
                } else {
                  Get.showSnackbar(const GetSnackBar(
                    backgroundColor: Colors.grey,
                    // backgroundGradient: Gradient(colors: [],),
                    message: 'حدث خطأ',
                    messageText: Text('لم يتم التعرف أي باركود'),
                  ));
                  Get.offAll(
                    ButtomNavBar(qrCode: null),
                  );
                }
              }
            },
          ),
        ),
      ],
    ),
  );
}
