import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickin_playmate/content/catalog_lookup.dart';
import 'package:pickin_playmate/content/content_repository.dart';
import 'package:pickin_playmate/content/content_type.dart';

class PickingSideMenu extends StatelessWidget {
  static const double width = 400;

  final ContentRepository contentRepository;
  final ContentType currentContentType;
  final Function(ContentType contentType, {required bool closeMenu})
  onContentSelection;

  const PickingSideMenu({
    super.key,
    required this.contentRepository,
    required this.currentContentType,
    required this.onContentSelection,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12, width: 1),
        color: Colors.deepOrangeAccent,
      ),
      child: ContentCatalogLookup(
        contentRepository: contentRepository,
        contentType: currentContentType,
        builder: (context, catalog) {
          return _ContentMenuList(
            catalog: catalog,
            currentContentType: currentContentType,
            onContentSelection: (contentType) =>
                onContentSelection(contentType, closeMenu: false),
          );
        },
      ),
    );
  }
}

class _ContentMenuList extends StatefulWidget {
  final ContentCatalog catalog;
  final ContentType currentContentType;
  final Function(ContentType contentType) onContentSelection;

  const _ContentMenuList({
    required this.catalog,
    required this.currentContentType,
    required this.onContentSelection,
  });

  @override
  State<_ContentMenuList> createState() => _ContentMenuListState();
}

class _ContentMenuListState extends State<_ContentMenuList> {
  final Map<ContentType, FocusNode> _focusNodes = {};
  late ContentType _focused;

  @override
  void initState() {
    super.initState();
    updateState();
  }

  @override
  void didUpdateWidget(_ContentMenuList oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateState();
  }

  updateState() {
    _focused = widget.currentContentType;
    for (final content in widget.catalog.content[ContentCategory.songs]!) {
      _focusNodes[content] = FocusNode();
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (final focusNode in _focusNodes.values) {
      focusNode.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      autofocus: true,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildListHeader('Songs'),
            SizedBox(height: 5),
            ...buildSongList(),
          ],
        ),
      ),
    );
  }

  List<Widget> buildSongList() {
    return widget.catalog.content[ContentCategory.songs]!
        .map(buildListItem)
        .toList();
  }

  Widget buildListHeader(String label) {
    return Center(child: Text(label, style: TextTheme.of(context).titleSmall));
  }

  Widget buildListItem(ContentType content) {
    return CallbackShortcuts(
      bindings: {
        SingleActivator(LogicalKeyboardKey.enter): () =>
            widget.onContentSelection(content),
      },
      child: GestureDetector(
        onTap: () {
          widget.onContentSelection(content);
        },
        child: MouseRegion(
          cursor: content == widget.currentContentType
              ? SystemMouseCursors.basic
              : SystemMouseCursors.click,
          onEnter: (_) => _focusNodes[content]!.requestFocus(),
          child: Focus(
            autofocus: content == widget.currentContentType,
            focusNode: _focusNodes[content]!,
            onFocusChange: (focused) {
              if (focused) {
                setState(() => _focused = content);
              }
            },
            child: Text(
              content.label(),
              style: listItemTextStyle(context, content),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle listItemTextStyle(BuildContext context, ContentType content) {
    TextStyle style = TextTheme.of(context).bodySmall!;
    List<FontVariation>? fontVariations;
    Color? color;
    if (content == widget.currentContentType) {
      fontVariations = [FontVariation.weight(500)];
    }
    if (content == _focused) {
      color = Colors.yellowAccent;
    }
    if (fontVariations == null && color == null) {
      return style;
    }
    return style.copyWith(fontVariations: fontVariations, color: color);
  }
}
