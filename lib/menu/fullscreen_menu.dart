import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:libtab/instrument.dart';
import 'package:pickin_playmate/content/catalog_lookup.dart';
import 'package:pickin_playmate/content/content_repository.dart';
import 'package:pickin_playmate/content/content_type.dart';
import 'package:pickin_playmate/controls/toggle.dart';
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

class PickingFullscreenMenu extends StatefulWidget {
  final ContentRepository contentRepository;
  final ContentType currentContentType;
  final VoidCallback onClose;
  final Function(ContentType contentType, {required bool closeMenu})
  onContentSelection;

  const PickingFullscreenMenu({
    super.key,
    required this.contentRepository,
    required this.currentContentType,
    required this.onClose,
    required this.onContentSelection,
  });

  @override
  State<PickingFullscreenMenu> createState() => _PickingFullscreenMenuState();
}

class _PickingFullscreenMenuState extends State<PickingFullscreenMenu> {
  late FocusNode _contentFocusNode;

  @override
  void initState() {
    super.initState();
    _contentFocusNode = FocusNode();
  }

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
                ContentCatalogLookup(
                  contentRepository: widget.contentRepository,
                  contentType: widget.currentContentType,
                  builder: (context, catalog) {
                    return _ContentSelection(
                      catalog: catalog,
                      current: widget.currentContentType,
                      focusNode: _contentFocusNode,
                      onSelectionFocus: changeContentType,
                    );
                  },
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
            () => widget.onContentSelection(selection, closeMenu: true),
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

class _ContentSelection extends StatelessWidget {
  final ContentCatalog catalog;
  final ContentType current;
  final FocusNode focusNode;
  final Function(ContentType contentType) onSelectionFocus;

  const _ContentSelection({
    required this.catalog,
    required this.current,
    required this.focusNode,
    required this.onSelectionFocus,
  });

  onFocus(ContentType focused) {
    onSelectionFocus(focused);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 50),
          width: (MediaQuery.sizeOf(context).width / 2) - 50,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 22,
            children: catalog.practiceCategories
                .map(
                  (category) => _ContentLinkList(
                    category: category,
                    current: current,
                    focusNode: focusNode,
                    onFocus: onFocus,
                    options: catalog.content[category]!,
                  ),
                )
                .toList(growable: false),
          ),
        ),
        _ContentLinkList(
          category: ContentCategory.songs,
          current: current,
          focusNode: focusNode,
          onFocus: onFocus,
          options: [],
        ),
      ],
    );
  }
}

class _ContentLinkList extends StatelessWidget {
  final ContentCategory category;
  final ContentType current;
  final FocusNode? focusNode;
  final List<ContentType> options;
  final Function(ContentType contentType) onFocus;

  const _ContentLinkList({
    required this.category,
    required this.current,
    required this.focusNode,
    required this.options,
    required this.onFocus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(category.label(), style: TextTheme.of(context).titleSmall),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 7,
            children: options.indexed
                .map<Widget>(
                  (i) => buildContentLink(i.$2, focusable: i.$1 == 0),
                )
                .toList(growable: false),
          ),
        ),
      ],
    );
  }

  Widget buildContentLink(ContentType contentType, {required bool focusable}) {
    final isCurrent = current == contentType;
    return _ContentLink(
      contentType: contentType,
      current: isCurrent,
      focusNode: isCurrent ? focusNode : null,
      onFocus: onFocus,
    );
  }
}

class _ContentLink extends StatefulWidget {
  final ContentType contentType;
  final bool current;
  final FocusNode? focusNode;
  final Function(ContentType contentType) onFocus;

  const _ContentLink({
    required this.contentType,
    this.current = false,
    this.focusNode,
    required this.onFocus,
  });

  @override
  State<_ContentLink> createState() => _ContentLinkState();
}

class _ContentLinkState extends State<_ContentLink> {
  bool focused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: widget.current,
      focusNode: widget.focusNode,
      onFocusChange: (focused) {
        setState(() => this.focused = focused);
        widget.onFocus(widget.contentType);
      },
      child: MouseRegion(
        onHover: (_) => widget.onFocus(widget.contentType),
        child: Text(
          widget.contentType.label(),
          style: TextTheme.of(
            context,
          ).bodySmall!.copyWith(color: focused ? Colors.white : null),
        ),
      ),
    );
  }
}
