import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_routes.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // background (button) color
                foregroundColor: Colors.white, // foreground (text) color
                splashFactory: InkSplash.splashFactory, // splash effect
              ),
              onPressed: () {
                context.goNamed(AppRoutes.scan);
              },
              child: const Text('SCAN QR CODE'),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // background (button) color
                foregroundColor: Colors.white, // foreground (text) color
                splashFactory: InkSplash.splashFactory, // splash effect
              ),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => GenerateScreen()),
                // );
              },
              child: const Text('GENERATE QR CODE'),
            ),
          ),
        ],
      ),
    );
  }
}
