import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pickin_playmate/controls/metronome.dart';
import 'package:pickin_playmate/controls/play_mode.dart';
import 'package:pickin_playmate/controls/toggle.dart';

class PickingControls extends StatefulWidget {
  const PickingControls({super.key});

  @override
  State<PickingControls> createState() => _PickingControlsState();
}

class _PickingControlsState extends State<PickingControls> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: min(1100.0, MediaQuery.sizeOf(context).width * .8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PlayMode(),
            Metronome(),
            ToggleGroup(
              toggles: [
                Toggle(enabled: false, child: ToggleIcons.previous),
                Toggle(child: ToggleIcons.next),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
