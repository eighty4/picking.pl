import 'package:flutter/material.dart';
import 'package:libtab/instrument.dart';
import 'package:pickin_playmate/content/content_catalog.dart';
import 'package:pickin_playmate/content/content_repository.dart';
import 'package:pickin_playmate/content/content_type.dart';
import 'package:pickin_playmate/launch.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// PickingDataCache syncs content info with the platform's cache storage.
class PickingDataCache {
  static _cacheOptions() {
    return SharedPreferencesWithCacheOptions(
      allowList: {
        'ppl.content',
        ...Instrument.values.map(
          (instrument) => 'ppl.content.${instrument.label()}',
        ),
      },
    );
  }

  static clear() async {
    await SharedPreferencesAsync().clear();
  }

  final Future<SharedPreferencesWithCache> _cache;

  PickingDataCache()
    : _cache = SharedPreferencesWithCache.create(cacheOptions: _cacheOptions());

  Future<ContentType?> loadContentType({Instrument? instrument}) async {
    final cacheKey = instrument == null
        ? 'ppl.content'
        : 'ppl.content.${instrument.label()}';
    try {
      return switch ((await _cache).getString(cacheKey)) {
        (String cacheId) => ContentType.fromCacheId(cacheId),
        null => null,
      };
    } catch (_) {
      return null;
    }
  }

  saveContentType(ContentType contentType) {
    final cacheId = contentType.cacheId();
    _cache.then((cache) {
      try {
        cache.setString('ppl.content', cacheId);
        cache.setString(
          'ppl.content.${contentType.instrument.label()}',
          cacheId,
        );
      } catch (_) {}
    });
  }
}

class PickingAppData {
  final ContentCatalogIndex catalogIndex;
  final ContentRepository contentRepository;
  final ContentType contentType;
  final Function(ContentType contentType) onContentSelection;
  final Function(Instrument instrument) onInstrumentSelection;
  final bool returnUser;

  PickingAppData({
    required this.catalogIndex,
    required this.contentRepository,
    required this.contentType,
    required this.onContentSelection,
    required this.onInstrumentSelection,
    required this.returnUser,
  });

  Instrument get instrument => contentType.instrument;
}

class PickingDataCore extends StatefulWidget {
  final Widget Function(BuildContext context, PickingAppData appData) builder;
  final PickingDataCache cache;
  final PickingLaunchData launchData;

  PickingDataCore({super.key, required this.builder, required this.launchData})
    : cache = launchData.cache;

  @override
  State<PickingDataCore> createState() => _PickingDataCoreState();
}

class _PickingDataCoreState extends State<PickingDataCore> {
  late ContentType contentType;

  @override
  void initState() {
    super.initState();
    contentType = widget.launchData.currentContentType;
  }

  onContentSelection(ContentType contentType, {bool cache = true}) {
    setState(() => this.contentType = contentType);
    if (cache && contentType.category != ContentCategory.loadingPlaceholder) {
      widget.cache.saveContentType(contentType);
    }
  }

  onInstrumentSelection(Instrument instrument) {
    onContentSelection(LoadingPlaceholder(instrument: instrument));
    widget.cache
        .loadContentType(instrument: instrument)
        .then(
          (content) => onContentSelection(
            content ?? ContentType.initial(instrument),
            cache: false,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      PickingAppData(
        catalogIndex: widget.launchData.catalogIndex,
        contentRepository: widget.launchData.contentRepository,
        contentType: contentType,
        onContentSelection: onContentSelection,
        onInstrumentSelection: onInstrumentSelection,
        returnUser: widget.launchData.returnUser,
      ),
    );
  }
}
