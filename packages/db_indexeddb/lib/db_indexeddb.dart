
import 'db_indexeddb_platform_interface.dart';

class DbIndexeddb {
  Future<String?> getPlatformVersion() {
    return DbIndexeddbPlatform.instance.getPlatformVersion();
  }
}
