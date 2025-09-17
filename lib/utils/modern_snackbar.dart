import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ModernSnackbar {
  static void show({
    required BuildContext context,
    required String message,
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 3),
    bool showAction = false,
    String? actionText,
    VoidCallback? onActionPressed,
  }) {
    final snackBar = SnackBar(
      content: _ModernSnackbarContent(
        message: message,
        type: type,
        showAction: showAction,
        actionText: actionText,
        onActionPressed: onActionPressed,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      padding: EdgeInsets.zero,
      duration: duration,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void success({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context: context,
      message: message,
      type: SnackbarType.success,
      duration: duration,
    );
  }

  static void error({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context: context,
      message: message,
      type: SnackbarType.error,
      duration: duration,
    );
  }

  static void warning({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context: context,
      message: message,
      type: SnackbarType.warning,
      duration: duration,
    );
  }

  static void info({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context: context,
      message: message,
      type: SnackbarType.info,
      duration: duration,
    );
  }
}

enum SnackbarType { success, error, warning, info }

class _ModernSnackbarContent extends StatelessWidget {
  final String message;
  final SnackbarType type;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  const _ModernSnackbarContent({
    required this.message,
    required this.type,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });

  Color _getBackgroundColor() {
    switch (type) {
      case SnackbarType.success:
        return const Color(0xFF10B981);
      case SnackbarType.error:
        return const Color(0xFFEF4444);
      case SnackbarType.warning:
        return const Color(0xFFF59E0B);
      case SnackbarType.info:
        return const Color(0xFF3B82F6);
    }
  }

  Color _getIconColor() {
    switch (type) {
      case SnackbarType.success:
        return const Color(0xFF059669);
      case SnackbarType.error:
        return const Color(0xFFDC2626);
      case SnackbarType.warning:
        return const Color(0xFFD97706);
      case SnackbarType.info:
        return const Color(0xFF2563EB);
    }
  }

  IconData _getIcon() {
    switch (type) {
      case SnackbarType.success:
        return Icons.check_circle_outline;
      case SnackbarType.error:
        return Icons.error_outline;
      case SnackbarType.warning:
        return Icons.warning_amber_outlined;
      case SnackbarType.info:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _getBackgroundColor().withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getIcon(),
                  color: Colors.white,
                  size: 24,
                ),
              ).animate().scale(
                    duration: 300.ms,
                    curve: Curves.elasticOut,
                  ),

              const SizedBox(width: 12),

              // Message
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ).animate().slideX(
                      begin: -0.3,
                      duration: 400.ms,
                      curve: Curves.easeOutCubic,
                    ),
              ),

              // Action Button
              if (showAction && actionText != null && onActionPressed != null)
                TextButton(
                  onPressed: onActionPressed,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    actionText!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ).animate().slideX(
                      begin: 0.3,
                      duration: 400.ms,
                      curve: Curves.easeOutCubic,
                    ),

              // Close Button
              if (!showAction)
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                ).animate().rotate(
                      begin: 0,
                      end: 0.5,
                      duration: 300.ms,
                      curve: Curves.easeInOut,
                    ),
            ],
          ),
        ),
      ),
    ).animate().slideY(
          begin: -1,
          duration: 400.ms,
          curve: Curves.easeOutCubic,
        );
  }
}

// Legacy support for existing CustomSnackbar calls
class CustomSnackbar {
  static void show({
    required BuildContext context,
    required String message,
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    ModernSnackbar.show(
      context: context,
      message: message,
      type: type,
      duration: duration,
    );
  }

  static void success({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    ModernSnackbar.success(
      context: context,
      message: message,
      duration: duration,
    );
  }

  static void error({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    ModernSnackbar.error(
      context: context,
      message: message,
      duration: duration,
    );
  }

  static void warning({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    ModernSnackbar.warning(
      context: context,
      message: message,
      duration: duration,
    );
  }

  static void info({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    ModernSnackbar.info(
      context: context,
      message: message,
      duration: duration,
    );
  }
}
