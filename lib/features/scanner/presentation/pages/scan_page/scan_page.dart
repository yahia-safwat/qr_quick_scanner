import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../../core/routes/app_routes.dart';
import 'widgets/scan_page_body.dart';
import 'widgets/start_stop_mobile_scanner_button.dart';
import 'widgets/toggle_flashlight_button.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> with WidgetsBindingObserver {
  final MobileScannerController controller = MobileScannerController(
    autoStart: false,
    torchEnabled: false,
    useNewCameraSelector: true,
  );

  Barcode? _barcode;
  StreamSubscription<Object?>? _subscription;

  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      final barcode = barcodes.barcodes.firstOrNull;
      if (barcode != null) {
        // Stop the scanner and navigate to the result screen
        controller.stop();
        context.pushNamed(AppRoutes.scanResult, extra: barcode).then((_) {
          // Resume the scanner when returning to this page
          setState(() {
            _barcode = null;
          });
          controller.start();
        });
      } else {}
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startListening();
  }

  void _startListening() {
    _subscription = controller.barcodes.listen(_handleBarcode);
    unawaited(controller.start());
  }

  void _stopListening() {
    unawaited(_subscription?.cancel());
    _subscription = null;
    unawaited(controller.stop());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!controller.value.isInitialized) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        _stopListening();
        break;
      case AppLifecycleState.resumed:
        _startListening();
        break;
      case AppLifecycleState.inactive:
        _stopListening();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool didPop) {
        setState(() {
          _barcode = null;
        });
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('QR Scanner'), actions: [
          StartStopMobileScannerButton(controller: controller),
          ToggleFlashlightButton(controller: controller),
          IconButton(
            icon: const Icon(Icons.qr_code),
            onPressed: () {
              context.pushNamed(AppRoutes.generate);
            },
          ),
        ]),
        backgroundColor: Colors.black,
        body: ScanPageBody(
          controller: controller,
          barcode: _barcode,
        ),
      ),
    );
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    _stopListening();
    super.dispose();
    await controller.dispose();
  }
}
