import 'package:flutter/material.dart';
import 'package:libtab/libtab.dart';
import 'package:pickin_playmate/content.dart';
import 'package:pickin_playmate/controls/menu.dart';

class ContentSelection extends StatefulWidget {
  static const List<(ContentType, String)> banjoContentTypes = [
    (ContentType.banjoRolls, 'Rolls'),
    (ContentType.techniques, 'Techniques'),
    (ContentType.songs, 'Songs'),
  ];

  static const List<(ContentType, String)> guitarContentTypes = [
    (ContentType.guitarStrums, 'Strumming'),
    (ContentType.techniques, 'Techniques'),
    (ContentType.songs, 'Songs'),
  ];

  final Instrument instrument;

  const ContentSelection({super.key, required this.instrument});

  @override
  State<ContentSelection> createState() => _ContentSelectionState();
}

class _ContentSelectionState extends State<ContentSelection> {
  ContentType type = ContentType.techniques;

  @override
  Widget build(BuildContext context) {
    final contentTypes = switch (widget.instrument) {
      Instrument.banjo => ContentSelection.banjoContentTypes,
      Instrument.guitar => ContentSelection.guitarContentTypes,
    };
    return Row(spacing: 40, children: [
      Menu(
          dropdownWidth: 120,
          onSelect: (i) => setState(() => type = contentTypes[i].$1),
          options: contentTypes
              .map((contentType) => contentType.$2)
              .toList(growable: false),
          selected: contentTypes.firstWhere((ct) => ct.$1 == type).$2),
      Text(material,
          style: TextStyle(
              fontSize: 32,
              fontVariations: [FontVariation.weight(500)],
              color: Colors.black87)),
    ]);
  }

  String get material => switch (type) {
        ContentType.banjoRolls => 'Forward Roll',
        ContentType.guitarStrums => 'Boom-chick',
        ContentType.techniques => switch (widget.instrument) {
            Instrument.banjo => 'Slide',
            Instrument.guitar => 'Hammer-on',
          },
        ContentType.songs => switch (widget.instrument) {
            Instrument.banjo => 'Cripple Creek',
            Instrument.guitar => 'Whiskey Before Breakfast',
          }
      };
}
