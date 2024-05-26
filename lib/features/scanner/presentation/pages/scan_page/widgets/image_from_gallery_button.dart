import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../../../core/routes/app_routes.dart';

class AnalyzeImageFromGalleryButton extends StatelessWidget {
  const AnalyzeImageFromGalleryButton({required this.controller, super.key});

  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.photo_library),
        onPressed: () async {
          // Handle scan image button press
          final ImagePicker picker = ImagePicker();

          final XFile? image = await picker.pickImage(
            source: ImageSource.gallery,
          );

          if (image == null) {
            return;
          }

          final BarcodeCapture? barcodes = await controller.analyzeImage(
            image.path,
          );

          if (!context.mounted) {
            return;
          }

          if (barcodes != null && barcodes.barcodes.isNotEmpty) {
            final barcode = barcodes.barcodes.first;
            context.pushNamed(AppRoutes.scanResult, extra: barcode);
          } else {
            const SnackBar snackbar = SnackBar(
              content: Text('No barcode found!'),
              backgroundColor: Colors.red,
            );

            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }
        },
        label: const Text('Scan Image'),
      ),
    );
  }
}
