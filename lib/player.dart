import 'dart:math';

import 'package:flutter/material.dart';
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
  late Future<Measure> _measure;

  @override
  void initState() {
    super.initState();
    retrieveContent();
  }

  @override
  void didUpdateWidget(PickingPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.contentType != oldWidget.contentType) {
      retrieveContent();
    }
  }

  retrieveContent() {
    setState(() {
      _measure = widget.contentRepository.retrieveContent(widget.contentType);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _measure,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          throw snapshot.error!;
        } else if (snapshot.hasData) {
          return _PickingPlayerInterface(
            contentType: widget.contentType,
            measure: snapshot.data!,
            size: measureSize(context),
          );
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
  final Measure measure;
  final Size size;

  const _PickingPlayerInterface({
    required this.contentType,
    required this.measure,
    required this.size,
  });

  @override
  State<_PickingPlayerInterface> createState() =>
      _PickingPlayerInterfaceState();
}

class _PickingPlayerInterfaceState extends State<_PickingPlayerInterface> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MeasureDisplay(
        widget.measure,
        instrument: widget.contentType.instrument,
        tabContext: TabContext.forBrightness(Brightness.light),
        size: widget.size,
      ),
    );
  }
}
