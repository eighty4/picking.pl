import 'package:flutter_test/flutter_test.dart';
import 'package:libtab/libtab.dart';
import 'package:pickin_playmate/content/content_type.dart';

main() {
  testWidgets('BanjoRollContent == on banjoRoll', (_) async {
    final backward = BanjoRollContent(banjoRoll: BanjoRoll.backward);
    final forward = BanjoRollContent(banjoRoll: BanjoRoll.forward);
    expect(forward, equals(forward));
    expect(forward, isNot(equals(backward)));
  });
  testWidgets('GuitarStrumContent == on guitarStrum', (_) async {
    final beachBoys = GuitarStrumContent(guitarStrum: GuitarStrum.beachBoys);
    final rem = GuitarStrumContent(guitarStrum: GuitarStrum.rem);
    expect(beachBoys, equals(beachBoys));
    expect(beachBoys, isNot(equals(rem)));
  });
  testWidgets('TechniqueContent == on instrument and technique', (_) async {
    final banjoHammerOn = TechniqueContent(
      instrument: Instrument.banjo,
      technique: Technique.hammerOn,
    );
    final banjoPullOff = TechniqueContent(
      instrument: Instrument.banjo,
      technique: Technique.pullOff,
    );
    expect(banjoHammerOn, equals(banjoHammerOn));
    expect(banjoHammerOn, isNot(equals(banjoPullOff)));

    final guitarHammerOn = TechniqueContent(
      instrument: Instrument.guitar,
      technique: Technique.hammerOn,
    );
    final guitarPullOff = TechniqueContent(
      instrument: Instrument.guitar,
      technique: Technique.pullOff,
    );
    expect(guitarHammerOn, equals(guitarHammerOn));
    expect(guitarHammerOn, isNot(equals(guitarPullOff)));

    expect(banjoHammerOn, isNot(equals(guitarHammerOn)));
    expect(banjoPullOff, isNot(equals(guitarPullOff)));
  });
}
