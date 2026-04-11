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
    String? subtitle,
    bool showProgress = false,
  }) {
    // Remove any existing snackbars first for smoother transition
    ScaffoldMessenger.of(context).clearSnackBars();

    final snackBar = SnackBar(
      content: _ModernSnackbarContent(
        message: message,
        type: type,
        showAction: showAction,
        actionText: actionText,
        onActionPressed: onActionPressed,
        subtitle: subtitle,
        showProgress: showProgress,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: EdgeInsets.zero,
      duration: duration,
      dismissDirection: DismissDirection.up,
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
    String? subtitle,
  }) {
    show(
      context: context,
      message: message,
      type: SnackbarType.success,
      duration: duration,
      subtitle: subtitle,
    );
  }

  static void error({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
    String? subtitle,
  }) {
    show(
      context: context,
      message: message,
      type: SnackbarType.error,
      duration: duration,
      subtitle: subtitle,
    );
  }

  static void warning({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
    String? subtitle,
  }) {
    show(
      context: context,
      message: message,
      type: SnackbarType.warning,
      duration: duration,
      subtitle: subtitle,
    );
  }

  static void info({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
    String? subtitle,
  }) {
    show(
      context: context,
      message: message,
      type: SnackbarType.info,
      duration: duration,
      subtitle: subtitle,
    );
  }

  static void loading({
    required BuildContext context,
    required String message,
    String? subtitle,
  }) {
    show(
      context: context,
      message: message,
      type: SnackbarType.info,
      duration: const Duration(hours: 1), // Long duration for loading
      showProgress: true,
      subtitle: subtitle,
    );
  }

  static void withAction({
    required BuildContext context,
    required String message,
    required String actionText,
    required VoidCallback onActionPressed,
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 5),
  }) {
    show(
      context: context,
      message: message,
      type: type,
      duration: duration,
      showAction: true,
      actionText: actionText,
      onActionPressed: onActionPressed,
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
  final String? subtitle;
  final bool showProgress;

  const _ModernSnackbarContent({
    required this.message,
    required this.type,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
    this.subtitle,
    this.showProgress = false,
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
        gradient: LinearGradient(
          colors: [
            _getBackgroundColor(),
            _getBackgroundColor().withOpacity(0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _getBackgroundColor().withOpacity(0.4),
            blurRadius: 24,
            offset: const Offset(0, 10),
            spreadRadius: -4,
          ),
          BoxShadow(
            color: _getBackgroundColor().withOpacity(0.2),
            blurRadius: 48,
            offset: const Offset(0, 20),
            spreadRadius: -12,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Shimmer effect
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.0),
                      Colors.white.withOpacity(0.1),
                      Colors.white.withOpacity(0.0),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            )
                .animate(
                  onPlay: (controller) => controller.repeat(),
                )
                .shimmer(
                  duration: 2000.ms,
                  color: Colors.white.withOpacity(0.3),
                ),

            Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Icon with animation
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: showProgress
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : Icon(
                              _getIcon(),
                              color: Colors.white,
                              size: 22,
                            ),
                    )
                        .animate()
                        .scale(
                          duration: 400.ms,
                          curve: Curves.elasticOut,
                        )
                        .then()
                        .shimmer(
                          duration: 1500.ms,
                          color: Colors.white.withOpacity(0.5),
                        ),

                    const SizedBox(width: 14),

                    // Message and subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            message,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.2,
                            ),
                          ),
                          if (subtitle != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              subtitle!,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ],
                      )
                          .animate()
                          .slideX(
                            begin: -0.2,
                            duration: 400.ms,
                            curve: Curves.easeOutCubic,
                          )
                          .fadeIn(
                            duration: 300.ms,
                          ),
                    ),

                    const SizedBox(width: 8),

                    // Action Button
                    if (showAction &&
                        actionText != null &&
                        onActionPressed != null)
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          onActionPressed!();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.25),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          actionText!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ).animate().scale(
                            begin: const Offset(0.8, 0.8),
                            duration: 400.ms,
                            curve: Curves.elasticOut,
                            delay: 200.ms,
                          ),

                    // Close Button
                    if (!showAction && !showProgress)
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      )
                          .animate()
                          .scale(
                            duration: 300.ms,
                            curve: Curves.easeInOut,
                            delay: 200.ms,
                          )
                          .then()
                          .shimmer(
                            duration: 1000.ms,
                            color: Colors.white.withOpacity(0.3),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .slideY(
          begin: -1,
          duration: 500.ms,
          curve: Curves.easeOutBack,
        )
        .fadeIn(
          duration: 400.ms,
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
