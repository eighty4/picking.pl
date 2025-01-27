import 'dart:math';

import 'package:flutter/material.dart';
import 'package:libtab/libtab.dart';
import 'package:pickin_playmate/content/content_type.dart';

class PickingPlayer extends StatefulWidget {
  final ContentType contentType;

  const PickingPlayer({super.key, required this.contentType});

  @override
  State<PickingPlayer> createState() => _PickingPlayerState();
}

class _PickingPlayerState extends State<PickingPlayer> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: MeasureDisplay(getPickingContent(Instrument.guitar),
            instrument: Instrument.guitar,
            tabContext: TabContext.forBrightness(Brightness.light),
            size: measureSize(context)));
  }

  Size measureSize(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = min(1100.0, size.width * .8);
    final height = min(550.0, (size.height - 200) * .7);
    return Size(width, height);
  }
}
