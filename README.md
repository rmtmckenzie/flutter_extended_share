# Extended Share plugin

[![pub package](https://img.shields.io/pub/v/extended_share.svg)](https://pub.dartlang.org/packages/extended_share)

A flutter plugin for sharing with an optional subject.

## Why another plugin?

The flutter team's Share plugin doesn't support anything but
sharing basic text. I wanted to be able to add a subject as well.

There are other plugins that could do this but they didn't seem to be
consistent between android & ios, or they used Kotlin/Swift. Swift is
fine since I'm already using it, but I didn't want to incur the overhead
of adding kotlin to my app. So I decided to write a simple plugin that
does sharing, in obj-c and java, with an optional subject.

## Usage

Usage is very simple. Add `extended_share` to your pubspec.

Then import the library with:
``` dart
import 'package:extended_share/extended_share.dart';
```

Then invoke the static `share` method anywhere in your Dart code:
``` dart
ExtendedShare.share(text: 'some text to be shared', subject: 'a subject to be shown');
```

You can choose not to use a subject in which case it will just share the text.

## Future

If anyone else needs to do something that the basic share plugin doesn't support, I encourage
them to add an issue asking for it (although I have pretty limited time to work on this)
or even better do a PR to add it (but still using only obj-c and java),
that way this plugin can become more useful!

## License

While I wrote all of this code character by character, I did occaisionally refer to its code of the
flutter team's share plugin, and as such should probably reference it here. Anyone modifying this code
should take into account that it might fall under the original licence of that code, which can be
found at: [https://github.com/flutter/plugins/blob/master/packages/share](https://github.com/flutter/plugins/blob/master/packages/share).