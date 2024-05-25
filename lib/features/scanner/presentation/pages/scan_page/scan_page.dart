import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<StatefulWidget> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isCameraPaused = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner'),
        actions: [
          IconButton(
            icon: Icon(isCameraPaused ? Icons.play_arrow : Icons.pause),
            onPressed: () {
              if (isCameraPaused) {
                controller?.resumeCamera();
              } else {
                controller?.pauseCamera();
              }
              setState(() {
                isCameraPaused = !isCameraPaused;
              });
            },
          ),
          IconButton(
            icon: FutureBuilder(
              future: controller?.getFlashStatus(),
              builder: (context, snapshot) {
                return Icon(
                  snapshot.data == true ? Icons.flash_on : Icons.flash_off,
                );
              },
            ),
            onPressed: () async {
              await controller?.toggleFlash();
              setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(Icons.qr_code),
            onPressed: () {
              // context.pushNamed(AppRoutes.generate);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          _buildQrView(context),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (result != null)
                    Text(
                      'Barcode Type: ${result!.format.name}\nData: ${result!.code}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    )
                  else
                    const Text('QR code',
                        style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildControlButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400
        ? 150.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.white,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No permission')),
      );
    }
  }

  Widget _buildControlButton() {
    return Container(
      margin: const EdgeInsets.all(8),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.photo_library),
        onPressed: () {
          // await controller?.flipCamera();
          // setState(() {},);
        },
        label: const Text('Scan Image'),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
