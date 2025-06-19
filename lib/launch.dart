import 'package:flutter/material.dart';
import 'package:libtab/instrument.dart';
import 'package:pickin_playmate/content/content_repository.dart';
import 'package:pickin_playmate/content/content_type.dart';
import 'package:pickin_playmate/data.dart';

class PickingLaunchData {
  final PickingDataCache cache;
  final ContentRepository contentRepository;
  final ContentType currentContentType;
  final bool returnUser;

  PickingLaunchData({
    required this.cache,
    required this.contentRepository,
    required this.currentContentType,
    required this.returnUser,
  });
}

class PickingLaunch extends StatefulWidget {
  final Widget Function(BuildContext context, PickingLaunchData launchData)
  builder;

  const PickingLaunch({super.key, required this.builder});

  @override
  State<PickingLaunch> createState() => _PickingLaunchState();
}

class _PickingLaunchState extends State<PickingLaunch> {
  static Future<PickingLaunchData?> loadLaunchData() async {
    final cache = PickingDataCache();
    final contentType = await cache.loadContentType();
    final returnUser = contentType != null;
    return PickingLaunchData(
      cache: cache,
      contentRepository: ContentRepository.create(),
      currentContentType: contentType ?? ContentType.initial(Instrument.banjo),
      returnUser: returnUser,
    );
  }

  /// Future used by FutureBuilder for launching the app from a user's previous
  /// session's data
  final Future<PickingLaunchData?> _launchData = loadLaunchData();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _launchData,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          throw snapshot.error!;
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox.shrink();
        } else if (snapshot.data != null) {
          return widget.builder(context, snapshot.data!);
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
