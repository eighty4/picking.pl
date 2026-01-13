import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pickin_playmate/data.dart';
import 'package:pickin_playmate/launch.dart';
import 'package:pickin_playmate/layout.dart';
import 'package:pickin_playmate/player.dart';

void main() async {
  if (kDebugMode) {
    if (const bool.fromEnvironment('RESET', defaultValue: false)) {
      WidgetsFlutterBinding.ensureInitialized();
      await PickingDataCache.clear();
    }
  }
  runApp(const PickingPlaymate());
}

class PickingPlaymate extends StatefulWidget {
  const PickingPlaymate({super.key});

  @override
  State<PickingPlaymate> createState() => _PickingPlaymateState();
}

class _PickingPlaymateState extends State<PickingPlaymate> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Color.fromARGB(255, 153, 35, 60),
      debugShowCheckedModeBanner: false,
      home: PickingLaunch(
        builder: (context, launchData) => PickingDataCore(
          builder: (context, appData) {
            return PickingLayout(
              catalogIndex: appData.catalogIndex,
              contentRepository: appData.contentRepository,
              contentType: appData.contentType,
              onContentSelection: appData.onContentSelection,
              onInstrumentSelection: appData.onInstrumentSelection,
              player: PickingPlayer(
                contentRepository: appData.contentRepository,
                contentType: appData.contentType,
                tabContext: appData.tabContext,
              ),
            );
          },
          launchData: launchData,
        ),
      ),
      onGenerateTitle: (context) => 'Picking Playmate',
      theme: ThemeData(
        fontFamily: 'Raleway',
        textTheme: TextTheme(
          bodySmall: TextStyle(
            fontSize: 18,
            fontVariations: [FontVariation.weight(400)],
            color: Colors.black87,
          ),
          bodyMedium: TextStyle(
            fontSize: 24,
            fontVariations: [FontVariation.weight(400)],
            color: Colors.black87,
          ),
          bodyLarge: TextStyle(
            fontSize: 36,
            fontVariations: [FontVariation.weight(400)],
            color: Colors.black87,
          ),
          titleSmall: TextStyle(
            fontSize: 26,
            fontVariations: [FontVariation.weight(500)],
            color: Colors.black87,
          ),
          titleMedium: TextStyle(
            fontSize: 42,
            fontVariations: [FontVariation.weight(600)],
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
