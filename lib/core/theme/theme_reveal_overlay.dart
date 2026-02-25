import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class ThemeRevealOverlay extends StatefulWidget {
  const ThemeRevealOverlay({
    super.key,
    required this.snapshot,
    required this.origin,
    required this.devicePixelRatio,
    required this.onDone,
  });

  final ui.Image snapshot;
  final Offset origin;
  final double devicePixelRatio;
  final VoidCallback onDone;

  @override
  State<ThemeRevealOverlay> createState() => _ThemeRevealOverlayState();
}

class _ThemeRevealOverlayState extends State<ThemeRevealOverlay> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800));
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutCubic);
    _ctrl.forward().whenComplete(widget.onDone);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => CustomPaint(
        painter: _CircularRevealPainter(
          image: widget.snapshot,
          origin: widget.origin,
          progress: _anim.value,
          dpr: widget.devicePixelRatio,
        ),
        size: Size.infinite,
      ),
    );
  }
}

class _CircularRevealPainter extends CustomPainter {
  const _CircularRevealPainter({required this.image, required this.origin, required this.progress, required this.dpr});

  final ui.Image image;
  final Offset origin;
  final double progress; // 0 → 1
  final double dpr;

  @override
  void paint(Canvas canvas, Size size) {
    // Farthest corner from origin = full coverage radius
    final maxRadius = [
      origin.distance,
      (origin - Offset(size.width, 0)).distance,
      (origin - Offset(0, size.height)).distance,
      (origin - Offset(size.width, size.height)).distance,
    ].reduce((a, b) => a > b ? a : b);

    // saveLayer is required for BlendMode.clear to work correctly
    canvas.saveLayer(Offset.zero & size, Paint());

    // 1. Draw the OLD theme snapshot covering the full screen
    canvas.save();
    canvas.scale(1.0 / dpr);
    canvas.drawImage(image, Offset.zero, Paint());
    canvas.restore();

    // 2. Punch a GROWING hole from the switch origin → new theme shows through
    canvas.drawCircle(
      origin,
      maxRadius * progress, // 0 → maxRadius as animation plays
      Paint()..blendMode = BlendMode.clear,
    );

    canvas.restore(); // flattens the layer onto the screen
  }

  @override
  bool shouldRepaint(_CircularRevealPainter old) => old.progress != progress;
}
