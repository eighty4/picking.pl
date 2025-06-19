import 'package:flutter_test/flutter_test.dart';
import 'package:db_sqlite/db_sqlite.dart';
import 'package:db_sqlite/db_sqlite_platform_interface.dart';
import 'package:db_sqlite/db_sqlite_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDbSqlitePlatform
    with MockPlatformInterfaceMixin
    implements DbSqlitePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DbSqlitePlatform initialPlatform = DbSqlitePlatform.instance;

  test('$MethodChannelDbSqlite is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDbSqlite>());
  });

  test('getPlatformVersion', () async {
    DbSqlite dbSqlitePlugin = DbSqlite();
    MockDbSqlitePlatform fakePlatform = MockDbSqlitePlatform();
    DbSqlitePlatform.instance = fakePlatform;

    expect(await dbSqlitePlugin.getPlatformVersion(), '42');
  });
}
