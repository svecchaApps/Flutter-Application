import 'package:flutter/material.dart';
import 'modern_snackbar.dart';
import 'toast_examples.dart';

/// Demo page to showcase all modern toast notifications
class ToastDemoPage extends StatelessWidget {
  const ToastDemoPage({super.key});

  static String routeName = 'ToastDemo';
  static String routePath = '/toast-demo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modern Toast Notifications'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Basic Toasts',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _DemoButton(
            label: 'Success Toast',
            icon: Icons.check_circle,
            color: Colors.green,
            onPressed: () {
              ModernSnackbar.success(
                context: context,
                message: 'Success!',
                subtitle: 'Operation completed successfully',
              );
            },
          ),
          _DemoButton(
            label: 'Error Toast',
            icon: Icons.error,
            color: Colors.red,
            onPressed: () {
              ModernSnackbar.error(
                context: context,
                message: 'Error!',
                subtitle: 'Something went wrong',
              );
            },
          ),
          _DemoButton(
            label: 'Warning Toast',
            icon: Icons.warning,
            color: Colors.orange,
            onPressed: () {
              ModernSnackbar.warning(
                context: context,
                message: 'Warning!',
                subtitle: 'Please be careful',
              );
            },
          ),
          _DemoButton(
            label: 'Info Toast',
            icon: Icons.info,
            color: Colors.blue,
            onPressed: () {
              ModernSnackbar.info(
                context: context,
                message: 'Info',
                subtitle: 'Here is some information',
              );
            },
          ),
          const SizedBox(height: 24),
          const Text(
            'Special Toasts',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _DemoButton(
            label: 'Loading Toast',
            icon: Icons.hourglass_empty,
            color: Colors.purple,
            onPressed: () {
              ModernSnackbar.loading(
                context: context,
                message: 'Loading...',
                subtitle: 'Please wait',
              );
              // Auto dismiss after 3 seconds
              Future.delayed(const Duration(seconds: 3), () {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                }
              });
            },
          ),
          _DemoButton(
            label: 'Toast with Action',
            icon: Icons.touch_app,
            color: Colors.teal,
            onPressed: () {
              ModernSnackbar.withAction(
                context: context,
                message: 'Item Removed',
                actionText: 'UNDO',
                onActionPressed: () {
                  ModernSnackbar.success(
                    context: context,
                    message: 'Restored!',
                  );
                },
                type: SnackbarType.warning,
              );
            },
          ),
          const SizedBox(height: 24),
          const Text(
            'Real-World Examples',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _DemoButton(
            label: 'Add to Cart',
            icon: Icons.shopping_cart,
            color: Colors.green,
            onPressed: () {
              ToastExamples.addToCart(context, 'Blue T-Shirt');
            },
          ),
          _DemoButton(
            label: 'Login Success',
            icon: Icons.login,
            color: Colors.green,
            onPressed: () {
              ToastExamples.loginSuccess(context, 'John Doe');
            },
          ),
          _DemoButton(
            label: 'Order Placed',
            icon: Icons.check_circle_outline,
            color: Colors.green,
            onPressed: () {
              ToastExamples.orderPlaced(context, '12345');
            },
          ),
          _DemoButton(
            label: 'Payment Processing',
            icon: Icons.payment,
            color: Colors.blue,
            onPressed: () {
              ToastExamples.paymentProcessing(context);
              Future.delayed(const Duration(seconds: 2), () {
                if (context.mounted) {
                  ToastExamples.paymentSuccess(context);
                }
              });
            },
          ),
          _DemoButton(
            label: 'No Internet',
            icon: Icons.wifi_off,
            color: Colors.red,
            onPressed: () {
              ToastExamples.noInternet(context);
            },
          ),
          _DemoButton(
            label: 'Coupon Applied',
            icon: Icons.local_offer,
            color: Colors.green,
            onPressed: () {
              ToastExamples.couponApplied(context, '20%');
            },
          ),
          _DemoButton(
            label: 'Low Stock Warning',
            icon: Icons.inventory,
            color: Colors.orange,
            onPressed: () {
              ToastExamples.lowStock(context, 2);
            },
          ),
          _DemoButton(
            label: 'Update Available',
            icon: Icons.system_update,
            color: Colors.blue,
            onPressed: () {
              ToastExamples.updateAvailable(context, () {
                ModernSnackbar.info(
                  context: context,
                  message: 'Updating...',
                );
              });
            },
          ),
        ],
      ),
    );
  }
}

class _DemoButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _DemoButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withOpacity(0.1),
          foregroundColor: color,
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: color.withOpacity(0.3)),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                size: 16, color: color.withOpacity(0.5)),
          ],
        ),
      ),
    );
  }
}
