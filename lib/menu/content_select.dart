import 'package:flutter/material.dart';
import 'package:libtab/libtab.dart';
import 'package:pickin_playmate/content/content_type.dart';

extension on ContentCategory {
  String label() {
    return switch (this) {
      ContentCategory.banjoRolls => 'Banjo Rolls',
      ContentCategory.guitarStrums => 'Guitar Strums',
      ContentCategory.songs => 'Songs',
      ContentCategory.techniques => 'Techniques',
    };
  }

  List<ContentType> options(Instrument instrument) {
    return switch (this) {
      ContentCategory.banjoRolls => BanjoRoll.values
          .map((banjoRoll) => BanjoRollContent(banjoRoll: banjoRoll))
          .toList(growable: false),
      ContentCategory.guitarStrums => GuitarStrum.values
          .map((guitarStrum) => GuitarStrumContent(guitarStrum: guitarStrum))
          .toList(growable: false),
      ContentCategory.songs => throw UnimplementedError(),
      ContentCategory.techniques => Technique.values
          .map((technique) =>
              TechniqueContent(instrument: instrument, technique: technique))
          .toList(growable: false),
    };
  }
}

typedef ContentTypeCallback = void Function(ContentType);

class ContentSelection extends StatelessWidget {
  final ContentType current;
  final FocusNode focusNode;
  final Instrument instrument;
  final ContentTypeCallback onSelectionFocus;

  const ContentSelection(
      {super.key,
      required this.current,
      required this.focusNode,
      required this.instrument,
      required this.onSelectionFocus});

  onFocus(ContentType focused) {
    onSelectionFocus(focused);
  }

  List<ContentCategory> get practiceCategories => switch (instrument) {
        Instrument.banjo => [
            ContentCategory.banjoRolls,
            ContentCategory.techniques
          ],
        Instrument.guitar => [
            ContentCategory.guitarStrums,
            ContentCategory.techniques
          ],
      };

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        width: (MediaQuery.sizeOf(context).width / 2) - 50,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 22,
          children: practiceCategories
              .map((category) => _ContentLinkList(
                  category: category,
                  current: current,
                  focusNode: focusNode,
                  onFocus: onFocus,
                  options: category.options(instrument)))
              .toList(growable: false),
        ),
      ),
      _ContentLinkList(
          category: ContentCategory.songs,
          current: current,
          focusNode: focusNode,
          onFocus: onFocus,
          options: []),
    ]);
  }
}

class _ContentLinkList extends StatelessWidget {
  final ContentCategory category;
  final ContentType current;
  final FocusNode? focusNode;
  final List<ContentType> options;
  final ContentTypeCallback onFocus;

  const _ContentLinkList(
      {required this.category,
      required this.current,
      required this.focusNode,
      required this.options,
      required this.onFocus});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(category.label(),
              style: TextStyle(
                fontSize: 25,
                fontVariations: [FontVariation.weight(500)],
              )),
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 7,
                children: options.indexed
                    .map<Widget>(
                        (i) => buildContentLink(i.$2, focusable: i.$1 == 0))
                    .toList(growable: false),
              ))
        ]);
  }

  Widget buildContentLink(ContentType contentType, {required bool focusable}) {
    final isCurrent = current == contentType;
    return _ContentLink(
        contentType: contentType,
        current: isCurrent,
        focusNode: isCurrent ? focusNode : null,
        onFocus: onFocus);
  }
}

class _ContentLink extends StatefulWidget {
  final ContentType contentType;
  final bool current;
  final FocusNode? focusNode;
  final ContentTypeCallback onFocus;

  const _ContentLink(
      {required this.contentType,
      this.current = false,
      this.focusNode,
      required this.onFocus});

  @override
  State<_ContentLink> createState() => _ContentLinkState();
}

class _ContentLinkState extends State<_ContentLink> {
  bool focused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
        autofocus: widget.current,
        focusNode: widget.focusNode,
        onFocusChange: (focused) {
          setState(() => this.focused = focused);
          widget.onFocus(widget.contentType);
        },
        child: Text(widget.contentType.label(),
            style: TextStyle(
                fontSize: 20,
                fontVariations: [FontVariation.weight(400)],
                color: focused ? Colors.white : null)));
  }
}
