import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:libtab/instrument.dart';
import 'package:pickin_playmate/content/content_type.dart';
import 'package:pickin_playmate/header.dart';
import 'package:pickin_playmate/menu/menu.dart';
import 'package:pickin_playmate/player.dart';
import 'package:pickin_playmate/widgets/controls.dart';

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

class _PickingPlaymateLayout extends StatefulWidget {
  const _PickingPlaymateLayout();

  @override
  State<_PickingPlaymateLayout> createState() => _PickingPlaymateLayoutState();
}

class _PickingPlaymateLayoutState extends State<_PickingPlaymateLayout> {
  bool isMenuOpen = false;
  late ContentType contentType;

  @override
  void initState() {
    super.initState();
    contentType = ContentType.initial(Instrument.banjo);
  }

  openMenu() => setState(() => isMenuOpen = true);

  closeMenu() => setState(() => isMenuOpen = false);

  onContentSelection(ContentType contentType) => setState(() {
        this.contentType = contentType;
        isMenuOpen = false;
      });

  Map<SingleActivator, VoidCallback> get keyboardBindings {
    if (isMenuOpen) {
      return {};
    } else {
      return {SingleActivator(LogicalKeyboardKey.arrowUp): openMenu};
    }
  }

  @override
  Widget build(BuildContext context) {
    const headerHeight = 100.0;
    const controlsHeight = 100.0;
    final size = MediaQuery.sizeOf(context);
    return CallbackShortcuts(
      bindings: keyboardBindings,
      child: Focus(
        autofocus: true,
        child: Scaffold(
          body: Stack(children: [
            Positioned(
                top: 0,
                left: 0,
                width: size.width,
                height: headerHeight,
                child: PickingHeader(instrument: contentType.instrument)),
            Positioned(
                top: headerHeight,
                bottom: controlsHeight,
                left: 0,
                width: size.width,
                child: PickingPlayer(contentType: contentType)),
            Positioned(
                bottom: 0,
                left: 0,
                width: size.width,
                height: controlsHeight,
                child: const PickingControls()),
            if (isMenuOpen)
              Positioned(
                top: 0,
                left: 0,
                width: size.width,
                height: size.height,
                child: PickingMenu(
                    currentContentType: contentType,
                    onClose: closeMenu,
                    onContentSelection: onContentSelection),
              ),
          ]),
        ),
      ),
    );
  }
}
