# PhonePe Payment Transaction ID Fix

## Issue
PhonePe SDK error: `merchantTransactionId must not be blank. merchantTransactionId size must be between 1 and 38.`

## Root Cause
The `transactionId` from the payment API response was not being properly extracted, validated, and stored before being passed to PhonePe SDK.

## API Response Structure
```json
{
    "message": "Payment details created successfully",
    "payment": {
        "transactionId": "e04072ed01b85aaff0ae278e3f4a0527",
        "paymentId": "QWERETY1232",
        ...
    }
}
```

## Changes Made

### 1. Enhanced Transaction ID Handling

**File**: `lib/designer/paymentpage/paymentpage_widget.dart`

#### Before:
```dart
if ((_model.apiResult7gm?.succeeded ?? true)) {
  FFAppState().paymentId = BackendAPIGroup
      .createPaymentCall
      .transactionId(
    (_model.apiResult7gm?.jsonBody ?? ''),
  )!;
  safeSetState(() {});
}
// PhonePe API call
if (grandTotal != null && grandTotal > 0) {
  startTransaction(grandTotal);
}
```

#### After:
```dart
if ((_model.apiResult7gm?.succeeded ?? false)) {
  final extractedTransactionId = BackendAPIGroup
      .createPaymentCall
      .transactionId(
    (_model.apiResult7gm?.jsonBody ?? ''),
  );

  print('💳 [PAYMENT] Extracted transactionId: $extractedTransactionId');

  if (extractedTransactionId != null && extractedTransactionId.isNotEmpty) {
    FFAppState().paymentId = extractedTransactionId;
    print('💳 [PAYMENT] Stored in FFAppState().paymentId: ${FFAppState().paymentId}');
    safeSetState(() {});

    // PhonePe API call
    if (grandTotal != null && grandTotal > 0) {
      startTransaction(grandTotal);
    }
  } else {
    print('💳 [PAYMENT] ERROR: Transaction ID is null or empty!');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text(
              'Failed to get transaction ID from payment API')),
    );
  }
}
```

### 2. Added Comprehensive Logging

#### Payment API Response Logging:
```dart
print('💳 [PAYMENT] Create payment API response: ${_model.apiResult7gm?.jsonBody}');
```

#### Transaction ID Extraction Logging:
```dart
print('💳 [PAYMENT] Extracted transactionId: $extractedTransactionId');
print('💳 [PAYMENT] Stored in FFAppState().paymentId: ${FFAppState().paymentId}');
```

#### Checksum Creation Logging:
```dart
print('💳 [PAYMENT] Creating checksum with:');
print('  - merchantId: $merchantId');
print('  - merchantTransactionId: ${FFAppState().paymentId}');
print('  - merchantUserId: ${FFAppState().userId}');
print('  - amount: ${(amount * 100).toInt()}');
print('💳 [PAYMENT] Request data: ${jsonEncode(reqdata)}');
```

#### Transaction Start Logging:
```dart
print('💳 [PAYMENT] Starting transaction with merchantTransactionId: ${FFAppState().paymentId}');
```

### 3. Improved Error Handling

- Changed `(_model.apiResult7gm?.succeeded ?? true)` to `(_model.apiResult7gm?.succeeded ?? false)` for safer null handling
- Added null and empty string validation before storing transaction ID
- Added user-friendly error messages for failed scenarios
- Removed force unwrap (`!`) operator to prevent crashes

## How It Works Now

### Payment Flow:

```
1. User clicks "Place Order"
   ↓
2. Call createPayment API
   ↓
3. Log API response
   ↓
4. Extract transactionId from response.payment.transactionId
   ↓
5. Validate: Is it null or empty?
   ├─ Yes → Show error message
   └─ No → Continue
       ↓
6. Store in FFAppState().paymentId
   ↓
7. Log stored value
   ↓
8. Create checksum with merchantTransactionId
   ↓
9. Log checksum data
   ↓
10. Start PhonePe transaction
    ↓
11. Success or failure
```

## Console Logs to Check

