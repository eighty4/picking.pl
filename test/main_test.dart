import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:libtab/libtab.dart';
import 'package:pickin_playmate/main.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

const isCI = bool.fromEnvironment('CI', defaultValue: false);

void main() {
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();
  testWidgets('PickingPlaymate', (tester) async {
    await tester.binding.setSurfaceSize(Size(1200, 800));
    await tester.pumpWidget(PickingPlaymate());
    await tester.pumpAndSettle();
    expect(find.byType(MeasureChart).evaluate().length, equals(1));
    if (!isCI) {
      await expectLater(
        find.byType(PickingPlaymate),
        matchesGoldenFile('gold/main.png'),
      );
    }
  });
}
