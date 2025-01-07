import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ToggleIcons {
  static final SvgPicture previous =
      SvgPicture.asset('assets/icons/chevron_left.svg', semanticsLabel: 'Prev');
  static final SvgPicture next = SvgPicture.asset(
      'assets/icons/chevron_right.svg',
      semanticsLabel: 'Next');
  static final SvgPicture pause =
      SvgPicture.asset('assets/icons/pause.svg', semanticsLabel: 'Pause');
  static final SvgPicture play =
      SvgPicture.asset('assets/icons/play.svg', semanticsLabel: 'Play');
  static final SvgPicture resume =
      SvgPicture.asset('assets/icons/resume.svg', semanticsLabel: 'Resume');
  static final SvgPicture settings =
      SvgPicture.asset('assets/icons/cog.svg', semanticsLabel: 'Settings');
}

class ToggleGroup extends StatelessWidget {
  final List<Toggle> toggles;

  const ToggleGroup({super.key, required this.toggles});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: 5, children: toggles);
  }
}

class Toggle extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool enabled;

  const Toggle(
      {super.key, required this.child, this.onTap, this.enabled = true});

  @override
  State<Toggle> createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> {
  bool hover = false;
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    final toggle = buildToggle();
    if (widget.onTap == null) {
      return toggle;
    } else {
      return GestureDetector(onTap: widget.onTap, child: toggle);
    }
  }

  Widget buildToggle() {
    return MouseRegion(
      cursor: widget.enabled ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(5), color: color),
        duration: Duration(milliseconds: 50),
        width: 50,
        height: 50,
        child:
            Center(child: SizedBox.square(dimension: 25, child: widget.child)),
      ),
    );
  }

  Color get color {
    if (!widget.enabled) {
      return Color.fromARGB(15, 0, 0, 0);
    } else if (hover || selected) {
      return Colors.black26;
    } else {
      return Colors.black12;
    }
  }
}
