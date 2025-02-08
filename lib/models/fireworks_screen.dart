import 'package:flutter/material.dart';
import 'package:flutter_fireworks/fireworks_controller.dart';
import 'package:flutter_fireworks/fireworks_display.dart';

class FireworksDemo extends StatefulWidget {
  const FireworksDemo({super.key});

  @override
  State<FireworksDemo> createState() => _FireworksDemoState();
}

class _FireworksDemoState extends State<FireworksDemo> {
  final fireworksController = FireworksController(
    colors: [
      Color(0xFFFF4C40), // Coral
      Color(0xFF0081FF), // Blue
      Color(0xFFFFE600), // Yellow
      Color(0xFFD0021B), // Deep Orange
      Color(0xFF8BC34A), // Light Green
      Color(0xFFF57C00), // Amber
      Color(0xFFE64A19), // Deep Orange
      Color(0xFF9C27B0), // Purple
      Color(0xFF4CAF50), // Green
      Color(0xFFFF9800), // Orange
      Color(0xFF795548), // Brown
      Color(0xFF9E9E9E), // Grey
      Color(0xFF03A9F4), // Light Blue
      Color(0xFF00796B), // Teal
      Color(0xFFC2185B), // Pink
      Color(0xFF66D9EF), // Cyan
      Color(0xFF8F9E45), // Lime
      Color(0xFFB71C1C), // Red
      Color(0xFF1A237E), // Indigo
    ],
    minExplosionDuration: 0.5,
    maxExplosionDuration: 3.5,
    minParticleCount: 125,
    maxParticleCount: 275,
    fadeOutDuration: 0.4,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fireworksController.fireMultipleRockets(
        minRockets: 20,
        maxRockets: 50,
        launchWindow: Duration(milliseconds: 500),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Stack(
        children: [
          FireworksDisplay(
            controller: fireworksController,
          ),
        ],
      ),
      // Remove or keep the floatingActionButton if needed
      // floatingActionButton: SizedBox(
      //   width: 60,
      //   height: 60,
      //   child: FloatingActionButton(
      //     onPressed: () => fireworksController.fireMultipleRockets(
      //       minRockets: 5,
      //       maxRockets: 20,
      //       launchWindow: Duration(milliseconds: 600),
      //     ),
      //     tooltip: 'Fire Multiple Rockets',
      //     shape: const CircleBorder(),
      //     backgroundColor: Colors.white.withAlpha(153),
      //     foregroundColor: Colors.black,
      //     child: const Icon(Icons.keyboard_double_arrow_up, size: 32),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
