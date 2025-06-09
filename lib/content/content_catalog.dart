import 'package:pickin_playmate/content/content_type.dart';

sealed class ContentCatalog {
  final List<ContentType> songs;
  final List<ContentType> techniques;

  ContentCatalog({required this.songs, required this.techniques});

  forEach(Function(ContentType) action) {
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
