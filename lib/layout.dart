import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:libtab/instrument.dart';
import 'package:pickin_playmate/content/content_repository.dart';
import 'package:pickin_playmate/content/content_type.dart';
import 'package:pickin_playmate/header.dart';
import 'package:pickin_playmate/menu/fullscreen_menu.dart';
import 'package:pickin_playmate/menu/side_menu.dart';
import 'package:pickin_playmate/player.dart';
import 'package:pickin_playmate/settings/settings_menu.dart';
import 'package:pickin_playmate/widgets/controls.dart';
import 'package:pickin_playmate/widgets/screen.dart';

/// _PickingLayoutState tracks whether UI interactions are triggered with arrow
/// keys (from a keyboard or remote control) or a mouse
enum _InteractionMode { keyboardMouse, remoteControl }

extension on _InteractionMode {
  bool isKeyboardMouse() {
    return this == _InteractionMode.keyboardMouse;
  }

  bool isRemoteControl() {
    return this == _InteractionMode.remoteControl;
  }
}

class PickingLayout extends StatefulWidget {
  static const double controlsHeight = 100;
  static const double headerHeight = 80;
  static const double headerPadding = 10;

  final ContentRepository contentRepository;
  final ContentType contentType;
  final Function(ContentType contentType) onContentSelection;
  final Function(Instrument instrument) onInstrumentSelection;

  const PickingLayout({
    super.key,
    required this.contentRepository,
    required this.contentType,
    required this.onContentSelection,
    required this.onInstrumentSelection,
  });

  @override
  State<PickingLayout> createState() => _PickingLayoutState();
}

class _PickingLayoutState extends State<PickingLayout> {
  static const controlsHeight = PickingLayout.controlsHeight;
  static const headerHeight = PickingLayout.headerHeight;
  static const headerPadding = PickingLayout.headerPadding;

  bool _isMenuOpen = false;
  bool _isSettingsOpen = false;
  _InteractionMode mode = _InteractionMode.remoteControl;

  onContentSelection(ContentType contentType, {required bool closeMenu}) {
    widget.onContentSelection(contentType);
    if (closeMenu) {
      setState(() => _isMenuOpen = false);
    }
  }

