package com.github.rmtmckenzie.extended_share;

import android.content.Intent;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** ExtendedSharePlugin */
public class ExtendedSharePlugin implements MethodCallHandler {

  private ExtendedSharePlugin(Registrar registrar) {
    this.registrar = registrar;
  }

  private final Registrar registrar;

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "com.github.rmtmckenzie/extended_share");
    channel.setMethodCallHandler(new ExtendedSharePlugin(registrar));
  }

  private void doShare(String text, String subject) {
    Intent intent = new Intent();

    intent.setAction(Intent.ACTION_SEND);
    intent.putExtra(Intent.EXTRA_TEXT, text);
    intent.setType("text/plain");

    if (subject != null) {
      intent.putExtra(Intent.EXTRA_SUBJECT, subject);
    }

    Intent dialogIntent = Intent.createChooser(intent, null);
    if (registrar.activity() == null) {
      dialogIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
      registrar.context().startActivity(dialogIntent);
    } else {
      registrar.activity().startActivity(dialogIntent);
    }
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("share")) {
      if (call.arguments instanceof Map) {
        String text = call.argument("text");
        if (text == null || text.isEmpty()) {
          throw new IllegalArgumentException("Must have 'text' with a non-empty value");
        }
        String subject = null;
        if (call.hasArgument("subject")) {
          subject = call.argument("subject");
        }
        doShare(text, subject);
        result.success(null);
      } else {
        throw new IllegalArgumentException("Arguments must be a map");
      }
    } else {
      result.notImplemented();
    }
  }
}
