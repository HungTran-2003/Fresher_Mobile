import 'dart:async';
import 'dart:ui';
import 'package:crud_app/src/presentation/widgets/feedback/app_circular_process_indicator.dart';
import 'package:flutter/material.dart';

class AppLoadingOverlay {
  static OverlayEntry? _currentOverlay;
  static Timer? _showTimer;
  static DateTime? _showTime;

  static void show(
    BuildContext context, {
    Duration delay = const Duration(milliseconds: 200),
    Duration minShowDuration = const Duration(milliseconds: 400),
  }) {
    _showTimer?.cancel();

    if (_currentOverlay != null) return;

    _showTimer = Timer(delay, () {
      if (_currentOverlay != null) return;

      _currentOverlay = OverlayEntry(
        builder: (context) => Positioned.fill(
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                child: Container(
                  color: Colors.black.withAlpha((255 * 0.3).toInt()),
                ),
              ),
              const Center(child: AppCircularProgressIndicator()),
            ],
          ),
        ),
      );

      Overlay.of(context, rootOverlay: true).insert(_currentOverlay!);
      _showTime = DateTime.now();
    });
  }

  static void hide({
    Duration minShowDuration = const Duration(milliseconds: 400),
  }) {
    _showTimer?.cancel();

    if (_currentOverlay == null) return;

    final elapsed = DateTime.now().difference(_showTime ?? DateTime.now());
    if (elapsed < minShowDuration) {
      Future.delayed(minShowDuration - elapsed, () {
        _removeOverlay();
      });
    } else {
      _removeOverlay();
    }
  }

  static void _removeOverlay() {
    _currentOverlay?.remove();
    _currentOverlay = null;
    _showTime = null;
  }
}
