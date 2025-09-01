import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:libtab/libtab.dart';
import 'package:pickin_playmate/content/content_repository.dart';
import 'package:pickin_playmate/content/content_type.dart';

class PickingPlayer extends StatefulWidget {
  final ContentRepository contentRepository;
  final ContentType contentType;

  const PickingPlayer({
    super.key,
    required this.contentRepository,
    required this.contentType,
  });

  @override
  State<PickingPlayer> createState() => _PickingPlayerState();
}

class _PickingPlayerState extends State<PickingPlayer> {
  late Future<List<Measure>> _measures;

  @override
  void initState() {
    super.initState();
    retrieveContent();
  }

  @override
  void didUpdateWidget(PickingPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    retrieveContent();
  }

  retrieveContent() {
    setState(() {
      _measures = widget.contentRepository.retrieveContent(widget.contentType);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _measures,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          throw snapshot.error!;
        } else if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _PickingPlayerInterface(
              contentType: widget.contentType,
              measures: snapshot.data!,
              size: measureSize(context),
            );
          } else {
            return _PickingPlayerInterface(
              contentType: widget.contentType,
              measures: [],
              size: measureSize(context),
            );
          }
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  Size measureSize(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = min(1100.0, size.width * .8);
    final height = min(550.0, (size.height - 200) * .7);
    return Size(width, height);
  }
}

class _PickingPlayerInterface extends StatefulWidget {
  final ContentType contentType;
  final List<Measure> measures;
  final Size size;

  const _PickingPlayerInterface({
    required this.contentType,
    required this.measures,
    required this.size,
  });

  @override
  State<_PickingPlayerInterface> createState() =>
      _PickingPlayerInterfaceState();
}

class _PickingPlayerInterfaceState extends State<_PickingPlayerInterface> {
  int measure = 0;

  @override
  void didUpdateWidget(_PickingPlayerInterface oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.contentType != oldWidget.contentType) {
      setState(() => measure = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        SingleActivator(LogicalKeyboardKey.arrowLeft): () {
          setState(() => measure = max(0, measure - 1));
        },
        SingleActivator(LogicalKeyboardKey.arrowRight): () {
          setState(
            () => measure = min(widget.measures.length - 1, measure + 1),
          );
        },
      },
      child: Focus(
        autofocus: true,
        child: Center(
          child: MeasureDisplay(
            widget.measures.isNotEmpty
                ? widget.measures[measure]
                : Measure.fromNoteList([]),
            // label: (measure + 1).toString(),
            instrument: widget.contentType.instrument,
            tabContext: TabContext.forBrightness(Brightness.light),
            size: widget.size,
          ),
        ),
      ),
    );
  }
}
