import 'dart:math';

import 'package:flutter/material.dart';
import 'package:libtab/libtab.dart';

class PickingPlayer extends StatefulWidget {
  const PickingPlayer({super.key});

  @override
  State<PickingPlayer> createState() => _PickingPlayerState();
}

class _PickingPlayerState extends State<PickingPlayer> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: MeasureDisplay(Measure(notes: []),
            instrument: Instrument.guitar,
            tabContext: TabContext.forBrightness(Brightness.light),
            size: measureSize(context)));
  }

  Size measureSize(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = min(800.0, size.width * .75);
    final height = width / 2;
    return Size(width, height);
  }
}
