import 'package:flutter/material.dart';
import 'package:pickin_playmate/content/content_catalog.dart';
import 'package:pickin_playmate/content/content_type.dart';

class ContentCatalogLookup extends StatefulWidget {
  final Widget Function(BuildContext context, ContentCatalog catalog) builder;
  final ContentCatalogIndex catalogIndex;
  final ContentType contentType;

  const ContentCatalogLookup({
    super.key,
    required this.builder,
    required this.catalogIndex,
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
    updateCatalog();
  }

  @override
  void didUpdateWidget(ContentCatalogLookup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.contentType.instrument != oldWidget.contentType.instrument) {
      setState(() => updateCatalog());
    }
  }

  void updateCatalog() {
    _catalog = widget.catalogIndex.retrieve(widget.contentType.instrument);
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
