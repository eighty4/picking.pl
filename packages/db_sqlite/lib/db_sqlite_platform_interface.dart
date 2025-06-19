import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'db_sqlite_method_channel.dart';

abstract class DbSqlitePlatform extends PlatformInterface {
  /// Constructs a DbSqlitePlatform.
  DbSqlitePlatform() : super(token: _token);

  static final Object _token = Object();

  static DbSqlitePlatform _instance = MethodChannelDbSqlite();

  /// The default instance of [DbSqlitePlatform] to use.
  ///
  /// Defaults to [MethodChannelDbSqlite].
  static DbSqlitePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DbSqlitePlatform] when
  /// they register themselves.
  static set instance(DbSqlitePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
