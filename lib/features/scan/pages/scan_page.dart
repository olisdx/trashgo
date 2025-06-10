import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import '../../../core/router/app_router.gr.dart';

@RoutePage()
class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    controller!.pauseCamera();
  }

  void _onQRViewCreated(QRViewController controller, BuildContext context) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });

      if (result == null) return;
      await controller.pauseCamera();
      if (!context.mounted) return;
      context.router.push(PayRoute(result: result!));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scan Pay")),
      body: QRView(
        key: qrKey,
        onQRViewCreated: (c) => _onQRViewCreated(c, context),
        overlay: QrScannerOverlayShape(borderWidth: 6),
      ),
    );
  }
}
