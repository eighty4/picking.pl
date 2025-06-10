import 'package:flutter/material.dart';

class Hoverable extends StatefulWidget {
  final Function(BuildContext context, bool hovering) builder;

  const Hoverable({super.key, required this.builder});

  @override
  State<Hoverable> createState() => _HoverableState();
}

class _HoverableState extends State<Hoverable> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: widget.builder(context, hovering),
    );
  }
}
