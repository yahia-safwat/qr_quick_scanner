import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'image_from_gallery_button.dart';
import 'scanner_error_widget.dart';
import 'scanner_overlay.dart';

class ScanPageBody extends StatelessWidget {
  final MobileScannerController controller;
  final Barcode? barcode;

  const ScanPageBody({super.key, required this.controller, this.barcode});

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset.zero) -
          const Offset(
              0, 150), // Move scan window above the center by 50 pixels
      width: 200,
      height: 200,
    );
    return Stack(
      children: [
        MobileScanner(
          controller: controller,
          scanWindow: scanWindow,
          errorBuilder: (context, error, child) {
            return ScannerErrorWidget(error: error);
          },
        ),
        ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, value, child) {
            if (!value.isInitialized ||
                !value.isRunning ||
                value.error != null) {
              return const SizedBox();
            }

            return CustomPaint(
              painter: ScannerOverlay(scanWindow: scanWindow),
            );
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'QR code',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnalyzeImageFromGalleryButton(controller: controller),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
