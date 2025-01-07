import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:libtab/instrument.dart';
import 'package:pickin_playmate/controls/content_select.dart';
import 'package:pickin_playmate/controls/toggle.dart';

class PickingHeader extends StatefulWidget {
  const PickingHeader({super.key});

  @override
  State<PickingHeader> createState() => _PickingHeaderState();
}

class _PickingHeaderState extends State<PickingHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(spacing: 20, children: [
              Text('Picking',
                  style: TextStyle(
                      fontSize: 42,
                      fontVariations: [FontVariation.weight(600)],
                      color: Colors.black87)),
              _InstrumentIcon(instrument: Instrument.guitar, dimension: 60),
            ]),
            ContentSelection(instrument: Instrument.guitar),
            Toggle(child: ToggleIcons.settings),
          ]),
    );
  }
}

class _InstrumentIcon extends StatelessWidget {
  final Instrument instrument;
  final double dimension;

  const _InstrumentIcon({required this.instrument, required this.dimension});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
        dimension: dimension,
        child: switch (instrument) {
          Instrument.banjo => SvgPicture.asset('assets/instruments/Banjo.svg',
              semanticsLabel: 'Banjo'),
          Instrument.guitar => SvgPicture.asset('assets/instruments/Guitar.svg',
              semanticsLabel: 'Guitar'),
        });
  }
}
