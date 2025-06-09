import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:libtab/instrument.dart';
import 'package:pickin_playmate/widgets/focusable.dart';
import 'package:pickin_playmate/widgets/instrument_icon.dart';

class InstrumentSelect extends StatefulWidget {
  final Instrument currentInstrument;
  final Function(Instrument instrument) onSelection;

  const InstrumentSelect({
    super.key,
    required this.currentInstrument,
    required this.onSelection,
  });

  @override
  State<InstrumentSelect> createState() => _InstrumentSelectState();
}

class _InstrumentSelectState extends State<InstrumentSelect> {
  bool _active = false;

  set active(bool active) => setState(() => _active = active);

  Map<ShortcutActivator, VoidCallback> get keyBindings => _active
      ? {SingleActivator(LogicalKeyboardKey.arrowDown): () => active = false}
      : {};

  List<Instrument> get otherInstruments {
    if (_active) {
      return Instrument.values
          .where((instrument) => instrument != widget.currentInstrument)
          .toList(growable: false);
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: keyBindings,
      child: Row(
        children: [
          _InstrumentSelectOption(
            dimension: 60,
            instrument: widget.currentInstrument,
            onSelect: (_) => active = !_active,
          ),
          ...(otherInstruments.map(
            (instrument) => _InstrumentSelectOption(
              dimension: 60,
              instrument: instrument,
              onSelect: onSelect,
            ),
          )),
        ],
      ),
    );
  }

  onSelect(instrument) {
    active = false;
    widget.onSelection(instrument);
  }
}

class _InstrumentSelectOption extends StatelessWidget {
  final double dimension;
  final Instrument instrument;
  final Function(Instrument instrument) onSelect;

  const _InstrumentSelectOption({
    required this.dimension,
    required this.instrument,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        SingleActivator(LogicalKeyboardKey.enter): () => onSelect(instrument),
      },
      child: Focusable(
        builder: (context, focused) => Container(
          color: focused ? Colors.lightBlueAccent : Colors.transparent,
          child: InstrumentIcon(dimension: dimension, instrument: instrument),
        ),
      ),
    );
  }
}
