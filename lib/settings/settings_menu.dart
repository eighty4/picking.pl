import 'package:flutter/material.dart';
import 'package:pickin_playmate/controls/toggle.dart';

class PickingSettingsMenu extends StatefulWidget {
  static double width(Size size) {
    return size.width * .5;
  }

  const PickingSettingsMenu({super.key});

  @override
  State<PickingSettingsMenu> createState() => _PickingSettingsMenuState();
}

class _PickingSettingsMenuState extends State<PickingSettingsMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          buildSettingsTitle(),
          ...buildPaddingSection(),
          ...buildThemeSection(),
        ],
      ),
    );
  }

  Widget buildSettingsTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('Settings', style: TextTheme.of(context).titleMedium),
        ToggleIcons.settings,
      ],
    );
  }

  List<Widget> buildPaddingSection() {
    return [Text('Interface size', style: TextTheme.of(context).titleSmall)];
  }

  List<Widget> buildThemeSection() {
    return [Text('Theme', style: TextTheme.of(context).titleSmall)];
  }
}
