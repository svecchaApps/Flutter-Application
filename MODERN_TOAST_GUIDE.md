# Modern Toast/Snackbar System Guide

## Overview
Beautiful, modern, and interactive toast notifications with smooth animations, gradients, and multiple styles.

## Features

✨ **Modern Design**
- Gradient backgrounds
- Smooth animations (slide, fade, scale, shimmer)
- Glass-morphism effects
- Floating behavior with shadows

🎨 **4 Toast Types**
- Success (Green) ✓
- Error (Red) ✗
- Warning (Orange) ⚠
- Info (Blue) ℹ

🚀 **Interactive Elements**
- Action buttons
- Close button
- Swipe to dismiss
- Loading state with progress indicator
- Subtitles for extra info

## Basic Usage

### 1. Success Toast
Perfect for: Add to cart, Login successfully, Order placed, etc.

```dart
import '/utils/modern_snackbar.dart';

// Simple success message
ModernSnackbar.success(
  context: context,
  message: 'Added to cart successfully!',
);

// With subtitle
ModernSnackbar.success(
  context: context,
  message: 'Login Successful',
  subtitle: 'Welcome back, John!',
);
```

### 2. Error Toast
Perfect for: Failed operations, validation errors, etc.

```dart
// Simple error
ModernSnackbar.error(
  context: context,
  message: 'Failed to process payment',
);

// With subtitle
ModernSnackbar.error(
  context: context,
  message: 'Connection Error',
  subtitle: 'Please check your internet connection',
  duration: const Duration(seconds: 5),
);
```

### 3. Warning Toast
Perfect for: Warnings, confirmations needed, etc.

```dart
ModernSnackbar.warning(
  context: context,
  message: 'Low stock available',
  subtitle: 'Only 2 items left in inventory',
);
```

### 4. Info Toast
Perfect for: General information, tips, etc.

```dart
ModernSnackbar.info(
  context: context,
  message: 'Update available',
  subtitle: 'Version 2.0 is ready to install',
);
```

### 5. Loading Toast
Perfect for: API calls, processing, uploads, etc.

```dart
// Show loading
ModernSnackbar.loading(
  context: context,
  message: 'Processing payment...',
  subtitle: 'Please wait',
);

// Hide when done
ScaffoldMessenger.of(context).clearSnackBars();
```

### 6. Toast with Action Button
Perfect for: Undo actions, navigate somewhere, etc.

```dart
ModernSnackbar.withAction(
  context: context,
  message: 'Item removed from cart',
  actionText: 'UNDO',
  onActionPressed: () {
    // Restore the item
    print('Undo clicked');
  },
  type: SnackbarType.info,
  duration: const Duration(seconds: 5),
);
```

## Advanced Usage

### Custom Duration
```dart
ModernSnackbar.success(
  context: context,
  message: 'Success!',
  duration: const Duration(seconds: 2), // Short duration
);
```

### With Subtitle
```dart
ModernSnackbar.show(
  context: context,
  message: 'Order Placed',
  subtitle: 'Your order #12345 has been confirmed',
  type: SnackbarType.success,
);
```

### With Progress Indicator
```dart
ModernSnackbar.show(
  context: context,
  message: 'Uploading...',
  subtitle: 'Please wait while we upload your files',
  type: SnackbarType.info,
  showProgress: true,
  duration: const Duration(hours: 1), // Long duration
);
```

## Real-World Examples

### Example 1: Add to Cart

**Before** (old style):
```dart
ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(content: Text('Added to cart')),
);
```

**After** (modern style):
```dart
ModernSnackbar.success(
  context: context,
  message: 'Added to Cart',
  subtitle: '${productName} has been added',
);
```

### Example 2: Login Success

```dart
ModernSnackbar.success(
  context: context,
  message: 'Login Successful',
  subtitle: 'Welcome back, ${userName}!',
  duration: const Duration(seconds: 2),
);
```

### Example 3: Payment Processing

```dart
// Show loading
ModernSnackbar.loading(
  context: context,
  message: 'Processing Payment',
  subtitle: 'Please do not close the app',
);

// After payment completes
await Future.delayed(Duration(seconds: 2));
ScaffoldMessenger.of(context).clearSnackBars();

ModernSnackbar.success(
  context: context,
  message: 'Payment Successful',
  subtitle: 'Order #${orderId} confirmed',
);
```

### Example 4: Form Validation Error

```dart
ModernSnackbar.error(
  context: context,
  message: 'Validation Error',
  subtitle: 'Please fill all required fields',
  duration: const Duration(seconds: 4),
);
```

