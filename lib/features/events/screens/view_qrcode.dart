import 'dart:convert';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EventQRCodePage extends StatelessWidget {
  final String eventUrl;

  const EventQRCodePage({super.key, required this.eventUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('scan_to_join_event'.tr()),
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildImageFromDataUrl(eventUrl),
        ],
      )),
    );
  }
}

Widget buildImageFromDataUrl(String dataUrl) {
  try {
    // Check if it's a valid data URL
    if (!dataUrl.startsWith('data:image/')) {
      return const Text('Invalid image data URL');
    }

    // Extract base64 part
    String base64String = dataUrl.split(',')[1];

    // Decode and display
    Uint8List bytes = base64Decode(base64String);
    return Image.memory(bytes);
  } catch (e) {
    return Text('Error loading image: $e');
  }
}
