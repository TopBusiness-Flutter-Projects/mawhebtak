import 'dart:convert';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawhebtak/features/events/cubit/event_cubit.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  bool hasScanned = false;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EventCubit>();

    return Scaffold(
      appBar: AppBar(title: Text('scan_qR_code'.tr())),
      body: AiBarcodeScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
          facing: CameraFacing.back,
        ),
        onScan: (_) {},
        onDispose: () => debugPrint("QR Scanner disposed"),

          onDetect: (capture) async {
            if (hasScanned) return;


            if (capture.barcodes.isEmpty) return;

            final String? code = capture.barcodes.first.rawValue;
            if (code == null || code.isEmpty) return;

            debugPrint('QR Scanned: $code');

            String? id;

            try {
              final data = json.decode(code);
              if (data is Map && data.containsKey('id')) {
                id = data['id'].toString();
              }
            } catch (_) {
              final match = RegExp(r'.*/(\d+)$').firstMatch(code);
              if (match != null) {
                id = match.group(1);
              } else if (int.tryParse(code) != null) {
                id = code;
              }
            }

            if (id == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('invalid_qr_code'.tr())),
              );
              return;
            }

            setState(() => hasScanned = true);
            await Future.delayed(const Duration(milliseconds: 200));
            if (!context.mounted) return;

            await showDialog(
              context: context,
              useRootNavigator: true,
              builder: (_) => AlertDialog(
                title: Text("presence".tr()),
                content: Text("هل تريد تأكيد حضور المتابع رقم $id؟"),
                actions: [

                  ElevatedButton(
                    onPressed: () async {
                      print('the id ${id}');
                      await cubit.scanQrCode(eventFollowerId: id);
                    },
                    child: Text("presence".tr()),
                  ),
                ],
              ),
            );

          }

      ),
    );
  }
}
