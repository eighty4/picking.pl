import 'package:flutter/material.dart';
import 'package:pickin_playmate/content/content_catalog.dart';
import 'package:pickin_playmate/content/content_repository.dart';
import 'package:pickin_playmate/content/content_type.dart';

class ContentCatalogLookup extends StatefulWidget {
  final Widget Function(BuildContext context, ContentCatalog catalog) builder;
  final ContentRepository contentRepository;
  final ContentType contentType;

  const ContentCatalogLookup({
    super.key,
    required this.builder,
    required this.contentRepository,
    required this.contentType,
  });

  @override
  State<ContentCatalogLookup> createState() => _ContentCatalogLookupState();
}

class _ContentCatalogLookupState extends State<ContentCatalogLookup> {
  late Future<ContentCatalog> _catalog;

  @override
  void initState() {
    super.initState();
    _catalog = widget.contentRepository.retrieveContentCatalog(
      widget.contentType.instrument,
    );
  }

  @override
  void didUpdateWidget(ContentCatalogLookup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.contentType.instrument != oldWidget.contentType.instrument) {
      setState(() {
        _catalog = widget.contentRepository.retrieveContentCatalog(
          widget.contentType.instrument,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _catalog,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          throw snapshot.error!;
        } else if (snapshot.hasData) {
          return widget.builder(context, snapshot.data!);
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
