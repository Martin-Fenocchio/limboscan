// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:limboscan/features/urls/cubit/urls_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  bool _isScanning = true;

  void _handleBarcode(BarcodeCapture barcodes) {
    if (_isScanning && mounted) {
      _isScanning = false;
      context.read<UrlsCubit>().goToUrlProfile(
          url: barcodes.barcodes.firstOrNull?.displayValue ?? '',
          context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!mounted) {
      return Scaffold(
        body: Container(
          color: Colors.white,
          width: 100.w,
          height: 100.h,
          child: const Center(child: Text('No permisos')),
        ),
      );
    }

    return Scaffold(
      body: SizedBox(
        height: 100.h,
        child: MobileScanner(
          onDetect: _handleBarcode,
        ),
      ),
    );
  }
}
