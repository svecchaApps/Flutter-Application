# Cart Address Update Implementation

## Overview
Implemented automatic cart address update when users select a delivery address on the payment page.

## API Endpoint

**URL**: `PUT /cart/update-address/:userId`

**Headers**:
```
Content-Type: application/json
Authorization: Bearer <your-jwt-token>
```

**Request Body**:
```json
{
  "address": {
    "street": "123 Main Street",
    "city": "Mumbai",
    "state": "Maharashtra",
    "pincode": "400001",
    "country": "India",
    "phoneNumber": "+91-9876543210"
  }
}
```

**Response**:
```json
{
  "success": true,
  "message": "Cart address updated successfully",
  "cart": {
    // Updated cart object
  }
}
```

## Implementation

### 1. API Call Definition

**File**: `lib/backend/api_requests/api_calls.dart`

Created `UpdateCartAddressCall` class:

```dart
class UpdateCartAddressCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? street = '',
    String? city = '',
    String? state = '',
    String? pincode = '',
    String? country = 'India',
    String? phoneNumber = '',
  }) async {
    // API implementation
  }
}
```

**Usage**:
```dart
final response = await BackendAPIGroup.updateCartAddressCall.call(
  userId: FFAppState().userId,
  street: '123 Main Street',
  city: 'Mumbai',
  state: 'Maharashtra',
  pincode: '400001',
  country: 'India',
  phoneNumber: '+91-9876543210',
);
```

### 2. Payment Page Integration

**File**: `lib/designer/paymentpage/paymentpage_widget.dart`

#### When User Selects Address:

1. **Address Selection** (Line 479-559):
   - User taps on an address
   - Address details are stored in `FFAppState()`
   - API call is automatically triggered
   - Modern toast notification shows status

#### Flow:

```
User Taps Address
      ↓
Store in FFAppState
      ↓
Call Update Cart Address API
      ↓
┌─────────────────┬──────────────────┐
│   Success       │      Error       │
├─────────────────┼──────────────────┤
│ Show Success    │ Show Error       │
│ Toast (Green)   │ Toast (Red)      │
│                 │                  │
│ "Address        │ "Address Update  │
│  Selected"      │  Failed"         │
└─────────────────┴──────────────────┘
```

## Modern Toast Notifications

### Success Toast
```dart
ModernSnackbar.success(
  context: context,
  message: 'Address Selected',
  subtitle: 'Delivery address has been updated',
  duration: const Duration(seconds: 2),
);
```

**Visual**:
```
┌──────────────────────────────────────────┐
│ [✓] Address Selected            [×]     │
│     Delivery address has been updated   │
└──────────────────────────────────────────┘
```

### Error Toast
```dart
ModernSnackbar.error(
  context: context,
  message: 'Address Update Failed',
  subtitle: 'Please try selecting the address again',
);
```

**Visual**:
```
┌──────────────────────────────────────────┐
│ [✗] Address Update Failed       [×]     │
│     Please try selecting the address    │
│     again                                │
└──────────────────────────────────────────┘
```

## Code Changes

### Address Selection Handler

**Before**:
```dart
onTap: () {
  setState(() {
    selectedIndex = newbodyIndex;
    FFAppState().state = getJsonField(newbodyItem, r'''$.state''').toString();
    FFAppState().city = getJsonField(newbodyItem, r'''$.city''').toString();
    // ... other fields
  });
},
```

**After**:
```dart
onTap: () async {
  setState(() {
    selectedIndex = newbodyIndex;
    FFAppState().state = getJsonField(newbodyItem, r'''$.state''').toString();
    FFAppState().city = getJsonField(newbodyItem, r'''$.city''').toString();
    // ... other fields
  });

  // Update cart address via API
  print('📍 [ADDRESS] Updating cart address...');
  try {
    final phoneNumber = getJsonField(
      newbodyItem,
      r'''$.phone_number''',
    )?.toString() ?? '';

    final updateResponse = await BackendAPIGroup
        .updateCartAddressCall
        .call(
      userId: FFAppState().userId,
      street: FFAppState().address,
      city: FFAppState().city,
      state: FFAppState().state,
      pincode: FFAppState().pincode,
      country: 'India',
      phoneNumber: phoneNumber.isNotEmpty
          ? phoneNumber
          : '+91-0000000000',
    );

    if (updateResponse.succeeded) {
      print('📍 [ADDRESS] Cart address updated successfully');
      if (context.mounted) {
        ModernSnackbar.success(
          context: context,
          message: 'Address Selected',
          subtitle: 'Delivery address has been updated',
          duration: const Duration(seconds: 2),
        );
      }
    } else {
      print('📍 [ADDRESS] Failed to update cart address');
      if (context.mounted) {
        ModernSnackbar.error(
          context: context,
          message: 'Address Update Failed',
          subtitle: 'Please try selecting the address again',
        );
      }
    }
  } catch (e) {
    print('📍 [ADDRESS] Error updating cart address: $e');
    if (context.mounted) {
      ModernSnackbar.error(
        context: context,
        message: 'Error',
        subtitle: 'Failed to update delivery address',
      );
    }
  }
},
```

