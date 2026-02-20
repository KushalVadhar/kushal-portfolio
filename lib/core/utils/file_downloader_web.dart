import 'package:flutter/foundation.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class FileDownloader {
  static Future<void> downloadFile(String url, {String? filename}) async {
    final anchor = html.AnchorElement(href: url)..target = 'blank';

    if (filename != null) {
      anchor.download = filename;
    }

    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
  }
}
