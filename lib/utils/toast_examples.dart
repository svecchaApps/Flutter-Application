import 'package:flutter/material.dart';
import 'modern_snackbar.dart';

/// Common toast notification examples for the app
class ToastExamples {
  // Cart Actions
  static void addToCart(BuildContext context, String productName) {
    ModernSnackbar.success(
      context: context,
      message: 'Added to Cart',
      subtitle: '$productName has been added to your cart',
    );
  }

  static void removeFromCart(
      BuildContext context, String productName, VoidCallback onUndo) {
    ModernSnackbar.withAction(
      context: context,
      message: 'Removed from Cart',
      actionText: 'UNDO',
      onActionPressed: onUndo,
      type: SnackbarType.warning,
      duration: const Duration(seconds: 5),
    );
  }

  static void cartUpdated(BuildContext context) {
    ModernSnackbar.success(
      context: context,
      message: 'Cart Updated',
      duration: const Duration(seconds: 2),
    );
  }

  // Authentication
  static void loginSuccess(BuildContext context, String userName) {
    ModernSnackbar.success(
      context: context,
      message: 'Login Successful',
      subtitle: 'Welcome back, $userName!',
      duration: const Duration(seconds: 2),
    );
  }

  static void loginError(BuildContext context) {
    ModernSnackbar.error(
      context: context,
      message: 'Login Failed',
      subtitle: 'Invalid email or password',
      duration: const Duration(seconds: 4),
    );
  }

  static void logoutSuccess(BuildContext context) {
    ModernSnackbar.info(
      context: context,
      message: 'Logged Out',
      subtitle: 'You have been logged out successfully',
    );
  }

  static void signupSuccess(BuildContext context) {
    ModernSnackbar.success(
      context: context,
      message: 'Account Created',
      subtitle: 'Welcome! Your account has been created successfully',
    );
  }

  // Orders
  static void orderPlaced(BuildContext context, String orderId) {
    ModernSnackbar.success(
      context: context,
      message: 'Order Placed Successfully',
      subtitle: 'Order #$orderId has been confirmed',
      duration: const Duration(seconds: 4),
    );
  }

  static void orderFailed(BuildContext context) {
    ModernSnackbar.error(
      context: context,
      message: 'Order Failed',
      subtitle: 'Unable to process your order. Please try again',
      duration: const Duration(seconds: 4),
    );
  }

  // Payment
  static void paymentProcessing(BuildContext context) {
    ModernSnackbar.loading(
      context: context,
      message: 'Processing Payment',
      subtitle: 'Please do not close the app',
    );
  }

  static void paymentSuccess(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ModernSnackbar.success(
      context: context,
      message: 'Payment Successful',
      subtitle: 'Your payment has been processed',
    );
  }

  static void paymentFailed(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ModernSnackbar.error(
      context: context,
      message: 'Payment Failed',
      subtitle: 'Please check your payment details and try again',
      duration: const Duration(seconds: 5),
    );
  }

  // Wishlist
  static void addToWishlist(BuildContext context, String productName) {
    ModernSnackbar.success(
      context: context,
      message: 'Added to Wishlist',
      subtitle: '$productName saved to your wishlist',
    );
  }

  static void removeFromWishlist(BuildContext context, String productName) {
    ModernSnackbar.info(
      context: context,
      message: 'Removed from Wishlist',
      subtitle: '$productName has been removed',
    );
  }

  // Network & Connectivity
  static void noInternet(BuildContext context) {
    ModernSnackbar.error(
      context: context,
      message: 'No Internet Connection',
      subtitle: 'Please check your network settings',
      duration: const Duration(seconds: 5),
    );
  }

  static void connectionRestored(BuildContext context) {
    ModernSnackbar.success(
      context: context,
      message: 'Connection Restored',
      subtitle: 'You are back online',
    );
  }

  // Form Validation
  static void validationError(BuildContext context, String message) {
    ModernSnackbar.error(
      context: context,
      message: 'Validation Error',
      subtitle: message,
      duration: const Duration(seconds: 4),
    );
  }

  static void formSaved(BuildContext context) {
    ModernSnackbar.success(
      context: context,
      message: 'Saved Successfully',
      duration: const Duration(seconds: 2),
    );
  }

  // Profile & Settings
  static void profileUpdated(BuildContext context) {
    ModernSnackbar.success(
      context: context,
      message: 'Profile Updated',
      subtitle: 'Your changes have been saved',
    );
  }