## Features

### ✅ Implemented
- Automatic cart address update on selection
- Modern toast notifications for success/error
- Error handling and logging
- Context-aware UI updates (context.mounted check)
- Fallback phone number if not provided
- Console logging for debugging

### 🎯 User Experience
1. **Instant Feedback**: User sees toast immediately after selecting address
2. **Clear Messages**: Success or error is clearly communicated
3. **Non-Blocking**: API call happens in background, doesn't freeze UI
4. **Visual Confirmation**: Green checkmark icon confirms selection

## Console Logs

### Successful Update
```
📍 [ADDRESS] Updating cart address...
📍 [ADDRESS] Cart address updated successfully
```

### Failed Update
```
📍 [ADDRESS] Updating cart address...
📍 [ADDRESS] Failed to update cart address
```

### Error
```
📍 [ADDRESS] Updating cart address...
📍 [ADDRESS] Error updating cart address: [error details]
```

## Error Handling

| Scenario | Handling | User Feedback |
|----------|----------|---------------|
| API Success | Continue normal flow | Green success toast |
| API Failure | Log error, show message | Red error toast |
| Network Error | Catch exception | Red error toast with generic message |
| Missing Phone | Use fallback | API call proceeds with default |
| Context Disposed | Check `context.mounted` | No toast shown |

## Testing

### Test Scenarios

1. **Happy Path**:
   - Select an address
   - Verify success toast appears
   - Check console for success log
   - Verify cart is updated in backend

2. **Error Path**:
   - Disconnect network
   - Select an address
   - Verify error toast appears
   - Check console for error log

3. **Edge Cases**:
   - Select address without phone number
   - Select address with invalid data
   - Rapid address changes

### Manual Test Steps

1. Go to payment page
2. View address list
3. Tap on an address
4. Observe:
   - Address gets selected (checkmark appears)
   - Success toast appears at top
   - Console shows success log
5. Verify in backend that cart address is updated

## Files Modified

1. **`lib/backend/api_requests/api_calls.dart`**
   - Added `UpdateCartAddressCall` class
   - Registered in `BackendAPIGroup`

2. **`lib/designer/paymentpage/paymentpage_widget.dart`**
   - Updated address selection handler
   - Added API call integration
   - Added modern toast notifications
   - Imported `modern_snackbar.dart`

## Dependencies

- `modern_snackbar.dart` - For beautiful toast notifications
- `api_calls.dart` - For API communication
- `api_manager.dart` - For HTTP requests

## Backend Requirements

### Endpoint must:
- Accept PUT request at `/cart/update-address/:userId`
- Expect JSON body with address object
- Return success/error response
- Update cart with provided address
- Handle JWT authentication (if required)

### Expected Response:
```json
{
  "success": true,
  "message": "Cart address updated successfully",
  "cart": {
    "userId": "...",
    "deliveryAddress": {
      "street": "123 Main Street",
      "city": "Mumbai",
      "state": "Maharashtra",
      "pincode": "400001",
      "country": "India",
      "phoneNumber": "+91-9876543210"
    }
  }
}
```

## Future Enhancements

- [ ] Add address validation before API call
- [ ] Show loading indicator during API call
- [ ] Cache last selected address
- [ ] Add retry mechanism for failed updates
- [ ] Validate phone number format
- [ ] Support international addresses
- [ ] Add address edit inline
- [ ] Show delivery time estimate for selected address

## Troubleshooting

### Issue: Toast not showing
**Solution**: Check that `modern_snackbar.dart` is imported and context is mounted

### Issue: API call failing
**Solution**: 
- Check backend endpoint is running
- Verify JWT token is valid
- Check network connectivity
- Verify userId is not empty

### Issue: Phone number field missing
**Solution**: API uses fallback '+91-0000000000' if phone number is empty

### Issue: Address not updating in cart
**Solution**: 
- Check backend logs
- Verify userId matches cart userId
- Ensure address fields are not empty

---

**Implementation Complete! Users can now select addresses and have their cart automatically updated with beautiful toast notifications! 🎉**

