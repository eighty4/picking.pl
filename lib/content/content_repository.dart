import 'package:libtab/libtab.dart';
import 'package:pickin_playmate/content/content_catalog.dart';
import 'package:pickin_playmate/content/content_type.dart';

class ContentRepository {
  Future<ContentCatalog> retrieveContentCatalog(Instrument instrument) async {
    return switch (instrument) {
      Instrument.banjo => buildBanjoCatalog(),
      Instrument.guitar => buildGuitarCatalog(),
    };
  }

  Future<BanjoContentCatalog> buildBanjoCatalog() async {
    return BanjoContentCatalog(
      banjoRolls: BanjoRoll.values
          .map((banjoRoll) => BanjoRollContent(banjoRoll: banjoRoll))
          .toList(growable: false),
      songs: await collectSongContent(Instrument.banjo),
      techniques: collectTechniqueContent(Instrument.banjo),
    );
  }

  Future<GuitarContentCatalog> buildGuitarCatalog() async {
    return GuitarContentCatalog(
      guitarStrums: GuitarStrum.values
          .map((guitarStrum) => GuitarStrumContent(guitarStrum: guitarStrum))
          .toList(growable: false),
      songs: await collectSongContent(Instrument.guitar),
      techniques: collectTechniqueContent(Instrument.guitar),
    );
  }

  Future<List<ContentType>> collectSongContent(Instrument instrument) async {
    return switch (instrument) {
      Instrument.banjo => [
        'Cripple Creek',
        'Nine Pound Hammer',
        'Wayfaring Stranger',
      ].map((song) => SongContent(instrument: Instrument.banjo, song: song)),
      Instrument.guitar => [
        'Blackberry Blossom',
        'Nine Pound Hammer',
        'Whiskey Before Breakfast',
      ].map((song) => SongContent(instrument: Instrument.guitar, song: song)),
    }.toList();
  }

  List<ContentType> collectTechniqueContent(Instrument instrument) {
    return Technique.values
        .map(
          (technique) =>
              TechniqueContent(instrument: instrument, technique: technique),
        )
        .toList(growable: false);
  }

  Future<Measure> retrieveContent(ContentType contentType) async {
    if (contentType.instrument == Instrument.banjo) {
      return Measure.fromNoteList([
        Note(3, 0),
        Note(2, 2),
        Note(1, 0),
        Note(3, 0),
        Note(2, 2),
        Note(1, 0),
        Note(3, 0),
        Note(2, 2),
      ]);
    } else {
      final c = Note(2, 1, and: Note(4, 2, and: Note(5, 3)));
      final g = Note(1, 3, and: Note(5, 2, and: Note(6, 3)));
      final d = Note(1, 2, and: Note(2, 3, and: Note(3, 2)));
      return Measure.fromNoteList([c, c, null, g, g, d, d, null]);
    }
  }
}
