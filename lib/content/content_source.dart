import 'package:libtab/libtab.dart';
import 'package:pickin_playmate/content/content_type.dart';

abstract class ContentSource<T extends ContentType> {
  final Instrument instrument;
  final ContentCategory category;

  ContentSource({required this.instrument, required this.category});

  Future<Measure> retrieve(T contentType);
}

class BanjoRollSource extends ContentSource<BanjoRollContent> {
  BanjoRollSource()
    : super(instrument: Instrument.banjo, category: ContentCategory.banjoRolls);

  @override
  Future<Measure> retrieve(BanjoRollContent contentType) async {
    return switch (contentType.banjoRoll) {
      BanjoRoll.forward => Measure.fromNoteList([
        Note(3, 0),
        Note(2, 0),
        Note(1, 0),
        Note(3, 0),
        Note(2, 0),
        Note(1, 0),
        Note(3, 0),
        Note(2, 0),
      ]),
      BanjoRoll.backward => Measure.fromNoteList([
        Note(1, 0),
        Note(2, 0),
        Note(3, 0),
        Note(1, 0),
        Note(2, 0),
        Note(3, 0),
        Note(1, 0),
        Note(5, 0),
      ]),
      BanjoRoll.forwardBackward => Measure.fromNoteList([
        Note(3, 0),
        Note(2, 0),
        Note(1, 0),
        Note(5, 0),
        Note(1, 0),
        Note(2, 0),
        Note(3, 0),
        Note(1, 0),
      ]),
      BanjoRoll.alternatingThumb => Measure.fromNoteList([
        Note(3, 0),
        Note(2, 0),
        Note(5, 0),
        Note(1, 0),
        Note(3, 0),
        Note(2, 0),
        Note(5, 0),
        Note(1, 0),
      ]),
    };
  }
}

class BanjoTechniqueSource extends ContentSource<TechniqueContent> {
  BanjoTechniqueSource()
    : super(instrument: Instrument.banjo, category: ContentCategory.techniques);

  @override
  Future<Measure> retrieve(TechniqueContent contentType) async {
    return switch (contentType.technique) {
      Technique.hammerOn => Measure.fromNoteList([
        Note(1, 0, hammerOn: 1),
        null,
        Note(2, 0, hammerOn: 1),
        null,
        Note(3, 0, hammerOn: 1),
        null,
        Note(4, 0, hammerOn: 1),
        null,
      ]),
      Technique.pullOff => Measure.fromNoteList([
        Note(1, 2, pullOff: 0),
        null,
        Note(2, 2, pullOff: 0),
        null,
        Note(3, 2, pullOff: 0),
        null,
        Note(4, 2, pullOff: 0),
        null,
      ]),
      Technique.slide => Measure.fromNoteList([
        Note(1, 0, slideTo: 1),
        null,
        Note(2, 0, slideTo: 1),
        null,
        Note(3, 0, slideTo: 1),
        null,
        Note(4, 0, slideTo: 1),
        null,
      ]),
    };
  }
}

class GuitarStrumSource extends ContentSource<GuitarStrumContent> {
  GuitarStrumSource()
    : super(
        instrument: Instrument.guitar,
        category: ContentCategory.guitarStrums,
      );

  @override
  Future<Measure> retrieve(GuitarStrumContent contentType) async {
    throw UnsupportedError('not yet implemented');
  }
}

class GuitarTechniqueSource extends ContentSource<TechniqueContent> {
  GuitarTechniqueSource()
    : super(
        instrument: Instrument.guitar,
        category: ContentCategory.techniques,
      );

  @override
  Future<Measure> retrieve(TechniqueContent contentType) async {
    return switch (contentType.technique) {
      Technique.hammerOn => Measure.fromNoteList([
        Note(5, 0, hammerOn: 1),
        null,
        Note(4, 0, hammerOn: 1),
        null,
        Note(3, 0, hammerOn: 1),
        null,
        Note(2, 0, hammerOn: 1),
        null,
      ]),
      Technique.pullOff => Measure.fromNoteList([
        Note(5, 2, pullOff: 0),
        null,
        Note(4, 2, pullOff: 0),
        null,
        Note(3, 2, pullOff: 0),
        null,
        Note(2, 2, pullOff: 0),
        null,
      ]),
      Technique.slide => Measure.fromNoteList([
        Note(5, 0, slideTo: 1),
        null,
        Note(4, 0, slideTo: 1),
        null,
        Note(3, 0, slideTo: 1),
        null,
        Note(2, 0, slideTo: 1),
        null,
      ]),
    };
  }
}
