import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class StartStopMobileScannerButton extends StatelessWidget {
  const StartStopMobileScannerButton({required this.controller, super.key});

  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, child) {
        if (!state.isInitialized || !state.isRunning) {
          return IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: () async {
              await controller.start();
            },
          );
        }

        return IconButton(
          icon: const Icon(Icons.pause),
          onPressed: () async {
            await controller.stop();
          },
        );
      },
    );
  }
}
