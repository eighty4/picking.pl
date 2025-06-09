import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:libtab/libtab.dart';
import 'package:pickin_playmate/main.dart';

const isCI = bool.fromEnvironment('CI', defaultValue: false);

main() {
  testWidgets('PickingPlaymate', (tester) async {
    await tester.binding.setSurfaceSize(Size(1200, 800));
    await tester.pumpWidget(PickingPlaymate());
    await tester.pumpAndSettle();
    expect(find.byType(MeasureDisplay).evaluate().length, equals(1));
    if (!isCI) {
      await expectLater(
        find.byType(PickingPlaymate),
        matchesGoldenFile('gold/main.png'),
      );
    }
  });
}
