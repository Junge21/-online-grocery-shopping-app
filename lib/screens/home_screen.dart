import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomeScreen extends StatefulWidget {
   static const String id = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  void qrView(QRViewController qrViewController) {
    controller = qrViewController;
    qrViewController.scannedDataStream.listen((event) {
      setState(() {
        result = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Center(
            child: SizedBox(
              height: 400,
              width: 400,
              child: QRView(
                key: qrKey,
                onQRViewCreated: qrView,
                overlay: QrScannerOverlayShape(
//customizing scan area
                  borderWidth: 10,
                  borderColor: Colors.teal,
                  borderLength: 20,
                  borderRadius: 10,
                  cutOutSize: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          result != null
              ? Text(result!.code.toString())
              : const Text("Scan Please")
        ],
      )),
      floatingActionButton: FloatingActionButton(onPressed: (() {})),
    );
  }
}
