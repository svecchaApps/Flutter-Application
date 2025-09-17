# 🔐 Authentication & Modern UI Guide

This guide explains how to use the new authentication features, modern snackbar, and guest login functionality in the Indigo Rhapsody app.

## 📋 Table of Contents

1. [Modern Snackbar](#modern-snackbar)
2. [Authentication Service](#authentication-service)
3. [Guest Login & Redirects](#guest-login--redirects)
4. [Logout Functionality](#logout-functionality)
5. [Usage Examples](#usage-examples)
6. [Best Practices](#best-practices)

---

## 🎨 Modern Snackbar

### Features
- **Beautiful Design**: Modern, rounded corners with shadows and animations
- **Multiple Types**: Success, Error, Warning, Info with appropriate colors and icons
- **Smooth Animations**: Slide-in, scale, and rotation animations
- **Action Buttons**: Optional action buttons for user interaction
- **Auto-dismiss**: Configurable duration with manual close option

### Basic Usage

```dart
import '/utils/modern_snackbar.dart';

// Success message
ModernSnackbar.success(
  context: context,
  message: 'Operation completed successfully!',
);

// Error message
ModernSnackbar.error(
  context: context,
  message: 'Something went wrong. Please try again.',
);

// Warning message
ModernSnackbar.warning(
  context: context,
  message: 'Please check your input and try again.',
);

// Info message
ModernSnackbar.info(
  context: context,
  message: 'New features are available!',
);
```

### Advanced Usage

```dart
// Custom duration and action button
ModernSnackbar.show(
  context: context,
  message: 'Would you like to undo this action?',
  type: SnackbarType.warning,
  duration: const Duration(seconds: 5),
  showAction: true,
  actionText: 'Undo',
  onActionPressed: () {
    // Handle undo action
    undoLastAction();
  },
);
```

### Legacy Support
The old `CustomSnackbar` class is still supported for backward compatibility:

```dart
import '/utils/modern_snackbar.dart';

CustomSnackbar.success(context: context, message: 'Success!');
CustomSnackbar.error(context: context, message: 'Error!');
```

---

## 🔐 Authentication Service

### Features
- **Unified Authentication**: Handles both Firebase and JWT authentication
- **Token Management**: Automatically clears all tokens on logout
- **Guest Detection**: Easy way to check if user is a guest
- **Redirect Management**: Automatic redirects to login page
- **Data Clearing**: Comprehensive cleanup of user data

### Basic Usage

```dart
import '/services/auth_service.dart';

// Check if user is authenticated
if (AuthService.isAuthenticated()) {
  // User is logged in
  performAuthenticatedAction();
} else {
  // User is a guest
  showLoginPrompt();
}

// Check if user is a guest
if (AuthService.isGuest()) {
  // Show guest-specific UI
  showGuestFeatures();
}
```

### Context Extensions

```dart
// Using context extensions for cleaner code
if (context.isAuthenticated) {
  // User is authenticated
} else {
  // User is a guest
}

// Require authentication with automatic redirect
context.requireAuth(
  message: 'Please login with your phone number to continue',
  redirectRoute: 'LoginMobileScreen',
);

// Show authentication dialog
context.requireAuthWithDialog(
  title: 'Premium Feature',
  message: 'This feature requires a premium account. Would you like to login with your phone number?',
);
```

---

## 👤 Guest Login & Redirects

### Automatic Redirects

When a guest user tries to access a feature that requires authentication, they are automatically redirected to the mobile login page (phone number login only) with a helpful message.

```dart
// Simple authentication check with redirect
context.requireAuth(
  message: 'Please login with your phone number to access your profile',
  redirectRoute: 'LoginMobileScreen',
);

// With custom dialog
context.requireAuthWithDialog(
  title: 'Authentication Required',
  message: 'You need to be logged in to perform this action. Would you like to login with your phone number?',
);
```

### Conditional Actions

```dart
// Execute action only if authenticated
context.withAuth(
  () async {
    // This code only runs if user is authenticated
    await performPremiumAction();
    return true;
  },
  message: 'Please login with your phone number to access premium features',
  redirectRoute: 'LoginMobileScreen',
);
```

### Authentication Status

```dart
// Get detailed authentication status
final authStatus = AuthService.getAuthStatus();
print('Is authenticated: ${authStatus['isAuthenticated']}');
print('Is guest: ${authStatus['isGuest']}');
print('Has Firebase auth: ${authStatus['hasFirebaseAuth']}');
print('Has JWT auth: ${authStatus['hasJwtAuth']}');
print('User ID: ${authStatus['userId']}');
print('Phone number: ${authStatus['phoneNumber']}');
```

---

## 🚪 Logout Functionality

### Complete Logout

The logout function automatically:
- Signs out from Firebase
- Clears JWT tokens
- Removes user data from SharedPreferences
- Clears app state
- Shows success message
- Redirects to login page

```dart
// Simple logout
await AuthService.logout(context);

// Logout with confirmation dialog
var confirmDialogResponse = await showDialog<bool>(
  context: context,
  builder: (alertDialogContext) {
    return AlertDialog(
      title: const Text('Logout'),
      content: const Text('Are you sure you want to logout?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(alertDialogContext, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(alertDialogContext, true),
          child: const Text('Confirm'),
        ),
      ],
    );
  },
) ?? false;

if (confirmDialogResponse) {
  await AuthService.logout(context);
}
```

### Data Clearing

```dart
// Clear all user data (for account deletion)
await AuthService.clearAllUserData();
```

---

## 💡 Usage Examples

### Example 1: Protected Feature Access

```dart
class PremiumFeatureWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.withAuth(
          () async {
            // Premium feature logic here
            await unlockPremiumFeature();
            ModernSnackbar.success(
              context: context,
              message: 'Premium feature unlocked!',
            );
            return true;
          },
          message: 'This is a premium feature. Please login to continue.',
        );
      },
      child: Text('Access Premium Feature'),
    );
  }
}
```

### Example 2: Profile Access

```dart
class ProfileButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (context.isAuthenticated) {
          context.pushNamed('ProfilePage');
        } else {
          context.requireAuthWithDialog(
            title: 'Profile Access',
            message: 'Please login with your phone number to view your profile.',
          );
        }
      },
      icon: Icon(Icons.person),
    );
  }
}
```

### Example 3: Shopping Cart

```dart
class AddToCartButton extends StatelessWidget {
  final Product product;
  
  const AddToCartButton({required this.product});
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.withAuth(
          () async {
            await addToCart(product);
            ModernSnackbar.success(
              context: context,
              message: '${product.name} added to cart!',
            );
            return true;
          },
          message: 'Please login to add items to your cart',
        );
      },
      child: Text('Add to Cart'),
    );
  }
}
```

### Example 4: Settings Page Logout

```dart
class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.logout),
      title: Text('Logout'),
      onTap: () async {
        var confirmDialogResponse = await showDialog<bool>(
          context: context,
          builder: (alertDialogContext) {
            return AlertDialog(
              title: const Text('Logout'),
              content: const Text('Are you sure you want to logout?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(alertDialogContext, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(alertDialogContext, true),
                  child: const Text('Confirm'),
                ),
              ],
            );
          },
        ) ?? false;
        
        if (confirmDialogResponse) {
          await AuthService.logout(context);
        }
      },
    );
  }
}
```

---

## 🎯 Best Practices

### 1. Always Use Context Extensions
```dart
// ✅ Good
if (context.isAuthenticated) {
  // Handle authenticated user
}

// ❌ Avoid
if (AuthService.isAuthenticated()) {
  // Handle authenticated user
}
```

### 2. Provide Clear Messages
```dart
// ✅ Good
context.requireAuth(
  message: 'Please login with your phone number to save your favorite items',
);

// ❌ Avoid
context.requireAuth();
```

### 3. Use Appropriate Snackbar Types
```dart
// ✅ Good
ModernSnackbar.success(context: context, message: 'Profile updated!');
ModernSnackbar.error(context: context, message: 'Failed to save changes');
ModernSnackbar.warning(context: context, message: 'Please check your input');

// ❌ Avoid
ModernSnackbar.show(context: context, message: 'Success!'); // Use specific type
```

### 4. Handle Authentication Gracefully
```dart
// ✅ Good
context.withAuth(
  () async {
    // Perform action
    return result;
  },
  message: 'Please login with your phone number to continue',
);

// ❌ Avoid
if (!context.isAuthenticated) {
  // Manual redirect logic
}
```

### 5. Clear User Data Properly
```dart
// ✅ Good
await AuthService.logout(context); // Handles everything

// ❌ Avoid
await authManager.signOut(); // Only clears Firebase
```

---

## 🔧 Configuration

### Custom Redirect Routes
You can customize the redirect route for different features:

```dart
// For profile features
context.requireAuth(redirectRoute: 'LoginMobileScreen');

// For premium features
context.requireAuth(redirectRoute: 'LoginMobileScreen');

// For admin features
context.requireAuth(redirectRoute: 'LoginMobileScreen');
```

### Custom Snackbar Messages
```dart
// Different messages for different contexts
context.requireAuth(
  message: 'Please login with your phone number to access your saved items',
);

context.requireAuth(
  message: 'Premium feature requires phone number authentication',
);
```

---

## 🐛 Troubleshooting

### Common Issues

1. **Snackbar not showing**: Make sure you have a `Scaffold` in the widget tree
2. **Redirect not working**: Check if the route name exists in your navigation
3. **Authentication not detected**: Verify that both Firebase and JWT tokens are properly set
4. **Data not clearing**: Ensure all SharedPreferences keys are properly handled

### Debug Information
```dart
// Get detailed authentication status for debugging
final status = AuthService.getAuthStatus();
print('Auth Status: $status');
```

---

## 📱 Integration with Existing Code

The new authentication system is designed to work seamlessly with existing code:

1. **Backward Compatible**: Old authentication methods still work
2. **Gradual Migration**: You can migrate features one by one
3. **No Breaking Changes**: Existing functionality remains unchanged
4. **Enhanced Features**: New features are additive, not replacement

This guide should help you implement robust authentication and modern UI feedback throughout your app!
