import 'package:flutter/material.dart';
import 'package:pickin_playmate/controls.dart';
import 'package:pickin_playmate/header.dart';
import 'package:pickin_playmate/player.dart';

void main() {
  runApp(const PickingPlaymate());
}

class PickingPlaymate extends StatefulWidget {
  const PickingPlaymate({super.key});

  @override
  State<PickingPlaymate> createState() => _PickingPlaymateState();
}

class _PickingPlaymateState extends State<PickingPlaymate> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Color.fromARGB(255, 153, 35, 60),
      home: _PickingPlaymateLayout(),
      onGenerateTitle: (context) => 'Picking Playmate',
      theme: ThemeData(fontFamily: 'Raleway'),
    );
  }
}

class _PickingPlaymateLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const headerHeight = 100.0;
    const controlsHeight = 100.0;
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(children: [
        Positioned(
            top: 0,
            left: 0,
            width: size.width,
            height: headerHeight,
            child: const PickingHeader()),
        Positioned(
            top: headerHeight,
            bottom: controlsHeight,
            left: 0,
            width: size.width,
            child: const PickingPlayer()),
        Positioned(
            bottom: 0,
            left: 0,
            width: size.width,
            height: controlsHeight,
            child: const PickingControls()),
      ]),
    );
  }
}
