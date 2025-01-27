import 'package:libtab/libtab.dart';

enum ContentCategory {
  banjoRolls,
  guitarStrums,
  songs,
  techniques,
}

enum BanjoRoll { forward, backward, forwardBackward, alternatingThumb }

extension on BanjoRoll {
  String label() {
    return switch (this) {
      BanjoRoll.forward => 'Forward Roll',
      BanjoRoll.backward => 'Backward Roll',
      BanjoRoll.forwardBackward => 'Forward Backward Roll',
      BanjoRoll.alternatingThumb => 'Alternating Thumb Roll',
    };
  }
}

enum GuitarStrum {
  beachBoys,
  rem,
  theBeatles,
}

extension on GuitarStrum {
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
      Instrument.guitar =>
        GuitarStrumContent(guitarStrum: GuitarStrum.beachBoys),
    };
  }

  String label();
}

class BanjoRollContent extends ContentType {
  final BanjoRoll banjoRoll;

  BanjoRollContent({required this.banjoRoll})
      : super(
            category: ContentCategory.banjoRolls, instrument: Instrument.banjo);

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
            instrument: Instrument.guitar);

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

Measure getPickingContent(Instrument instrument) {
  final c = Note(2, 1, and: Note(4, 2, and: Note(5, 3)));
  final g = Note(1, 3, and: Note(5, 2, and: Note(6, 3)));
  final d = Note(1, 2, and: Note(2, 3, and: Note(3, 2)));
  return Measure.fromNoteList([c, c, null, g, g, d, d, null]);
}
