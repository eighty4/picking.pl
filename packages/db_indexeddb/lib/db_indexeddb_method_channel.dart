import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'db_indexeddb_platform_interface.dart';

/// An implementation of [DbIndexeddbPlatform] that uses method channels.
class MethodChannelDbIndexeddb extends DbIndexeddbPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('db_indexeddb');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
