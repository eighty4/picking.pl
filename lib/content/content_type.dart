import 'package:libtab/libtab.dart';

enum ContentCategory {
  loadingPlaceholder,
  banjoRolls,
  guitarStrums,
  songs,
  techniques,
}

extension ContentCategoryLabel on ContentCategory {
  String label() {
    return switch (this) {
      ContentCategory.loadingPlaceholder => '',
      ContentCategory.banjoRolls => 'Banjo Rolls',
      ContentCategory.guitarStrums => 'Guitar Strums',
      ContentCategory.songs => 'Songs',
      ContentCategory.techniques => 'Techniques',
    };
  }
}

enum BanjoRoll { forward, backward, forwardBackward, alternatingThumb }

extension BanjoRollLabel on BanjoRoll {
  String label() {
    return switch (this) {
      BanjoRoll.forward => 'Forward Roll',
      BanjoRoll.backward => 'Backward Roll',
      BanjoRoll.forwardBackward => 'Forward Backward Roll',
      BanjoRoll.alternatingThumb => 'Alternating Thumb Roll',
    };
  }
}

enum GuitarStrum { beachBoys, rem, theBeatles }

extension GuitarStrumLabel on GuitarStrum {
  String label() {
    return 'Bum ditty yo';
  }
}

sealed class ContentType {
  final ContentCategory category;
  final Instrument instrument;

  ContentType({required this.category, required this.instrument});

  factory ContentType.initial(Instrument instrument) {
    return switch (instrument) {
      Instrument.banjo => BanjoRollContent(banjoRoll: BanjoRoll.forward),
      Instrument.guitar => GuitarStrumContent(
        guitarStrum: GuitarStrum.beachBoys,
      ),
    };
  }

  factory ContentType.fromCacheId(String cacheId) {
    final parts = cacheId.split('::');
    if (parts.length != 3) {
      throw ArgumentError('$cacheId is invalid');
    }
    final instrumentId = parts[0];
    final categoryId = parts[1];
    final contentId = parts[2];
    return switch (categoryId) {
      'BanjoRollContent' => BanjoRollContent(
        banjoRoll: switch (contentId) {
          'forward' => BanjoRoll.forward,
          'backward' => BanjoRoll.backward,
          'alternatingThumb' => BanjoRoll.alternatingThumb,
          'forwardBackward' => BanjoRoll.forwardBackward,
          _ => throw ArgumentError(
            '$contentId in $cacheId is not a banjo roll',
          ),
        },
      ),
      'GuitarStrumContent' => GuitarStrumContent(
        guitarStrum: switch (contentId) {
          'rem' => GuitarStrum.rem,
          'beachBoys' => GuitarStrum.beachBoys,
          'theBeatles' => GuitarStrum.theBeatles,
          _ => throw ArgumentError(
            '$contentId in $cacheId is not a guitar strum',
          ),
        },
      ),
      'SongContent' => SongContent(
        instrument: switch (instrumentId) {
          'Banjo' => Instrument.banjo,
          'Guitar' => Instrument.guitar,
          _ => throw ArgumentError(
            '$instrumentId in $cacheId is not an instrument',
          ),
        },
        song: contentId,
      ),
      'TechniqueContent' => TechniqueContent(
        instrument: switch (instrumentId) {
          'Banjo' => Instrument.banjo,
          'Guitar' => Instrument.guitar,
          _ => throw ArgumentError(
            '$instrumentId in $cacheId is not an instrument',
          ),
        },
        technique: switch (contentId) {
          'hammerOn' => Technique.hammerOn,
          'pullOff' => Technique.pullOff,
          'slide' => Technique.slide,
          _ => throw ArgumentError('$contentId in $cacheId is not a technique'),
        },
      ),
      _ => throw ArgumentError('$categoryId in $cacheId is unknown'),
    };
  }

  String cacheId() {
    return '${instrument.label()}::${runtimeType.toString()}::${switch (this) {
      (LoadingPlaceholder _) => throw ArgumentError('cache id for loading is not supported'),
      (BanjoRollContent c) => c.banjoRoll.name,
      (GuitarStrumContent c) => c.guitarStrum.name,
      (SongContent c) => c.song,
      (TechniqueContent c) => c.technique.name,
    }}';
  }

  String label();
}

class LoadingPlaceholder extends ContentType {
  LoadingPlaceholder({required super.instrument})
    : super(category: ContentCategory.loadingPlaceholder);

  @override
  String label() {
    return '';
  }
}

class BanjoRollContent extends ContentType {
  final BanjoRoll banjoRoll;

  BanjoRollContent({required this.banjoRoll})
    : super(category: ContentCategory.banjoRolls, instrument: Instrument.banjo);

  @override
  String label() => banjoRoll.label();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BanjoRollContent &&
          runtimeType == other.runtimeType &&
          banjoRoll == other.banjoRoll;

  @override
  int get hashCode => banjoRoll.hashCode;
}

class GuitarStrumContent extends ContentType {
  final GuitarStrum guitarStrum;

  GuitarStrumContent({required this.guitarStrum})
    : super(
        category: ContentCategory.guitarStrums,
        instrument: Instrument.guitar,
      );

  @override
  String label() => guitarStrum.label();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GuitarStrumContent &&
          runtimeType == other.runtimeType &&
          guitarStrum == other.guitarStrum;

  @override
  int get hashCode => guitarStrum.hashCode;
}

class SongContent extends ContentType {
  final String song;

  SongContent({required super.instrument, required this.song})
    : super(category: ContentCategory.songs);

  @override
  String label() => song;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongContent &&
          runtimeType == other.runtimeType &&
          instrument == other.instrument &&
          song == other.song;

  @override
  int get hashCode => instrument.hashCode ^ song.hashCode;
}

class TechniqueContent extends ContentType {
  final Technique technique;

  TechniqueContent({required super.instrument, required this.technique})
    : super(category: ContentCategory.techniques);

  @override
  String label() => switch (technique) {
    Technique.hammerOn => 'Hammer-on',
    Technique.pullOff => 'Pull-off',
    Technique.slide => 'Slide',
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TechniqueContent &&
          runtimeType == other.runtimeType &&
          instrument == other.instrument &&
          technique == other.technique;

  @override
  int get hashCode => instrument.hashCode ^ technique.hashCode;
}
