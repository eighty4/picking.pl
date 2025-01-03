import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:libtab/libtab.dart';
import 'package:pickin_playmate/main.dart';

main() {
  testWidgets('PickingPlaymate', (tester) async {
    await tester.binding.setSurfaceSize(Size(1200, 800));
    await tester.pumpWidget(PickingPlaymate());
    expect(find.byType(MeasureDisplay).evaluate().length, equals(1));
    await expectLater(
        find.byType(PickingPlaymate), matchesGoldenFile('gold/main.png'));
  }, skip: true);
}
