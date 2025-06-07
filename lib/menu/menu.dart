import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:libtab/instrument.dart';
import 'package:pickin_playmate/content/content_type.dart';
import 'package:pickin_playmate/controls/toggle.dart';
import 'package:pickin_playmate/menu/content_select.dart';
import 'package:pickin_playmate/menu/instrument_select.dart';

sealed class _PickingMenuSelection {}

class _ContentTypeSelection extends _PickingMenuSelection {
  final ContentType selection;

  _ContentTypeSelection(this.selection);
}

class _InstrumentSelection extends _PickingMenuSelection {
  final Instrument instrument;

  _InstrumentSelection(this.instrument);
}

class PickingMenu extends StatefulWidget {
  final ContentType currentContentType;
  final VoidCallback onClose;
  final ContentTypeCallback onContentSelection;

  const PickingMenu({
    super.key,
    required this.currentContentType,
    required this.onClose,
    required this.onContentSelection,
  });

  @override
  State<PickingMenu> createState() => _PickingMenuState();
}

class _PickingMenuState extends State<PickingMenu> {
  final FocusNode _contentFocusNode = FocusNode();

  VoidCallback? _closingMenuCallback;

  set closingMenuCallback(VoidCallback? closingMenuCallback) =>
      setState(() => _closingMenuCallback = closingMenuCallback);

  _PickingMenuSelection? _menuSelection;

  set menuSelection(_PickingMenuSelection menuSelection) =>
      setState(() => _menuSelection = menuSelection);

  Instrument get currentInstrumentSelection => switch (_menuSelection) {
    null => widget.currentContentType.instrument,
    _ContentTypeSelection(selection: var selection) => selection.instrument,
    _InstrumentSelection(instrument: var instrument) => instrument,
  };

  @override
  Widget build(BuildContext context) {
    return _PickingMenuAnimation(
      onCloseCompleted: _closingMenuCallback,
      child: Container(
        color: Colors.deepOrangeAccent,
        child: CallbackShortcuts(
          bindings: keyBindings,
          child: FocusScope(
            autofocus: true,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: SizedBox(
                    height: 100,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          spacing: 20,
                          children: [
                            Text(
                              'Picking',
                              style: TextTheme.of(context).titleMedium,
                            ),
                            InstrumentSelect(
                              currentInstrument: currentInstrumentSelection,
                              onSelection: changeInstrument,
                            ),
                          ],
                        ),
                        Focus(child: Toggle(child: ToggleIcons.settings)),
                      ],
                    ),
                  ),
                ),
                ContentSelection(
                  current: widget.currentContentType,
                  focusNode: _contentFocusNode,
                  instrument: currentInstrumentSelection,
                  onSelectionFocus: changeContentType,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Map<ShortcutActivator, VoidCallback> get keyBindings => {
    SingleActivator(LogicalKeyboardKey.escape): () =>
        closingMenuCallback = widget.onClose,
    SingleActivator(LogicalKeyboardKey.enter): () =>
        closingMenuCallback = switch (_menuSelection) {
          _ContentTypeSelection(selection: var selection) =>
            () => widget.onContentSelection(selection),
          _InstrumentSelection() => null,
          null => widget.onClose,
        },
  };

  changeContentType(ContentType contentType) {
    if (kDebugMode) {
      print('_PickingMenuState.changeContentType($contentType)');
    }
    menuSelection = _ContentTypeSelection(contentType);
  }

  changeInstrument(Instrument instrument) {
    if (kDebugMode) {
      print('_PickingMenuState.changeInstrument($instrument)');
    }
    changeContentType(switch (widget.currentContentType) {
      TechniqueContent(technique: var technique) => TechniqueContent(
        instrument: instrument,
        technique: technique,
      ),
      BanjoRollContent() => GuitarStrumContent(
        guitarStrum: GuitarStrum.values.first,
      ),
      GuitarStrumContent() => BanjoRollContent(
        banjoRoll: BanjoRoll.values.first,
      ),
      _ => throw UnimplementedError(),
    });
  }
}

class _PickingMenuAnimation extends StatefulWidget {
  final Widget child;
  final VoidCallback? onCloseCompleted;

  const _PickingMenuAnimation({required this.child, this.onCloseCompleted});

  @override
  State<_PickingMenuAnimation> createState() => _PickingMenuAnimationState();
}

class _PickingMenuAnimationState extends State<_PickingMenuAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> opacity;
  late final Animation<double> radius;
  late final Animation<double> scale;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );
    opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 1, curve: Curves.ease),
      ),
    )..addListener(() => setState(() {}));
    scale = Tween<double>(begin: .5, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 1, curve: Curves.ease),
      ),
    )..addListener(() => setState(() {}));
    controller.forward().then((_) {});
  }

  @override
  void didUpdateWidget(_PickingMenuAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.onCloseCompleted != null && oldWidget.onCloseCompleted == null) {
      controller.reverse().then((_) {
        widget.onCloseCompleted!();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity.value,
      child: Transform.scale(scale: scale.value, child: widget.child),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
