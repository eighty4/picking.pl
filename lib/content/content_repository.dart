import 'package:libtab/libtab.dart';
import 'package:pickin_playmate/content/content_type.dart';

class ContentCatalog {
  final Map<ContentCategory, List<ContentType>> content;
  final List<ContentCategory> practiceCategories;

  ContentCatalog({required this.practiceCategories, required this.content});
}

class ContentRepository {
  Future<ContentCatalog> retrieveContentCatalog(Instrument instrument) async {
    return switch (instrument) {
      Instrument.banjo => buildBanjoCatalog(),
      Instrument.guitar => buildGuitarCatalog(),
    };
  }

  Future<ContentCatalog> buildBanjoCatalog() async {
    final practiceCategories = [
      ContentCategory.banjoRolls,
      ContentCategory.techniques,
    ];
    final Map<ContentCategory, List<ContentType>> content = {
      ContentCategory.banjoRolls: BanjoRoll.values
          .map((banjoRoll) => BanjoRollContent(banjoRoll: banjoRoll))
          .toList(growable: false),
      ContentCategory.songs: await collectSongContent(Instrument.banjo),
      ContentCategory.techniques: collectTechniqueContent(Instrument.banjo),
    };
    return ContentCatalog(
      practiceCategories: practiceCategories,
      content: content,
    );
  }

  Future<ContentCatalog> buildGuitarCatalog() async {
    final practiceCategories = [
      ContentCategory.guitarStrums,
      ContentCategory.techniques,
    ];
    final Map<ContentCategory, List<ContentType>> content = {
      ContentCategory.guitarStrums: GuitarStrum.values
          .map((guitarStrum) => GuitarStrumContent(guitarStrum: guitarStrum))
          .toList(growable: false),
      ContentCategory.songs: await collectSongContent(Instrument.guitar),
      ContentCategory.techniques: collectTechniqueContent(Instrument.guitar),
    };
    return ContentCatalog(
      practiceCategories: practiceCategories,
      content: content,
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
