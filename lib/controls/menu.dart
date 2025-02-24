import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  final double dropdownWidth;
  final Function(int) onSelect;
  final List<String> options;
  final String selected;

  const Menu({
    super.key,
    required this.dropdownWidth,
    required this.onSelect,
    required this.options,
    required this.selected,
  });

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  OverlayPortalController controller = OverlayPortalController();
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    return OverlayPortal(
      controller: controller,
      overlayChildBuilder: (context) {
        return Positioned(
          top: renderBox.size.height + position.dy + 5,
          left: position.dx,
          child: TapRegion(
            onTapOutside:
                (event) => {
                  if (!hovering) {controller.hide()},
                },
            child: _MenuOptions(
              onSelect: (i) {
                controller.hide();
                widget.onSelect(i);
              },
              options: widget.options,
              width: widget.dropdownWidth,
            ),
          ),
        );
      },
      child: GestureDetector(
        onTap: () => controller.toggle(),
        child: MouseRegion(
          onEnter: (_) => hovering = true,
          onExit: (_) => hovering = false,
          child: _MenuButton(
            width: widget.dropdownWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.selected, style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final Widget child;
  final double width;

  const _MenuButton({required this.child, required this.width});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        height: 50,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.black12,
        ),
        child: child,
      ),
    );
  }
}

class _MenuOptions extends StatelessWidget {
  final Function(int) onSelect;
  final List<String> options;
  final double width;

  const _MenuOptions({
    required this.onSelect,
    required this.options,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.black26,
      ),
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: options.indexed
            .map(
              (option) => _MenuOption(
                onSelect: () => onSelect(option.$1),
                option: option.$2,
                width: width,
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}

class _MenuOption extends StatefulWidget {
  final VoidCallback onSelect;
  final String option;
  final double width;

  const _MenuOption({
    required this.onSelect,
    required this.option,
    required this.width,
  });

  @override
  State<_MenuOption> createState() => _MenuOptionState();
}

class _MenuOptionState extends State<_MenuOption> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSelect,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => hovering = true),
        onExit: (_) => setState(() => hovering = false),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.5),
            color: color,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: widget.width,
          child: Text(widget.option, style: TextStyle(color: textColor)),
        ),
      ),
    );
  }

  Color? get color {
    if (hovering) {
      return Colors.black45;
    }
    return null;
  }

  Color? get textColor {
    if (hovering) {
      return Colors.white;
    }
    return null;
  }
}
