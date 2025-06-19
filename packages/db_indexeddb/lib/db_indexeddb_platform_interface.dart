import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'db_indexeddb_method_channel.dart';

abstract class DbIndexeddbPlatform extends PlatformInterface {
  /// Constructs a DbIndexeddbPlatform.
  DbIndexeddbPlatform() : super(token: _token);

  static final Object _token = Object();

  static DbIndexeddbPlatform _instance = MethodChannelDbIndexeddb();

  /// The default instance of [DbIndexeddbPlatform] to use.
  ///
  /// Defaults to [MethodChannelDbIndexeddb].
  static DbIndexeddbPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DbIndexeddbPlatform] when
  /// they register themselves.
  static set instance(DbIndexeddbPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
