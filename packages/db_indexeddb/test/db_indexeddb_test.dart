import 'package:flutter_test/flutter_test.dart';
import 'package:db_indexeddb/db_indexeddb.dart';
import 'package:db_indexeddb/db_indexeddb_platform_interface.dart';
import 'package:db_indexeddb/db_indexeddb_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDbIndexeddbPlatform
    with MockPlatformInterfaceMixin
    implements DbIndexeddbPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DbIndexeddbPlatform initialPlatform = DbIndexeddbPlatform.instance;

  test('$MethodChannelDbIndexeddb is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDbIndexeddb>());
  });

  test('getPlatformVersion', () async {
    DbIndexeddb dbIndexeddbPlugin = DbIndexeddb();
    MockDbIndexeddbPlatform fakePlatform = MockDbIndexeddbPlatform();
    DbIndexeddbPlatform.instance = fakePlatform;

    expect(await dbIndexeddbPlugin.getPlatformVersion(), '42');
  });
}
