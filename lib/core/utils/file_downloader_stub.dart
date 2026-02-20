import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FileDownloader {
  static Future<void> downloadFile(String url, {String? filename}) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }
}
