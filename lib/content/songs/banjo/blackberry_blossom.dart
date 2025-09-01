import 'package:libtab/instrument.dart';
import 'package:libtab/measure.dart';
import 'package:libtab/note.dart';
import 'package:pickin_playmate/content/content_sources.dart';
import 'package:pickin_playmate/content/content_type.dart';

SourcedContent blackberryBlossom() {
  return DelegateLoaderContent(
    contentType: SongContent(
      instrument: Instrument.banjo,
      song: "Blackberry Blossom",
    ),
    loader: () => Future.value(_blackberryBlossomLoader()),
  );
}

List<Measure> _blackberryBlossomLoader() {
  return [
    // 1
    Measure.fromNoteList([
      Note(4, 5),
      Note(3, 0),
      Note(1, 0),
      Note(5, 0),
      Note(3, 0, and: Note(1, 0)),
      Note(3, 0),
      Note(5, 0),
      Note(1, 0),
    ]),
    // 2
    Measure.fromNoteList([
      Note(4, 5),
      Note(3, 0),
      Note(1, 0),
      Note(5, 0),
      Note(3, 0, and: Note(1, 0)),
      Note(3, 0),
      Note(5, 0),
      Note(1, 0),
    ]),
    // 3
    Measure.fromNoteList([
      Note(4, 5),
      Note(3, 0),
      Note(1, 0),
      Note(5, 0),
      Note(1, 0),
      Note(3, 0),
      Note(5, 0),
      Note(1, 0),
    ]),
    // 4
    Measure.fromNoteList([
      Note(4, 5),
      Note(3, 0),
      Note(1, 0),
      Note(5, 0),
      Note(3, 0),
      Note(3, 0),
      Note(1, 0),
      Note(3, 0),
    ]),
    // 5
    Measure.fromNoteList([
      Note(5, 0),
      Note(2, 10),
      Note(1, 9),
      Note(5, 0),
      Note(2, 7),
      Note(5, 0),
      Note(1, 7),
      Note(2, 7),
    ]),
    // 6
    Measure.fromNoteList([
      Note(3, 9),
      Note(2, 7),
      Note(5, 0),
      Note(2, 5),
      Note(1, 0),
      Note(2, 0),
      Note(3, 0),
      Note(1, 0),
    ]),
    // 7
    Measure.fromNoteList([
      Note(4, 2),
      Note(2, 1),
      Note(3, 0),
      Note(1, 0),
      Note(4, 0),
      Note(3, 0),
      Note(4, 5),
      Note(3, 2),
    ]),
    // 8
    Measure.fromNoteList([
      Note(2, 0),
      Note(4, 5),
      Note(3, 2),
      Note(2, 0),
      Note(3, 2),
      Note(1, 0),
      Note(2, 5),
      Note(1, 4),
    ]),
    // 9
    Measure.fromNoteList([
      Note(5, 0),
      Note(2, 10),
      Note(1, 9),
      Note(5, 0),
      Note(2, 7),
      Note(5, 0),
      Note(1, 7),
      Note(2, 7),
    ]),
    // 10
    Measure.fromNoteList([
      Note(3, 9),
      Note(2, 7),
      Note(5, 0),
      Note(3, 9),
      Note(1, 0),
      Note(2, 0),
      Note(3, 0),
      Note(1, 0),
      // Note(4, 0, timing: Timing.ofSixteenthNote(16), slideTo: 2),
    ]),
    // 11
    Measure.fromNoteList([
      Note(4, 2),
      Note(2, 1),
      Note(3, 0),
      Note(1, 0),
      Note(4, 0),
      Note(3, 0),
      Note(4, 5),
      Note(3, 2),
    ]),
    // 12
    Measure.fromNoteList([
      Note(2, 0),
      Note(4, 5),
      Note(3, 2),
      Note(4, 4),
      Note(3, 0),
      Note(3, 0),
      Note(1, 0),
      Note(3, 0),
    ]),
    // 13
    Measure.fromNoteList([
      Note(5, 0),
      Note(1, 9),
      Note(2, 10),
      Note(5, 0),
      Note(2, 7),
      Note(1, 7),
      Note(5, 0),
      Note(1, 4),
    ]),
    // 14
    Measure.fromNoteList([
      Note(2, 5),
      Note(5, 0),
      Note(1, 4),
      Note(2, 5),
      Note(1, 0),
      Note(2, 0),
      Note(3, 0),
      Note(1, 0),
      // Note(4, 0, timing: Timing.ofSixteenthNote(16), slideTo: 2),
    ]),
    // 15
    Measure.fromNoteList([
      Note(4, 2),
      Note(2, 1),
      Note(3, 0),
      Note(1, 0),
      Note(4, 0),
      Note(3, 0),
      Note(4, 5),
      Note(3, 2),
    ]),
    // 16
    Measure.fromNoteList([
      Note(2, 0),
      Note(4, 5),
      Note(3, 2),
      Note(2, 0),
      Note(3, 2),
      Note(1, 0),
      Note(2, 5),
      Note(1, 4),
    ]),
    // 17
    Measure.fromNoteList([
      Note(5, 0),
      Note(2, 10),
      Note(1, 9),
      Note(5, 0),
      Note(2, 7),
      Note(5, 0),
      Note(1, 7),
      Note(2, 7),
    ]),
    // 18
    Measure.fromNoteList([
      Note(3, 9),
      Note(2, 7),
      Note(5, 0),
      Note(3, 9),
      Note(1, 0),
      Note(2, 0),
      Note(3, 0),
      Note(1, 0),
    ]),
    // 19
    Measure.fromNoteList([
      Note(4, 2),
      Note(2, 1),
      Note(3, 0),
      Note(1, 0),
      Note(4, 0),
      Note(3, 0),
      Note(4, 5),
      Note(3, 2),
    ]),
    // 20
    Measure.fromNoteList([
      Note(2, 0),
      Note(4, 5),
      Note(3, 2),
      Note(4, 4),
      Note(3, 0),
      Note(3, 0),
      Note(4, 1),
      Note(3, 0),
    ]),
    // 21
    Measure.fromNoteList([
      Note(4, 2),
      Note(3, 0),
      Note(1, 2),
      Note(2, 0),
      Note(1, 0),
      Note(3, 0),
      Note(1, 2),
      Note(2, 0),
    ]),
    // 22
    Measure.fromNoteList([
      Note(4, 2),
      Note(3, 0),
      Note(1, 2),
      Note(2, 0),
      Note(1, 0),
      Note(2, 0),
      Note(4, 7),
      Note(3, 0),
    ]),
    // 23
    Measure.fromNoteList([
      Note(4, 2),
      Note(3, 0),
      Note(1, 2),
      Note(2, 0),
      Note(1, 0),
      Note(3, 0),
      Note(2, 5),
      Note(1, 4),
    ]),
    // 24
    Measure.fromNoteList([
      Note(5, 0),
      Note(2, 10),
      Note(1, 9),
      Note(5, 0),
      Note(2, 10),
      Note(5, 0),
      Note(3, 9),
      Note(1, 0),
    ]),
    // 25
    Measure.fromNoteList([
      Note(4, 0),
      Note(4, 2),
      Note(1, 2),
      Note(2, 0),
      Note(1, 0),
      Note(3, 0),
      Note(1, 2),
      Note(2, 0),
    ]),
    // 26
    Measure.fromNoteList([
      Note(4, 2),
      Note(3, 0),
      Note(1, 2),
      Note(2, 0),
      Note(1, 0),
      Note(2, 0),
      Note(3, 2),
      Note(3, 0),
    ]),
    // 27
    Measure.fromNoteList([
      Note(4, 2),
      Note(3, 0),
      Note(1, 2),
      Note(2, 0),
      Note(1, 0),
      Note(3, 0),
      Note(2, 5),
      Note(1, 0),
    ]),
    // 28
    Measure.fromNoteList([
      Note(2, 0),
      Note(4, 5),
      Note(3, 2),
      Note(4, 4),
      Note(3, 0),
      Note(3, 0),
      Note(4, 1),
      Note(3, 0),
    ]),
    // 29
    Measure.fromNoteList([
      Note(4, 2),
      Note(3, 0),
      Note(1, 2),
      Note(2, 0),
      Note(1, 0),
      Note(3, 0),
      Note(1, 2),
      Note(2, 0),
    ]),
    // 30
    Measure.fromNoteList([
      Note(4, 2),
      Note(3, 0),
      Note(1, 2),
      Note(2, 0),
      Note(1, 0),
      Note(2, 0),
      Note(4, 7),
      Note(3, 0),
    ]),
    // 31
    Measure.fromNoteList([
      Note(4, 2),
      Note(3, 0),
      Note(1, 2),
      Note(2, 0),
      Note(1, 0),
      Note(3, 0),
      Note(2, 5),
      Note(1, 4),
    ]),
    // 32
    Measure.fromNoteList([
      Note(5, 0),
      Note(2, 10),
      Note(1, 9),
      Note(5, 0),
      Note(2, 10),
      Note(5, 0),
      Note(3, 9),
      Note(1, 0),
    ]),
    // 33
    Measure.fromNoteList([
      Note(4, 0, hammerOn: 2),
      null,
      Note(1, 2),
      Note(2, 0),
      Note(1, 0),
      Note(3, 0),
      Note(1, 2),
      Note(2, 0),
    ]),
    // 34
    Measure.fromNoteList([
      Note(4, 2),
      Note(3, 0),
      Note(1, 2),
      Note(2, 0),
      Note(1, 0),
      Note(3, 2),
      Note(2, 2, slideTo: 3),
      Note(1, 5),
    ]),
    // 35
    Measure.fromNoteList([
      Note(5, 0),
      Note(2, 3),
      Note(1, 5),
      Note(5, 0),
      Note(2, 5),
      Note(1, 4),
      Note(5, 0),
      Note(2, 5),
    ]),
    // 36
    Measure.fromNoteList([
      Note(1, 0),
      Note(2, 0),
      Note(3, 2),
      Note(1, 0),
      Note(3, 0),
      Note(3, 0),
      Note(1, 0, and: Note(3, 0, and: Note(5, 0))),
      null,
    ]),
  ];
}
