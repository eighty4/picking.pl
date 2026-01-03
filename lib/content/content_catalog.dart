import 'package:libtab/instrument.dart';
import 'package:libtab/technique.dart';
import 'package:pickin_playmate/content/content_sources.dart';
import 'package:pickin_playmate/content/content_type.dart';

class ContentCatalogIndex {
  final List<SongContent> _banjoSongs = [];
  final List<SongContent> _guitarSongs = [];
  final Future<List<SongContent>> _songsLoading;

  ContentCatalogIndex({required SourcedContentCollection collection})
    : _songsLoading = collection.songs() {
    _songsLoading.then(_setSongs);
  }

  void _setSongs(List<SongContent> songs) {
    for (final song in songs) {
      (switch (song.instrument) {
        Instrument.banjo => _banjoSongs,
        Instrument.guitar => _guitarSongs,
      }).add(song);
    }
  }

  Future<ContentCatalog> retrieve(Instrument instrument) async {
    return switch (instrument) {
      Instrument.banjo => _buildBanjoCatalog(),
      Instrument.guitar => _buildGuitarCatalog(),
    };
  }

  Future<BanjoContentCatalog> _buildBanjoCatalog() async {
    return BanjoContentCatalog(
      banjoRolls: BanjoRoll.values
          .map((banjoRoll) => BanjoRollContent(banjoRoll: banjoRoll))
          .toList(growable: false),
      songs: await _collectSongContent(Instrument.banjo),
      techniques: _collectTechniqueContent(Instrument.banjo),
    );
  }

  Future<GuitarContentCatalog> _buildGuitarCatalog() async {
    return GuitarContentCatalog(
      guitarStrums: GuitarStrum.values
          .map((guitarStrum) => GuitarStrumContent(guitarStrum: guitarStrum))
          .toList(growable: false),
      songs: await _collectSongContent(Instrument.guitar),
      techniques: _collectTechniqueContent(Instrument.guitar),
    );
  }

  Future<List<ContentType>> _collectSongContent(Instrument instrument) async {
    await _songsLoading;
    return switch (instrument) {
      Instrument.banjo => _banjoSongs,
      Instrument.guitar => _guitarSongs,
    };
  }

  List<ContentType> _collectTechniqueContent(Instrument instrument) {
    return Technique.values
        .map(
          (technique) =>
              TechniqueContent(instrument: instrument, technique: technique),
        )
        .toList(growable: false);
  }
}

sealed class ContentCatalog {
  final List<ContentType> songs;
  final List<ContentType> techniques;

  ContentCatalog({required this.songs, required this.techniques});

  void forEach(Function(ContentType) action) {
    (switch (this) {
      (BanjoContentCatalog c) => c.banjoRolls,
      (GuitarContentCatalog c) => c.guitarStrums,
    }).forEach(action);
    songs.forEach(action);
    techniques.forEach(action);
  }
}

class BanjoContentCatalog extends ContentCatalog {
  final List<ContentType> banjoRolls;

  BanjoContentCatalog({
    required this.banjoRolls,
    required super.songs,
    required super.techniques,
  });
}

class GuitarContentCatalog extends ContentCatalog {
  final List<ContentType> guitarStrums;

  GuitarContentCatalog({
    required this.guitarStrums,
    required super.songs,
    required super.techniques,
  });
}
