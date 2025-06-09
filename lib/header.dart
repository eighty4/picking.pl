import 'package:flutter/material.dart';
import 'package:libtab/instrument.dart';
import 'package:pickin_playmate/content/content_type.dart';
import 'package:pickin_playmate/widgets/instrument_icon.dart';

class PickingInstrumentButton extends StatefulWidget {
  static const double size = 60;

  final Instrument instrument;
  final VoidCallback onTap;

  const PickingInstrumentButton({
    super.key,
    required this.instrument,
    required this.onTap,
  });

  @override
  State<PickingInstrumentButton> createState() =>
      _PickingInstrumentButtonState();
}

class _PickingInstrumentButtonState extends State<PickingInstrumentButton> {
  bool _clicked = false;
  bool _hovering = false;

  set hovering(bool v) => setState(() => _hovering = v);

  onTap() {
    setState(() => _clicked = true);
    Future.delayed(Duration(milliseconds: 140)).then((_) {
      setState(() => _clicked = false);
    });
    widget.onTap();
  }

  Color borderColor() {
    if (_clicked) {
      return Colors.deepOrangeAccent;
    } else if (_hovering) {
      return Colors.lightBlueAccent;
    } else {
      return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    const size = PickingInstrumentButton.size;
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => hovering = true,
        onExit: (_) => hovering = false,
        child: Container(
          height: size,
          width: size,
          padding: EdgeInsets.all(size * .1),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor(), width: 3),
            borderRadius: BorderRadius.circular(size * .1),
          ),
          child: InstrumentIcon(dimension: size, instrument: widget.instrument),
        ),
      ),
    );
  }
}

class PickingPlayerTitle extends StatefulWidget {
  final ContentType contentType;

  const PickingPlayerTitle({super.key, required this.contentType});

  @override
  State<PickingPlayerTitle> createState() => _PickingPlayerTitleState();
}

class _PickingPlayerTitleState extends State<PickingPlayerTitle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.contentType.label(),
          style: TextTheme.of(context).titleSmall,
        ),
      ],
    );
  }
}

class PickingSettingsButton extends StatefulWidget {
  const PickingSettingsButton({super.key});

  @override
  State<PickingSettingsButton> createState() => _PickingSettingsButtonState();
}

class _PickingSettingsButtonState extends State<PickingSettingsButton> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
