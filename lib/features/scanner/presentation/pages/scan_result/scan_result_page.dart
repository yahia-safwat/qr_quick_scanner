import 'package:flutter/material.dart';

import 'widgets/scan_result_body.dart';

class ScanResultPage extends StatelessWidget {
  final String? result;
  const ScanResultPage({super.key, this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: ScanResultBody(scannedResult: result),
    );
  }
}
