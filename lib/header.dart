import 'package:flutter/material.dart';
import 'package:libtab/instrument.dart';
import 'package:pickin_playmate/widgets/instrument_icon.dart';

class PickingHeader extends StatelessWidget {
  final Instrument instrument;

  const PickingHeader({super.key, required this.instrument});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(spacing: 20, children: [
              Text('Picking', style: TextTheme.of(context).titleMedium),
              InstrumentIcon(dimension: 60, instrument: instrument),
            ]),
          ]),
    );
  }
}
