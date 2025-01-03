import 'package:flutter/material.dart';

class PickingControls extends StatefulWidget {
  const PickingControls({super.key});

  @override
  State<PickingControls> createState() => _PickingControlsState();
}

class _PickingControlsState extends State<PickingControls> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Pause',
            style: TextStyle(
                fontSize: 32,
                fontVariations: [FontVariation.weight(500)],
                color: Colors.black87)),
        Text('Looping',
            style: TextStyle(
                fontSize: 32,
                fontVariations: [FontVariation.weight(500)],
                color: Colors.black87)),
        Text('Metronome',
            style: TextStyle(
                fontSize: 32,
                fontVariations: [FontVariation.weight(500)],
                color: Colors.black87)),
        Text('Contextual (chords, next / prev)',
            style: TextStyle(
                fontSize: 32,
                fontVariations: [FontVariation.weight(500)],
                color: Colors.black87)),
      ]),
    );
  }
}
