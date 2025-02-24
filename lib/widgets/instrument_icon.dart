import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:libtab/instrument.dart';

class InstrumentIcon extends StatelessWidget {
  final double dimension;
  final Instrument instrument;

  const InstrumentIcon({
    super.key,
    required this.dimension,
    required this.instrument,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: switch (instrument) {
        Instrument.banjo => SvgPicture.asset(
          'assets/instruments/Banjo.svg',
          semanticsLabel: 'Banjo',
        ),
        Instrument.guitar => SvgPicture.asset(
          'assets/instruments/Guitar.svg',
          semanticsLabel: 'Guitar',
        ),
      },
    );
  }
}
