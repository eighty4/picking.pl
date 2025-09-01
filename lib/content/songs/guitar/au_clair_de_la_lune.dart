import 'package:libtab/libtab.dart';
import 'package:pickin_playmate/content/content_sources.dart';
import 'package:pickin_playmate/content/content_type.dart';

SourcedContent auClairDeLaLune() {
  return DelegateLoaderContent(
    contentType: SongContent(
      instrument: Instrument.guitar,
      song: "Au clair de la lune",
    ),
    loader: () => Future.value(_auClairDeLaLuneLoader()),
  );
}

List<Measure> _auClairDeLaLuneLoader() {
  return [
    // 1-4
    Measure.fromNoteList([
      Note(3, 0, timing: Timing.ofQuarterNote(1)),
      Note(3, 0, timing: Timing.ofQuarterNote(2)),
      Note(3, 0, timing: Timing.ofQuarterNote(3)),
      Note(3, 2, timing: Timing.ofQuarterNote(4)),
    ]),
    Measure.fromNoteList([
      Note(2, 0, timing: Timing.ofHalfNote(1)),
      Note(3, 2, timing: Timing.ofHalfNote(2)),
    ]),
    Measure.fromNoteList([
      Note(3, 0, timing: Timing.ofQuarterNote(1)),
      Note(2, 0, timing: Timing.ofQuarterNote(2)),
      Note(3, 2, timing: Timing.ofQuarterNote(3)),
      Note(3, 2, timing: Timing.ofQuarterNote(4)),
    ]),
    Measure.fromNoteList([Note(3, 0, timing: Timing.ofWholeNote(1))]),

    // 5-8
    Measure.fromNoteList([
      Note(3, 0, timing: Timing.ofQuarterNote(1)),
      Note(3, 0, timing: Timing.ofQuarterNote(2)),
      Note(3, 0, timing: Timing.ofQuarterNote(3)),
      Note(3, 2, timing: Timing.ofQuarterNote(4)),
    ]),
    Measure.fromNoteList([
      Note(2, 0, timing: Timing.ofHalfNote(1)),
      Note(3, 2, timing: Timing.ofHalfNote(2)),
    ]),
    Measure.fromNoteList([
      Note(3, 0, timing: Timing.ofQuarterNote(1)),
      Note(2, 0, timing: Timing.ofQuarterNote(2)),
      Note(3, 2, timing: Timing.ofQuarterNote(3)),
      Note(3, 2, timing: Timing.ofQuarterNote(4)),
    ]),
    Measure.fromNoteList([Note(3, 0, timing: Timing.ofWholeNote(1))]),

    // 9-12
    Measure.fromNoteList([
      Note(3, 2, timing: Timing.ofQuarterNote(1)),
      Note(3, 2, timing: Timing.ofQuarterNote(2)),
      Note(3, 2, timing: Timing.ofQuarterNote(3)),
      Note(3, 2, timing: Timing.ofQuarterNote(4)),
    ]),
    Measure.fromNoteList([
      Note(4, 2, timing: Timing.ofHalfNote(1)),
      Note(4, 2, timing: Timing.ofHalfNote(2)),
    ]),
    Measure.fromNoteList([
      Note(3, 2, timing: Timing.ofQuarterNote(1)),
      Note(3, 0, timing: Timing.ofQuarterNote(2)),
      Note(4, 4, timing: Timing.ofQuarterNote(3)),
      Note(4, 2, timing: Timing.ofQuarterNote(4)),
    ]),
    Measure.fromNoteList([Note(4, 0, timing: Timing.ofWholeNote(1))]),

    // 13-16
    Measure.fromNoteList([
      Note(3, 0, timing: Timing.ofQuarterNote(1)),
      Note(3, 0, timing: Timing.ofQuarterNote(2)),
      Note(3, 0, timing: Timing.ofQuarterNote(3)),
      Note(3, 2, timing: Timing.ofQuarterNote(4)),
    ]),
    Measure.fromNoteList([
      Note(2, 0, timing: Timing.ofHalfNote(1)),
      Note(3, 2, timing: Timing.ofHalfNote(2)),
    ]),
    Measure.fromNoteList([
      Note(3, 0, timing: Timing.ofQuarterNote(1)),
      Note(2, 0, timing: Timing.ofQuarterNote(2)),
      Note(3, 2, timing: Timing.ofQuarterNote(3)),
      Note(3, 2, timing: Timing.ofQuarterNote(4)),
    ]),
    Measure.fromNoteList([Note(3, 0, timing: Timing.ofWholeNote(1))]),
  ];
}
