import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:libtab/instrument.dart';
import 'package:pickin_playmate/widgets/instrument_icon.dart';
import 'package:pickin_playmate/widgets/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// PickingUserData contains user session data such as the user's current
/// Instrument that is cached on device with shared_preferences package.
///
/// This will eventually include time spent playing techniques and chords
/// to generate content.
class PickingUserData {
  static Future<PickingUserData?> load() async {
    final sp = SharedPreferencesAsync();
    if (kDebugMode) {
      await sp.clear();
    }
    Instrument? instrument = switch (await sp.getString('ppl.instrument')) {
      'Banjo' => Instrument.banjo,
      'Guitar' => Instrument.guitar,
      _ => null,
    };
    if (instrument == null) {
      return null;
    }
    return PickingUserData(instrument: instrument, returnUser: true);
  }

  static saveInstrument(Instrument instrument) => SharedPreferencesAsync()
      .setString('ppl.instrument', instrument.label())
      .then((_) {})
      .catchError((_) {});

  Instrument instrument;
  bool returnUser;

  PickingUserData({required this.instrument, required this.returnUser});
}

class PickingLaunch extends StatefulWidget {
  final Widget Function(BuildContext, PickingUserData) builder;

  const PickingLaunch({super.key, required this.builder});

  @override
  State<PickingLaunch> createState() => _PickingLaunchState();
}

class _PickingLaunchState extends State<PickingLaunch> {
  /// Future used by FutureBuilder for launching the app from a user's previous
  /// session's data.
  Future<PickingUserData?> loadingUserData = PickingUserData.load();

  /// When PickingUserData future returns nothing, set the result of
  /// _PickingLaunchInstrumentSelect here and launch dat app.
  Instrument? selectedInstrument;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadingUserData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox.shrink();
        }
        if (snapshot.data != null) {
          return widget.builder(context, snapshot.data!);
        }
        if (selectedInstrument == null) {
          return _PickingLaunchInstrumentSelect(
            onInstrumentSelect: (instrument) {
              PickingUserData.saveInstrument(instrument);
              setState(() => selectedInstrument = instrument);
            },
          );
        } else {
          return widget.builder(
            context,
            PickingUserData(instrument: selectedInstrument!, returnUser: false),
          );
        }
      },
    );
  }
}

class _PickingLaunchInstrumentSelect extends StatefulWidget {
  final Function(Instrument) onInstrumentSelect;

  const _PickingLaunchInstrumentSelect({required this.onInstrumentSelect});

  @override
  State<_PickingLaunchInstrumentSelect> createState() =>
      _PickingLaunchInstrumentSelectState();
}

class _PickingLaunchInstrumentSelectState
    extends State<_PickingLaunchInstrumentSelect> {
  Instrument? _hovered;
  bool _mouse = false;
  Instrument? _selected;

  set hovered(Instrument? v) => setState(() {
    _hovered = v;
    _mouse = true;
  });

  set mouse(bool v) => setState(() => _mouse = v);

  set selected(Instrument? v) => setState(() => _selected = v);

  onSelection() {
    if (_selected != null) {
      widget.onInstrumentSelect(_selected!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final instrumentSize = min(size.width, size.height) * .3;
    return PickingScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Let\'s pick your weapon!',
            style: TextTheme.of(context).bodyLarge,
          ),
          buildInstrumentOptions(instrumentSize),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlueAccent,
            ),
            onPressed: _selected == null ? null : onSelection,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Continue',
                style: TextTheme.of(
                  context,
                ).bodyMedium!.copyWith(color: Colors.white70, fontSize: 32),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInstrumentOptions(double instrumentSize) {
    const switchDuration = Duration(milliseconds: 250);
    return CallbackShortcuts(
      bindings: {
        SingleActivator(LogicalKeyboardKey.arrowLeft): () =>
            selected = Instrument.banjo,
        SingleActivator(LogicalKeyboardKey.arrowRight): () =>
            selected = Instrument.guitar,
        SingleActivator(LogicalKeyboardKey.escape): () => selected = null,
        SingleActivator(LogicalKeyboardKey.enter): () => onSelection(),
      },
      child: FocusScope(
        autofocus: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: instrumentSize * .5,
          children: [
            AnimatedSwitcher(
              duration: switchDuration,
              child: buildBanjoSideContent(instrumentSize),
            ),
            AnimatedSwitcher(
              duration: switchDuration,
              child: buildGuitarSideContent(instrumentSize),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBanjoSideContent(double instrumentSize) {
    if (_selected == Instrument.guitar) {
      return buildInstrumentBrief(
        'Start guitar with strumming',
        instrumentSize,
      );
    } else {
      return buildInstrumentOption(Instrument.banjo, instrumentSize);
    }
  }

  Widget buildGuitarSideContent(double instrumentSize) {
    if (_selected == Instrument.banjo) {
      return buildInstrumentBrief(
        'Start banjo with Scruggs style rolls',
        instrumentSize,
      );
    } else {
      return buildInstrumentOption(Instrument.guitar, instrumentSize);
    }
  }

  Widget buildInstrumentBrief(String text, double instrumentSize) {
    return SizedBox.square(
      dimension: instrumentSize,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            text,
            style: TextTheme.of(context).bodyLarge,
            textAlign: TextAlign.center,
          ),
          if (_mouse)
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => selected = null,
                child: SizedBox.square(
                  dimension: 44,
                  child: SvgPicture.asset(
                    'assets/icons/cross.svg',
                    colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
                    semanticsLabel: 'Cancel',
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildInstrumentOption(Instrument instrument, double size) {
    return GestureDetector(
      onTap: () {
        mouse = true;
        selected = instrument;
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => hovered = instrument,
        onExit: (_) => hovered = null,
        child: Container(
          width: size,
          height: size,
          padding: EdgeInsets.all(size * .1),
          decoration: BoxDecoration(
            border: Border.all(
              color: instrumentBorderColor(instrument),
              width: 5,
            ),
            borderRadius: BorderRadius.circular(size * .1),
          ),
          child: InstrumentIcon(dimension: size * .8, instrument: instrument),
        ),
      ),
    );
  }

  Color instrumentBorderColor(Instrument instrument) {
    if (instrument == _selected) {
      return Colors.lightBlueAccent;
    } else if (instrument == _hovered) {
      return Colors.deepOrangeAccent;
    } else {
      return Colors.transparent;
    }
  }
}