### Example 5: Undo Delete

```dart
ModernSnackbar.withAction(
  context: context,
  message: 'Item Removed',
  actionText: 'UNDO',
  onActionPressed: () {
    // Restore item logic
    setState(() {
      // Restore the item
    });
  },
  type: SnackbarType.warning,
  duration: const Duration(seconds: 5),
);
```

### Example 6: Network Error

```dart
ModernSnackbar.error(
  context: context,
  message: 'No Internet Connection',
  subtitle: 'Please check your network settings',
  duration: const Duration(seconds: 5),
);
```

### Example 7: Update Available

```dart
ModernSnackbar.withAction(
  context: context,
  message: 'Update Available',
  actionText: 'UPDATE',
  onActionPressed: () {
    // Navigate to update screen
    context.pushNamed('updateScreen');
  },
  type: SnackbarType.info,
  duration: const Duration(seconds: 10),
);
```

## Visual Design

### Toast Structure
```
┌────────────────────────────────────────────────┐
│  [📍]  Message Title           [UNDO] or [×]  │
│        Optional subtitle text                  │
└────────────────────────────────────────────────┘
```

### Animations
1. **Slide Down**: Toast slides down from top with ease-out-back curve
2. **Fade In**: Smooth fade-in effect
3. **Scale**: Icon scales with elastic-out curve
4. **Shimmer**: Continuous shimmer effect on the background
5. **Swipe Up**: Users can swipe up to dismiss

### Colors
- **Success**: Green gradient (#10B981 → #059669)
- **Error**: Red gradient (#EF4444 → #DC2626)
- **Warning**: Orange gradient (#F59E0B → #D97706)
- **Info**: Blue gradient (#3B82F6 → #2563EB)

## Updating Existing Code

Find and replace old snackbars with modern ones:

### Pattern 1: Basic SnackBar
**Old:**
```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text('Message')),
);
```

**New:**
```dart
ModernSnackbar.info(
  context: context,
  message: 'Message',
);
```

### Pattern 2: SnackBar with Action
**Old:**
```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Item removed'),
    action: SnackBarAction(
      label: 'UNDO',
      onPressed: () { /* ... */ },
    ),
  ),
);
```

**New:**
```dart
ModernSnackbar.withAction(
  context: context,
  message: 'Item removed',
  actionText: 'UNDO',
  onActionPressed: () { /* ... */ },
);
```

### Pattern 3: Error Message
**Old:**
```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Error occurred'),
    backgroundColor: Colors.red,
  ),
);
```

**New:**
```dart
ModernSnackbar.error(
  context: context,
  message: 'Error occurred',
);
```

## Best Practices

### ✅ DO
- Use appropriate toast types (success/error/warning/info)
- Add subtitles for clarity when needed
- Use action buttons for undoable actions
- Keep messages short and clear
- Use loading toasts for long operations

### ❌ DON'T
- Don't show too many toasts at once
- Don't use very long messages (use subtitle instead)
- Don't use for critical errors (use dialogs instead)
- Don't set very short durations (< 2 seconds)
- Don't spam toasts on every action

## Keyboard Shortcuts

- **Swipe Up**: Dismiss toast manually
- **Tap X Button**: Close toast immediately
- **Tap Action Button**: Perform action and auto-dismiss

## Accessibility

- ✓ WCAG AA compliant colors
- ✓ Clear iconography
- ✓ Readable text sizes
- ✓ Proper contrast ratios
- ✓ Dismissible via gesture

## Performance

- ⚡ Lightweight animations
- ⚡ No impact on app performance
- ⚡ Automatic cleanup
- ⚡ Memory efficient

## Migration Checklist

- [ ] Import `ModernSnackbar` in files with toast notifications
- [ ] Replace `ScaffoldMessenger.of(context).showSnackBar()` calls
- [ ] Choose appropriate toast types (success/error/warning/info)
- [ ] Add subtitles where clarification is needed
- [ ] Test on different screen sizes
- [ ] Verify animations are smooth
- [ ] Check toast duration is appropriate

## Files

**Main File**: `lib/utils/modern_snackbar.dart`

**Usage**: Import in any widget file:
```dart
import '/utils/modern_snackbar.dart';
```

## Support

For issues or questions about the modern toast system:
1. Check if `flutter_animate` package is installed
2. Verify import statement is correct
3. Ensure context is valid
4. Test on physical device for best animation performance

---

**Enjoy your beautiful, modern toast notifications! 🎉**

