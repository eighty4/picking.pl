import 'package:flutter/material.dart';

class Metronome extends StatefulWidget {
  const Metronome({super.key});

  @override
  State<Metronome> createState() => _MetronomeState();
}

class _MetronomeState extends State<Metronome> {
  double value = .2;

  @override
  Widget build(BuildContext context) {
    return Slider(
        value: value, onChanged: (value) => setState(() => this.value = value));
  }
}
