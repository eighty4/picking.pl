import 'package:pickin_playmate/content/content_sources.dart';
import 'package:pickin_playmate/content/songs/banjo/blackberry_blossom.dart';
import 'package:pickin_playmate/content/songs/guitar/au_clair_de_la_lune.dart';

class InitialBanjoSongs extends ContentSource {
  @override
  Future<List<SourcedContent>> load() {
    return Future.value([blackberryBlossom()]);
  }
}

class InitialGuitarSongs extends ContentSource {
  @override
  Future<List<SourcedContent>> load() {
    return Future.value([auClairDeLaLune()]);
  }
}
