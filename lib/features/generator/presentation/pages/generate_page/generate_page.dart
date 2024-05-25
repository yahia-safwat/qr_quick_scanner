import 'package:flutter/material.dart';

class GeneratePage extends StatelessWidget {
  const GeneratePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Generator'),
      ),
      body: const Center(
        child: Text('Generate Page Body'),
      ),
    );
  }
}
