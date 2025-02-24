import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickin_playmate/content/content_type.dart';
import 'package:pickin_playmate/header.dart';
import 'package:pickin_playmate/launch.dart';
import 'package:pickin_playmate/menu/menu.dart';
import 'package:pickin_playmate/player.dart';
import 'package:pickin_playmate/widgets/controls.dart';
import 'package:pickin_playmate/widgets/screen.dart';

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
      home: PickingLaunch(
        builder: (context, data) => _PickingLayout(data: data),
      ),
      onGenerateTitle: (context) => 'Picking Playmate',
      theme: ThemeData(
        fontFamily: 'Raleway',
        textTheme: TextTheme(
          bodySmall: TextStyle(
            fontSize: 18,
            fontVariations: [FontVariation.weight(400)],
            color: Colors.black87,
          ),
          bodyMedium: TextStyle(
            fontSize: 24,
            fontVariations: [FontVariation.weight(400)],
            color: Colors.black87,
          ),
          bodyLarge: TextStyle(
            fontSize: 36,
            fontVariations: [FontVariation.weight(400)],
            color: Colors.black87,
          ),
          titleSmall: TextStyle(
            fontSize: 26,
            fontVariations: [FontVariation.weight(500)],
            color: Colors.black87,
          ),
          titleMedium: TextStyle(
            fontSize: 42,
            fontVariations: [FontVariation.weight(600)],
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

class _PickingLayout extends StatefulWidget {
  final PickingUserData data;

  const _PickingLayout({required this.data});

  @override
  State<_PickingLayout> createState() => _PickingLayoutState();
}

class _PickingLayoutState extends State<_PickingLayout> {
  bool isMenuOpen = false;
  late ContentType contentType;

  @override
  void initState() {
    super.initState();
    contentType = ContentType.initial(widget.data.instrument);
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
    return PickingScreen(
      child: CallbackShortcuts(
        bindings: keyboardBindings,
        child: Focus(
          autofocus: true,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                width: size.width,
                height: headerHeight,
                child: PickingHeader(instrument: contentType.instrument),
              ),
              Positioned(
                top: headerHeight,
                bottom: controlsHeight,
                left: 0,
                width: size.width,
                child: PickingPlayer(contentType: contentType),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                width: size.width,
                height: controlsHeight,
                child: const PickingControls(),
              ),
              if (isMenuOpen)
                Positioned(
                  top: 0,
                  left: 0,
                  width: size.width,
                  height: size.height,
                  child: PickingMenu(
                    currentContentType: contentType,
                    onClose: closeMenu,
                    onContentSelection: onContentSelection,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
