import 'package:flutter/services.dart';
import 'package:rich_clipboard/rich_clipboard.dart';

enum ClipboardCopyResult { richText, plainText, failed }

class ClipboardService {
  const ClipboardService._();

  /// Copies HTML when the browser supports rich clipboard data and falls back
  /// to plain text when it does not.
  static Future<ClipboardCopyResult> copy({
    required String text,
    required String html,
  }) async {
    try {
      await RichClipboard.setData(RichClipboardData(text: text, html: html));
      return ClipboardCopyResult.richText;
    } catch (_) {
      try {
        await Clipboard.setData(ClipboardData(text: text));
        return ClipboardCopyResult.plainText;
      } catch (_) {
        return ClipboardCopyResult.failed;
      }
    }
  }
}
