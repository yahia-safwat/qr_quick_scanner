import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScanResultBody extends StatelessWidget {
  final String? scannedResult;

  const ScanResultBody({super.key, required this.scannedResult});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Barcode Type: ',
            // 'Barcode Type: ${scannedResult?.format.name}',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Scanned result',
            // Text(scannedResult?.code ?? 'No result',
            style: TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 70.0),
          ElevatedButton(
            onPressed: () {
              _copyToClipboard(context, 'scan result');
            },
            child: const Text('Copy Result'),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Result copied to clipboard'),
    ));
  }
}
