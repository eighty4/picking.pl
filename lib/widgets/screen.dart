import 'package:flutter/material.dart';

class PickingScreen extends StatelessWidget {
  final Widget child;

  const PickingScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: child));
  }
}
