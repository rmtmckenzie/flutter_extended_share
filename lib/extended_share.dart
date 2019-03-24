import 'dart:async';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

/// Plugin for performing a system share with text and an optional subject.
class ExtendedShare {
  /// [MethodChannel] used to communicate with platform code
  static const MethodChannel _channel =
      const MethodChannel('com.github.rmtmckenzie/extended_share');

  /// Triggers the platform share dialog to share text with an optional subject.
  ///
  /// It uses the ACTION_SEND Intent on Android and UIActivityViewController
  /// on iOS.
  ///
  /// May throw [PlatformException] or [FormatException]
  /// from [MethodChannel].
  static Future<String> share({@required String text, String subject}) async {
    assert(text != null);
    assert(text.isNotEmpty);

    final Map<String, dynamic> params = {'text': text};

    if (subject != null && subject.isNotEmpty) {
      params['subject'] = subject;
    }

    return _channel.invokeMethod('share', params);
  }
}