  static void passwordChanged(BuildContext context) {
    ModernSnackbar.success(
      context: context,
      message: 'Password Changed',
      subtitle: 'Your password has been updated successfully',
    );
  }

  // Address
  static void addressAdded(BuildContext context) {
    ModernSnackbar.success(
      context: context,
      message: 'Address Added',
      subtitle: 'New address has been saved',
    );
  }

  static void addressUpdated(BuildContext context) {
    ModernSnackbar.success(
      context: context,
      message: 'Address Updated',
    );
  }

  static void addressDeleted(BuildContext context, VoidCallback onUndo) {
    ModernSnackbar.withAction(
      context: context,
      message: 'Address Deleted',
      actionText: 'UNDO',
      onActionPressed: onUndo,
      type: SnackbarType.warning,
    );
  }

  // Coupons
  static void couponApplied(BuildContext context, String discount) {
    ModernSnackbar.success(
      context: context,
      message: 'Coupon Applied',
      subtitle: '$discount discount applied to your order',
    );
  }

  static void invalidCoupon(BuildContext context) {
    ModernSnackbar.error(
      context: context,
      message: 'Invalid Coupon',
      subtitle: 'This coupon code is not valid or has expired',
    );
  }

  static void couponRemoved(BuildContext context) {
    ModernSnackbar.info(
      context: context,
      message: 'Coupon Removed',
    );
  }

  // General Actions
  static void copied(BuildContext context, String what) {
    ModernSnackbar.success(
      context: context,
      message: 'Copied to Clipboard',
      subtitle: '$what has been copied',
      duration: const Duration(seconds: 2),
    );
  }

  static void shared(BuildContext context) {
    ModernSnackbar.success(
      context: context,
      message: 'Shared Successfully',
      duration: const Duration(seconds: 2),
    );
  }

  static void downloading(BuildContext context, String fileName) {
    ModernSnackbar.loading(
      context: context,
      message: 'Downloading',
      subtitle: fileName,
    );
  }

  static void downloadComplete(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ModernSnackbar.success(
      context: context,
      message: 'Download Complete',
    );
  }

  // Warnings
  static void lowStock(BuildContext context, int quantity) {
    ModernSnackbar.warning(
      context: context,
      message: 'Low Stock',
      subtitle: 'Only $quantity items left in stock',
    );
  }

  static void sessionExpiring(BuildContext context) {
    ModernSnackbar.warning(
      context: context,
      message: 'Session Expiring Soon',
      subtitle: 'Please save your work',
      duration: const Duration(seconds: 5),
    );
  }

  // Updates
  static void updateAvailable(BuildContext context, VoidCallback onUpdate) {
    ModernSnackbar.withAction(
      context: context,
      message: 'Update Available',
      actionText: 'UPDATE',
      onActionPressed: onUpdate,
      type: SnackbarType.info,
      duration: const Duration(seconds: 10),
    );
  }

  // Videos
  static void videoLiked(BuildContext context) {
    ModernSnackbar.success(
      context: context,
      message: 'Video Liked',
      duration: const Duration(seconds: 2),
    );
  }

  static void videoUnliked(BuildContext context) {
    ModernSnackbar.info(
      context: context,
      message: 'Video Unliked',
      duration: const Duration(seconds: 2),
    );
  }

  static void commentPosted(BuildContext context) {
    ModernSnackbar.success(
      context: context,
      message: 'Comment Posted',
      duration: const Duration(seconds: 2),
    );
  }

  // Returns & Exchanges
  static void returnRequested(BuildContext context, String orderId) {
    ModernSnackbar.success(
      context: context,
      message: 'Return Requested',
      subtitle: 'Return request for order #$orderId submitted',
    );
  }

  static void exchangeRequested(BuildContext context) {
    ModernSnackbar.success(
      context: context,
      message: 'Exchange Requested',
      subtitle: 'Your exchange request has been submitted',
    );
  }

  // Errors
  static void genericError(BuildContext context, {String? message}) {
    ModernSnackbar.error(
      context: context,
      message: 'Something Went Wrong',
      subtitle: message ?? 'Please try again later',
      duration: const Duration(seconds: 4),
    );
  }

  static void serverError(BuildContext context) {
    ModernSnackbar.error(
      context: context,
      message: 'Server Error',
      subtitle: 'Unable to connect to server. Please try again',
      duration: const Duration(seconds: 5),
    );
  }
}
