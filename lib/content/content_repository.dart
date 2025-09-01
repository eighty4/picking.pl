import 'package:libtab/libtab.dart';
import 'package:pickin_playmate/content/content_sources.dart';
import 'package:pickin_playmate/content/content_type.dart';

class ContentRepository {
  final SourcedContentCollection collection;

  ContentRepository({required this.collection});

  Future<List<Measure>> retrieveContent(ContentType contentType) async {
    if (contentType.category == ContentCategory.songs) {
      final content = await collection.retrieve(contentType);
      return await content.load();
    }
    if (contentType.instrument == Instrument.banjo) {
      return [
        Measure.fromNoteList([
          Note(3, 0),
          Note(2, 2),
          Note(1, 0),
          Note(3, 0),
          Note(2, 2),
          Note(1, 0),
          Note(3, 0),
          Note(2, 2),
        ]),
      ];
    } else {
      final c = Note(2, 1, and: Note(4, 2, and: Note(5, 3)));
      final g = Note(1, 3, and: Note(5, 2, and: Note(6, 3)));
      final d = Note(1, 2, and: Note(2, 3, and: Note(3, 2)));
      return [
        Measure.fromNoteList([c, c, null, g, g, d, d, null]),
      ];
    }
  }
}
