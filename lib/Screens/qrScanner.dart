import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan/scan.dart';

import '../Controller/navBarController.dart';
import 'bottomNavBar.dart';
class QRScreen extends StatefulWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  String? qrcode;
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     controller!.pauseCamera();
  //   }
  //   controller!.resumeCamera();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // if (qrcode!.isNotEmpty)
                  Text(
                    '$qrcode',
                    style: const TextStyle(color: Colors.white),
                    // Text(
                    //   'Barcode Type: ${describeEnum(result!.format)}   Data: $qrcode',
                    //   style: const TextStyle(color: Colors.white),
                  ),
                  // else
                  // const Text('Scan a code'),
                  TextButton(
                    child: const Text("image"),
                    onPressed: () async {
                      List<Media>? res = await ImagesPicker.pick();
                      if (res != null) {
                        String? str = await Scan.parse(res[0].path);
                        if (str != null) {
                          setState(() {
                            qrcode = str;
                              Get.off( ButtomNavBar(qrCode: 'machine 2',) );
                          });
                        }
                      }
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: TextButton(
                        onPressed: () async {
                          await controller?.toggleFlash();
                          setState(() {});
                        },
                        child: FutureBuilder(
                          future: controller?.getFlashStatus(),
                          builder: (context, snapshot) {
                            // return Text('Flash: ${snapshot.data}');
                            return const Icon(
                              Icons.flash_on,
                              color: Colors.white,
                            );
                          },
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: TextButton(
                        onPressed: () async {
                          await controller?.flipCamera();
                          setState(() {});
                        },
                        child: FutureBuilder(
                          future: controller?.getCameraInfo(),
                          builder: (context, snapshot) {
                            if (snapshot.data != null) {
                              return const Icon(
                                Icons.cameraswitch_outlined,
                                color: Colors.white,
                              );
                              // return Text(
                              //     'Camera facing ${describeEnum(snapshot.data!)}');
                            } else {
                              return const Text('loading');
                            }
                          },
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: TextButton(
                        onPressed: () async {
                          await controller?.pauseCamera();
                        },
                        child: const Icon(
                          Icons.pause_circle_outlined,
                          color: Colors.white,
                        )
                        //  const Text('pause',
                        //     style: TextStyle(fontSize: 20)),
                        ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: TextButton(
                        onPressed: () async {
                          await controller?.resumeCamera();
                        },
                        child: const Icon(
                          Icons.pause_circle_rounded,
                          color: Colors.white,
                        )
                        //  const Text('resume',
                        //     style: TextStyle(fontSize: 20)),
                        ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {

    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller,) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
       qrcode = scanData.code;
        // Get.to( const ButtomNavBar());
        Get.off( ButtomNavBar(qrCode: 'machine 2',) );
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
