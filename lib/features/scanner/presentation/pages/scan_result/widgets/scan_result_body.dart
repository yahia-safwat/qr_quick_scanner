import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanResultBody extends StatelessWidget {
  final Barcode? scannedResult;

  const ScanResultBody({super.key, required this.scannedResult});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Barcode Type: ${scannedResult?.format.name}',
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          Text(
            scannedResult?.rawValue ?? 'No result',
            style: const TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 70.0),
          if (_isWebsite(scannedResult)) // Check if scanned code is a website
            ElevatedButton(
              onPressed: () {
                _goToWebsite(context, scannedResult!.rawValue);
              },
              child: const Text('Go to Website'),
            )
          else
            ElevatedButton(
              onPressed: () {
                _copyToClipboard(
                    context, scannedResult?.rawValue ?? 'No result');
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

  Future<void> _goToWebsite(BuildContext context, String? url) async {
    if (url != null) {
      final canLaunch = await canLaunchUrl(Uri.parse(url));
      if (canLaunch) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Could not launch website'),
          ));
        }
      }
    }
  }
}

bool _isWebsite(Barcode? barcode) {
  // Check if the barcode format indicates a website URL
  return barcode?.url != null;
}
