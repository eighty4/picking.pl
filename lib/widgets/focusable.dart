import 'package:flutter/widgets.dart';

class Focusable extends StatefulWidget {
  final bool autofocus;
  final Widget Function(BuildContext context, bool focused) builder;
  final FocusNode? focusNode;
  final VoidCallback? onBlur;
  final VoidCallback? onFocus;
  final Function(bool)? onFocusChange;

  const Focusable(
      {super.key,
      this.autofocus = false,
      this.focusNode,
      required this.builder,
      this.onBlur,
      this.onFocus,
      this.onFocusChange});

  @override
  State<Focusable> createState() => _FocusableState();
}

class _FocusableState extends State<Focusable> {
  bool focused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      onFocusChange: onFocusChange,
      child: widget.builder(context, focused),
    );
  }

  onFocusChange(bool focused) {
    setState(() => this.focused = focused);
    if (widget.onFocusChange != null) {
      widget.onFocusChange!(focused);
    }
    if (focused && widget.onFocus != null) {
      widget.onFocus!();
    }
    if (!focused && widget.onBlur != null) {
      widget.onBlur!();
    }
  }
}
