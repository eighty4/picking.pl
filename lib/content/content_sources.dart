import 'package:libtab/libtab.dart';
import 'package:pickin_playmate/content/content_type.dart';

class SourcedContentCollection {
  Map<ContentType, SourcedContent> _content = {};
  final Future<List<SourcedContent>> _resultsLoading;

  SourcedContentCollection.loadFrom({required List<ContentSource> sources})
    : _resultsLoading = Future.wait<List<SourcedContent>>(
        sources.map((s) => s.load()),
      ).then((listsOfContent) => listsOfContent.expand((l) => l).toList()) {
    _resultsLoading.then(
      (content) => {
        _content = {for (var content in content) content.contentType: content},
      },
    );
  }

  Future<SourcedContent> retrieve(ContentType contentType) async {
    await _resultsLoading;
    return _content[contentType]!;
  }

  Future<List<SongContent>> songs() async {
    await _resultsLoading;
    return _content.values
        .map(
          (content) => switch (content.contentType) {
            (SongContent type) => type,
            _ => null,
          },
        )
        .whereType<SongContent>()
        .toList(growable: false);
  }
}

abstract class ContentSource {
  Future<List<SourcedContent>> load();
}

abstract class SourcedContent<T extends ContentType> {
  final T contentType;
  SourcedContent({required this.contentType});

  Future<List<Measure>> load();
}

class DelegateLoaderContent extends SourcedContent {
  final Future<List<Measure>> Function() loader;
  DelegateLoaderContent({required super.contentType, required this.loader});

  @override
  Future<List<Measure>> load() async {
    return await loader();
  }
}