  toggleInstrument() {
    widget.onInstrumentSelection(switch (widget.contentType.instrument) {
      Instrument.banjo => Instrument.guitar,
      Instrument.guitar => Instrument.banjo,
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return PickingScreen(
      child: buildRemoteControlHandlers(
        buildMouseDetectionRegion(
          buildMouseMenuRegion(size, buildLayoutStack(size)),
        ),
      ),
    );
  }

  Widget buildRemoteControlHandlers(Widget child) {
    if (mode.isKeyboardMouse()) {
      return child;
    }
    return CallbackShortcuts(
      bindings: switch (_isMenuOpen) {
        true => {},
        false => {
          SingleActivator(LogicalKeyboardKey.arrowUp): () =>
              setState(() => _isMenuOpen = true),
        },
      },
      child: Focus(autofocus: true, child: child),
    );
  }

  Widget buildMouseDetectionRegion(Widget child) {
    if (mode.isKeyboardMouse()) {
      return child;
    }
    return MouseRegion(
      onHover: (_) => setState(() => mode = _InteractionMode.keyboardMouse),
      child: child,
    );
  }

  Widget buildMouseMenuRegion(Size size, Widget child) {
    if (mode.isRemoteControl()) {
      return child;
    }
    if (_isMenuOpen || _isSettingsOpen) {
      return MouseEnterRegion(
        area: Rect.fromLTRB(
          _isMenuOpen ? PickingSideMenu.width : 0,
          headerHeight,
          _isSettingsOpen
              ? size.width - PickingSettingsMenu.width(size)
              : size.width,
          size.height,
        ),
        onEnter: () => setState(() => _isMenuOpen = _isSettingsOpen = false),
        child: child,
      );
    } else {
      return MouseEnterRegion(
        area: Rect.fromLTRB(0, headerHeight * 2, size.width * .1, size.height),
        onEnter: () => setState(() => _isMenuOpen = true),
        child: child,
      );
    }
  }

  buildLayoutStack(Size size) {
    return Stack(
      children: [
        buildTitle(size),
        buildContent(size),
        buildControls(size),
        if (_isSettingsOpen || (_isMenuOpen && mode.isKeyboardMouse()))
          buildOverlay(size),
        if (_isMenuOpen && mode.isKeyboardMouse()) buildSideMenu(size),
        if (_isSettingsOpen) buildSettingsMenu(size),
        buildInstrumentToggle(size),
        buildSettingsToggle(),
        if (_isMenuOpen && mode.isRemoteControl()) buildFullscreenMenu(size),
      ],
    );
  }

  Widget buildInstrumentToggle(Size size) {
    return Positioned(
      top: headerPadding,
      left: headerPadding,
      child: PickingInstrumentButton(
        instrument: widget.contentType.instrument,
        onTap: toggleInstrument,
      ),
    );
  }

  Widget buildTitle(Size size) {
    return Positioned(
      top: headerPadding,
      left: headerPadding + headerPadding + PickingInstrumentButton.size,
      width: size.width,
      height: PickingInstrumentButton.size,
      child: PickingPlayerTitle(contentType: widget.contentType),
    );
  }

  Widget buildSettingsToggle() {
    return Positioned(
      top: headerPadding + headerPadding,
      right: headerPadding + headerPadding,
      height: PickingSettingsButton.size,
      width: PickingSettingsButton.size,
      child: PickingSettingsButton(
        isSettingsOpen: _isSettingsOpen,
        onTap: () {
          setState(() {
            _isMenuOpen = false;
            _isSettingsOpen = true;
          });
        },
      ),
    );
  }

  Widget buildSettingsMenu(Size size) {
    return Positioned(
      top: 0,
      right: 0,
      height: size.height,
      width: PickingSettingsMenu.width(size),
      child: PickingSettingsMenu(),
    );
  }

  Widget buildContent(Size size) {
    return Positioned(
      top: headerHeight,
      bottom: controlsHeight,
      left: 0,
      width: size.width,
      child: PickingPlayer(
        contentRepository: widget.contentRepository,
        contentType: widget.contentType,
      ),
    );
  }

  Widget buildControls(Size size) {
    return Positioned(
      bottom: controlsHeight + 20,
      left: 0,
      width: size.width,
      height: controlsHeight,
      child: const PickingControls(),
    );
  }

  Widget buildFullscreenMenu(Size size) {
    return Positioned(
      top: 0,
      left: 0,
      width: size.width,
      height: size.height,
      child: PickingFullscreenMenu(
        contentRepository: widget.contentRepository,
        currentContentType: widget.contentType,
        onClose: () => setState(() => _isMenuOpen = false),
        onContentSelection: onContentSelection,
      ),
    );
  }

  Widget buildSideMenu(Size size) {
    return Positioned(
      top: headerHeight + 20,
      left: -1,
      bottom: 0,
      width: PickingSideMenu.width,
      child: PickingSideMenu(
        contentRepository: widget.contentRepository,
        currentContentType: widget.contentType,
        onContentSelection: onContentSelection,
      ),
    );
  }

  Widget buildOverlay(Size size) {
    return Positioned(
      top: 0,
      left: 0,
      width: size.width,
      height: size.height,
      child: Container(color: Colors.black.withValues(alpha: 200)),
    );
  }
}

class MouseEnterRegion extends StatefulWidget {
  final Rect area;
  final Widget child;
  final VoidCallback? onEnter;
  final VoidCallback? onExit;

  const MouseEnterRegion({
    super.key,
    required this.area,
    required this.child,
    this.onEnter,
    this.onExit,
  });

  @override
  State<MouseEnterRegion> createState() => _MouseEnterRegionState();
}

class _MouseEnterRegionState extends State<MouseEnterRegion> {
  bool _hovering = false;

  onHover(e) {
    if (widget.area.contains(e.position)) {
      if (!_hovering) {
        _hovering = true;
        if (widget.onEnter != null) {
          widget.onEnter!();
        }
      }
    } else if (_hovering) {
      _hovering = false;
      if (widget.onExit != null) {
        widget.onExit!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(onHover: onHover, child: widget.child);
  }
}
