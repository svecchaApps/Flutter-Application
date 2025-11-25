# 🎨 Modern Toast - Quick Reference Card

## Import
```dart
import '/utils/modern_snackbar.dart';
import '/utils/toast_examples.dart';
```

## Basic Toast Types

### ✅ Success (Green)
```dart
ModernSnackbar.success(
  context: context,
  message: 'Success!',
  subtitle: 'Operation completed',
);
```

### ❌ Error (Red)
```dart
ModernSnackbar.error(
  context: context,
  message: 'Error!',
  subtitle: 'Something went wrong',
);
```

### ⚠️ Warning (Orange)
```dart
ModernSnackbar.warning(
  context: context,
  message: 'Warning!',
  subtitle: 'Please be careful',
);
```

### ℹ️ Info (Blue)
```dart
ModernSnackbar.info(
  context: context,
  message: 'Info',
  subtitle: 'Here is information',
);
```

## Special Toasts

### 🔄 Loading
```dart
ModernSnackbar.loading(
  context: context,
  message: 'Processing...',
);
// Dismiss when done
ScaffoldMessenger.of(context).clearSnackBars();
```

### 🔘 With Action Button
```dart
ModernSnackbar.withAction(
  context: context,
  message: 'Item removed',
  actionText: 'UNDO',
  onActionPressed: () { /* undo logic */ },
);
```

## Pre-built Examples

### 🛒 Cart
```dart
ToastExamples.addToCart(context, productName);
ToastExamples.removeFromCart(context, productName, onUndo);
```

### 🔐 Auth
```dart
ToastExamples.loginSuccess(context, userName);
ToastExamples.loginError(context);
```

### 📦 Orders
```dart
ToastExamples.orderPlaced(context, orderId);
ToastExamples.orderFailed(context);
```

### 💳 Payment
```dart
ToastExamples.paymentProcessing(context);
ToastExamples.paymentSuccess(context);
ToastExamples.paymentFailed(context);
```

### 💝 Wishlist
```dart
ToastExamples.addToWishlist(context, productName);
```

### 📶 Network
```dart
ToastExamples.noInternet(context);
```

### 🎟️ Coupons
```dart
ToastExamples.couponApplied(context, '20%');
ToastExamples.invalidCoupon(context);
```

## Common Patterns

### Success with Subtitle
```dart
ModernSnackbar.success(
  context: context,
  message: 'Saved',
  subtitle: 'Changes saved successfully',
);
```

### Error with Long Duration
```dart
ModernSnackbar.error(
  context: context,
  message: 'Failed',
  subtitle: 'Please try again',
  duration: const Duration(seconds: 5),
);
```

### Info with Action
```dart
ModernSnackbar.withAction(
  context: context,
  message: 'Update Available',
  actionText: 'UPDATE',
  onActionPressed: () { /* update */ },
  type: SnackbarType.info,
);
```

## Customization

### Duration
```dart
duration: const Duration(seconds: 2), // Quick
duration: const Duration(seconds: 3), // Default
duration: const Duration(seconds: 5), // Longer
```

### Dismiss Manually
```dart
ScaffoldMessenger.of(context).clearSnackBars();
```

## Cheat Sheet

| Action                | Method                          |
|-----------------------|---------------------------------|
| Success message       | `ModernSnackbar.success()`      |
| Error message         | `ModernSnackbar.error()`        |
| Warning message       | `ModernSnackbar.warning()`      |
| Info message          | `ModernSnackbar.info()`         |
| Loading indicator     | `ModernSnackbar.loading()`      |
| With action button    | `ModernSnackbar.withAction()`   |
| Add to cart           | `ToastExamples.addToCart()`     |
| Login success         | `ToastExamples.loginSuccess()`  |
| Payment processing    | `ToastExamples.paymentProcessing()` |
| No internet           | `ToastExamples.noInternet()`    |
| Dismiss current       | `ScaffoldMessenger.of(context).clearSnackBars()` |

## Visual Preview

```
┌──────────────────────────────────────────┐
│ [✓] Success Message              [×]    │
│     Subtitle text here                   │
└──────────────────────────────────────────┘

┌──────────────────────────────────────────┐
│ [✗] Error Message                [×]    │
│     Error details here                   │
└──────────────────────────────────────────┘

┌──────────────────────────────────────────┐
│ [⚠] Warning Message              [×]    │
│     Warning details here                 │
└──────────────────────────────────────────┘

┌──────────────────────────────────────────┐
│ [ℹ] Info Message                 [×]    │
│     Information text here                │
└──────────────────────────────────────────┘

┌──────────────────────────────────────────┐
│ [⌛] Processing...               [×]    │
│     Please wait                          │
└──────────────────────────────────────────┘

┌──────────────────────────────────────────┐
│ [ℹ] Item Removed              [UNDO]   │
└──────────────────────────────────────────┘
```

## Tips

- ✨ Toasts auto-dismiss after configured duration
- 👆 Users can swipe up to dismiss
- 🔘 Click [×] to close manually
- 🎯 Use appropriate type for context
- 📝 Keep messages short and clear
- 🎨 Subtitles add helpful context

---

**Keep this card handy for quick reference! 📌**

