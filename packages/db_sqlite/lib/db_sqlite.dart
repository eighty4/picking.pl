
import 'db_sqlite_platform_interface.dart';

class DbSqlite {
  Future<String?> getPlatformVersion() {
    return DbSqlitePlatform.instance.getPlatformVersion();
  }
}
