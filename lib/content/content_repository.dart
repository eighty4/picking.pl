import 'package:libtab/libtab.dart';
import 'package:pickin_playmate/content/content_catalog.dart';
import 'package:pickin_playmate/content/content_source.dart';
import 'package:pickin_playmate/content/content_type.dart';

class ContentRepository {
  final Map<(Instrument, ContentCategory), ContentSource> contentSources;

  ContentRepository({required this.contentSources});

  factory ContentRepository.create({Iterable<ContentSource>? contentSources}) {
    if (contentSources == null) {
      return ContentRepository.create(
        contentSources: [
          BanjoRollSource(),
          BanjoTechniqueSource(),
          GuitarStrumSource(),
          GuitarTechniqueSource(),
        ],
      );
    } else {
      return ContentRepository(
        contentSources: Map.fromIterable(
          contentSources,
          key: (source) => (source.instrument, source.category),
        ),
      );
    }
  }

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
    print('asdf');
    return await contentSources[(contentType.instrument, contentType.category)]!
        .retrieve(contentType);
  }
}
