import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  setUpAll(() async {
    final FontLoader fontLoader = FontLoader('Raleway')
      ..addFont(rootBundle.load('assets/fonts/Raleway-Variable.ttf'))
      ..addFont(rootBundle.load('assets/fonts/Raleway-Italic-Variable.ttf'));
    await fontLoader.load();
  });

  await testMain();
}
