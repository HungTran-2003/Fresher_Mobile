import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class BiometricBottomSheet extends StatefulWidget {
  const BiometricBottomSheet({super.key});

  static Future<bool?> show(BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const BiometricBottomSheet(),
    );
  }

  @override
  State<BiometricBottomSheet> createState() => _BiometricBottomSheetState();
}

class _BiometricBottomSheetState extends State<BiometricBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  String? _statusText;
  bool _isScanning = false;
  bool _isSuccess = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.25).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _startScan() async {
    if (_isScanning || _isSuccess) return;

    setState(() {
      _isScanning = true;
      _statusText = context.s.verifyingFingerprint;
    });

    // Simulate scanning
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;

    setState(() {
      _isScanning = false;
      _isSuccess = true;
      _statusText = context.s.verificationSuccessful;
    });

    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    _statusText ??= context.s.touchSensorToLogIn;

    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: _buildBodyColumn(context),
    );
  }

  Widget _buildBodyColumn(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textThemes;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48,
          height: 5,
          decoration: BoxDecoration(
            color: colors.outlineLightest,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          context.s.biometricSignIn,
          style: textTheme.titleLarge.copyWith(
            fontWeight: FontWeight.w800,
            color: colors.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          context.s.useFingerprintScanner,
          style: textTheme.bodyMedium.copyWith(
            color: colors.onSurface.withValues(alpha: 0.6),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        GestureDetector(
          onTap: _startScan,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer pulsing ripple effect
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Container(
                    width: 140 * _pulseAnimation.value,
                    height: 140 * _pulseAnimation.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _getScannerColor(context).withValues(alpha: 0.08),
                    ),
                  );
                },
              ),
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Container(
                    width: 120 * _pulseAnimation.value,
                    height: 120 * _pulseAnimation.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _getScannerColor(context).withValues(alpha: 0.12),
                    ),
                  );
                },
              ),
              // Scanner container
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _getScannerColor(context),
                  boxShadow: [
                    BoxShadow(
                      color: _getScannerColor(context).withValues(alpha: 0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  _isSuccess
                      ? LucideIcons.check
                      : _isScanning
                          ? LucideIcons.loader
                          : LucideIcons.fingerprint,
                  size: 44,
                  color: colors.onPrimary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            _statusText!,
            key: ValueKey<String>(_statusText!),
            style: textTheme.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: _isSuccess
                  ? colors.successText
                  : colors.onSurface,
            ),
          ),
        ),
        const SizedBox(height: 24),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: Text(
            context.s.cancel,
            style: textTheme.bodyLarge.copyWith(
              color: colors.outlineStrong,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Color _getScannerColor(BuildContext context) {
    final colors = context.colors;
    if (_isSuccess) return colors.successText;
    if (_isScanning) return colors.secondary;
    return colors.primary;
  }
}
