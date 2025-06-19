import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'db_sqlite_platform_interface.dart';

/// An implementation of [DbSqlitePlatform] that uses method channels.
class MethodChannelDbSqlite extends DbSqlitePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('db_sqlite');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
