import 'package:libtab/libtab.dart';

enum ContentType {
  banjoRolls,
  guitarStrums,
  songs,
  techniques,
}

Measure getPickingContent(Instrument instrument) {
  final c = Note(2, 1, and: Note(4, 2, and: Note(5, 3)));
  final g = Note(1, 3, and: Note(5, 2, and: Note(6, 3)));
  final d = Note(1, 2, and: Note(2, 3, and: Note(3, 2)));
  return Measure.fromNoteList([c, c, null, g, g, d, d, null]);
}