When you run the payment flow, check for these logs:

### Successful Flow:
```
💳 [PAYMENT] Create payment API response: {"message":"Payment details created successfully","payment":{"transactionId":"e04072ed01b85aaff0ae278e3f4a0527",...}}
💳 [PAYMENT] Extracted transactionId: e04072ed01b85aaff0ae278e3f4a0527
💳 [PAYMENT] Stored in FFAppState().paymentId: e04072ed01b85aaff0ae278e3f4a0527
💳 [PAYMENT] Starting transaction with merchantTransactionId: e04072ed01b85aaff0ae278e3f4a0527
💳 [PAYMENT] Creating checksum with:
  - merchantId: M1LA2M87XNOE
  - merchantTransactionId: e04072ed01b85aaff0ae278e3f4a0527
  - merchantUserId: 68ccf8d9c585b659b38bc7ed
  - amount: 200
💳 [PAYMENT] Request data: {"merchantId":"M1LA2M87XNOE","merchantTransactionId":"e04072ed01b85aaff0ae278e3f4a0527",...}
```

### Failed Flow (Transaction ID extraction failed):
```
💳 [PAYMENT] Create payment API response: {...}
💳 [PAYMENT] Extracted transactionId: null
💳 [PAYMENT] ERROR: Transaction ID is null or empty!
```

### Failed Flow (API call failed):
```
💳 [PAYMENT] ERROR: Create payment API failed
```

## Debugging Steps

If the issue persists:

### 1. Check API Response
Verify the API returns the correct structure:
```json
{
  "payment": {
    "transactionId": "xxx"
  }
}
```

### 2. Check Extraction Path
In `lib/backend/api_requests/api_calls.dart`, verify:
```dart
String? transactionId(dynamic response) => castToType<String>(getJsonField(
  response,
  r'''$.payment.transactionId''',  // Path must match response structure
));
```

### 3. Check State Management
Verify `FFAppState().paymentId` is properly defined in `lib/app_state.dart`:
```dart
String paymentId = '';
```

### 4. Check Timing
Ensure `safeSetState()` is called after storing the value and before starting the transaction.

## Testing Checklist

- [ ] API returns valid transactionId
- [ ] Console shows extracted transactionId (not null)
- [ ] Console shows stored value in FFAppState
- [ ] Console shows merchantTransactionId when creating checksum
- [ ] PhonePe SDK receives non-empty merchantTransactionId
- [ ] Payment flow completes without errors

## Common Issues

### Issue 1: Transaction ID is null
**Cause**: API response structure doesn't match extraction path
**Solution**: Check the JSON path in `api_calls.dart` matches your API response

### Issue 2: Transaction ID is empty string
**Cause**: API returns empty string or backend doesn't generate transaction ID
**Solution**: Check backend payment creation logic

### Issue 3: State not persisting
**Cause**: `safeSetState()` not called or state cleared before use
**Solution**: Ensure state is set and saved before calling `startTransaction()`

### Issue 4: Timing issue
**Cause**: `startTransaction()` called before state is set
**Solution**: Code now ensures transaction only starts after successful validation and storage

## Files Modified

1. `lib/designer/paymentpage/paymentpage_widget.dart` - Main payment logic with fixes

## API Configuration

Ensure your backend returns the transaction ID in the correct format:

**Endpoint**: `/payment/createPayment`

**Response**:
```json
{
  "message": "Payment details created successfully",
  "payment": {
    "transactionId": "e04072ed01b85aaff0ae278e3f4a0527",  // ← Must be present and non-empty
    "paymentId": "QWERETY1232",
    "paymentMethod": "phonepe",
    ...
  }
}
```

## Next Steps

1. Run the app
2. Attempt a PhonePe payment
3. Check console logs for the payment flow
4. Verify merchantTransactionId is passed to PhonePe SDK
5. Confirm payment completes successfully

---

**The fix ensures that the transaction ID is properly validated and stored before being passed to PhonePe SDK, preventing the "merchantTransactionId must not be blank" error.**

