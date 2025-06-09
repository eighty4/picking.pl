import 'package:flutter_test/flutter_test.dart';
import 'package:libtab/libtab.dart';
import 'package:pickin_playmate/content/content_type.dart';

main() {
  testWidgets('ContentType.cacheId()', (_) async {
    expect(
      BanjoRollContent(banjoRoll: BanjoRoll.backward).cacheId(),
      equals('Banjo::BanjoRollContent::backward'),
    );
    expect(
      BanjoRollContent(banjoRoll: BanjoRoll.forward).cacheId(),
      equals('Banjo::BanjoRollContent::forward'),
    );
    expect(
      BanjoRollContent(banjoRoll: BanjoRoll.alternatingThumb).cacheId(),
      equals('Banjo::BanjoRollContent::alternatingThumb'),
    );
    expect(
      BanjoRollContent(banjoRoll: BanjoRoll.forwardBackward).cacheId(),
      equals('Banjo::BanjoRollContent::forwardBackward'),
    );
    expect(
      GuitarStrumContent(guitarStrum: GuitarStrum.rem).cacheId(),
      equals('Guitar::GuitarStrumContent::rem'),
    );
    expect(
      SongContent(
        instrument: Instrument.banjo,
        song: 'Wayfaring Stranger',
      ).cacheId(),
      equals('Banjo::SongContent::Wayfaring Stranger'),
    );
    expect(
      SongContent(
        instrument: Instrument.guitar,
        song: 'Wayfaring Stranger',
      ).cacheId(),
      equals('Guitar::SongContent::Wayfaring Stranger'),
    );
    expect(
      TechniqueContent(
        instrument: Instrument.banjo,
        technique: Technique.hammerOn,
      ).cacheId(),
      equals('Banjo::TechniqueContent::hammerOn'),
    );
    expect(
      TechniqueContent(
        instrument: Instrument.banjo,
        technique: Technique.pullOff,
      ).cacheId(),
      equals('Banjo::TechniqueContent::pullOff'),
    );
    expect(
      TechniqueContent(
        instrument: Instrument.banjo,
        technique: Technique.slide,
      ).cacheId(),
      equals('Banjo::TechniqueContent::slide'),
    );
    expect(
      TechniqueContent(
        instrument: Instrument.guitar,
        technique: Technique.hammerOn,
      ).cacheId(),
      equals('Guitar::TechniqueContent::hammerOn'),
    );
    expect(
      TechniqueContent(
        instrument: Instrument.guitar,
        technique: Technique.pullOff,
      ).cacheId(),
      equals('Guitar::TechniqueContent::pullOff'),
    );
    expect(
      TechniqueContent(
        instrument: Instrument.guitar,
        technique: Technique.slide,
      ).cacheId(),
      equals('Guitar::TechniqueContent::slide'),
    );
  });
  testWidgets('ContentType.fromCacheId()', (_) async {
    expect(
      ContentType.fromCacheId('Banjo::BanjoRollContent::backward'),
      equals(BanjoRollContent(banjoRoll: BanjoRoll.backward)),
    );
    expect(
      ContentType.fromCacheId('Banjo::BanjoRollContent::forward'),
      equals(BanjoRollContent(banjoRoll: BanjoRoll.forward)),
    );
    expect(
      ContentType.fromCacheId('Banjo::BanjoRollContent::alternatingThumb'),
      equals(BanjoRollContent(banjoRoll: BanjoRoll.alternatingThumb)),
    );
    expect(
      ContentType.fromCacheId('Banjo::BanjoRollContent::forwardBackward'),
      equals(BanjoRollContent(banjoRoll: BanjoRoll.forwardBackward)),
    );
    expect(
      ContentType.fromCacheId('Guitar::GuitarStrumContent::rem'),
      equals(GuitarStrumContent(guitarStrum: GuitarStrum.rem)),
    );
    expect(
      ContentType.fromCacheId('Banjo::SongContent::Wayfaring Stranger'),
      equals(
        SongContent(instrument: Instrument.banjo, song: 'Wayfaring Stranger'),
      ),
    );
    expect(
      ContentType.fromCacheId('Guitar::SongContent::Wayfaring Stranger'),
      equals(
        SongContent(instrument: Instrument.guitar, song: 'Wayfaring Stranger'),
      ),
    );
    expect(
      ContentType.fromCacheId('Banjo::TechniqueContent::hammerOn'),
      equals(
        TechniqueContent(
          instrument: Instrument.banjo,
          technique: Technique.hammerOn,
        ),
      ),
    );
    expect(
      ContentType.fromCacheId('Banjo::TechniqueContent::pullOff'),
      equals(
        TechniqueContent(
          instrument: Instrument.banjo,
          technique: Technique.pullOff,
        ),
      ),
    );
    expect(
      ContentType.fromCacheId('Banjo::TechniqueContent::slide'),
      equals(
        TechniqueContent(
          instrument: Instrument.banjo,
          technique: Technique.slide,
        ),
      ),
    );
    expect(
      ContentType.fromCacheId('Guitar::TechniqueContent::hammerOn'),
      equals(
        TechniqueContent(
          instrument: Instrument.guitar,
          technique: Technique.hammerOn,
        ),
      ),
    );
    expect(
      ContentType.fromCacheId('Guitar::TechniqueContent::pullOff'),
      equals(
        TechniqueContent(
          instrument: Instrument.guitar,
          technique: Technique.pullOff,
        ),
      ),
    );
    expect(
      ContentType.fromCacheId('Guitar::TechniqueContent::slide'),
      equals(
        TechniqueContent(
          instrument: Instrument.guitar,
          technique: Technique.slide,
        ),
      ),
    );
  });
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
