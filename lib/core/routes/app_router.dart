import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../features/generator/presentation/pages/generate_page/generate_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/scanner/presentation/pages/scan_page/scan_page.dart';
import '../../features/scanner/presentation/pages/scan_result/scan_result_page.dart';
import 'app_routes.dart';

import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.scan,
        name: AppRoutes.scan,
        builder: (context, state) => const ScanPage(),
      ),
      GoRoute(
        path: AppRoutes.scanResult,
        name: AppRoutes.scanResult,
        builder: (context, state) {
          final result = state.extra! as Barcode;

          return ScanResultPage(result: result);
        },
      ),
      GoRoute(
        path: AppRoutes.generate,
        name: AppRoutes.generate,
        builder: (context, state) => const GeneratePage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('No route found for ${state.error}'),
      ),
    ),
  );
}
