import 'package:flutter/widgets.dart';
import 'package:pickin_playmate/controls/toggle.dart';

enum _PlayingMode {
  unstarted,
  playing,
  paused,
}

class PlayMode extends StatefulWidget {
  const PlayMode({super.key});

  @override
  State<PlayMode> createState() => _PlayModeState();
}

class _PlayModeState extends State<PlayMode> {
  _PlayingMode mode = _PlayingMode.unstarted;

  @override
  Widget build(BuildContext context) {
    return Toggle(
      onTap: () => setState(() => mode = switch (mode) {
            _PlayingMode.unstarted => _PlayingMode.playing,
            _PlayingMode.playing => _PlayingMode.paused,
            _PlayingMode.paused => _PlayingMode.playing,
          }),
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 50),
        child: switch (mode) {
          _PlayingMode.unstarted => ToggleIcons.play,
          _PlayingMode.playing => ToggleIcons.pause,
          _PlayingMode.paused => ToggleIcons.resume,
        },
      ),
    );
  }
}
