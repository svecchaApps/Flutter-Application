# Banner Display Debugging Guide

## Issue
Banners are not visible on the homepage even though the API response contains banner data.

## Enhanced Debugging

I've added comprehensive logging to help identify the issue. When you run the app, look for these console logs:

### 1. API Call Logs

When the homepage loads, you should see:

```
🔍 [BANNERS] Testing banners endpoint...
🔍 [BANNERS] Fetching banners from https://indigo-rhapsody-backend-ten.vercel.app/banner/platform/web
🔍 [BANNERS] Response status: 200
🔍 [BANNERS] Response body length: XXXX
🔍 [BANNERS] Parsed response success: true
🔍 [BANNERS] Found 1 banners
```

### 2. Banner Data Logs

For each banner found, you'll see:

```
🔍 [BANNERS] Banner 0:
   - Title: Welcome to Our Store
   - Image: https://cdn.thevoiceoffashion.com/article_images/Banner2-5f80140f9e402.jpg
   - Platform: web
   - isActive: true
```

### 3. Image Selection Logs

When the banner is displayed, you'll see:

```
🔍 [BANNERS] Getting image for banner: Welcome to Our Store
🔍 [BANNERS] Screen width: 411.4
🔍 [BANNERS] Found images object: {web: {desktop: https://via.placeholder.com/1920x600, tablet: https://via.placeholder.com/1024x400}, mobile: }
🔍 [BANNERS] Found web images: {desktop: https://via.placeholder.com/1920x600, tablet: https://via.placeholder.com/1024x400}
🔍 [BANNERS] Using desktop image: https://via.placeholder.com/1920x600
```

OR

```
🔍 [BANNERS] Using main image field: https://cdn.thevoiceoffashion.com/article_images/Banner2-5f80140f9e402.jpg
```

## Steps to Debug

### Step 1: Run the App

```bash
flutter run
```

### Step 2: Watch Console Output

Look for the `🔍 [BANNERS]` logs when the homepage loads.

### Step 3: Identify the Issue

#### Scenario A: No API Logs at All
**Problem**: Homepage not calling the API
**Solution**: Check that `BannersApi.testBannersEndpoint()` is called in homepage initState

#### Scenario B: HTTP Error (Status ≠ 200)
```
🔍 [BANNERS] Response status: 404
🔍 [BANNERS] Error: HTTP 404
```
**Problem**: Endpoint not found
**Solution**: Verify API endpoint is correct and accessible

#### Scenario C: Empty Response
```
🔍 [BANNERS] Found 0 banners
```
**Problem**: API returns no banners
**Solution**: 
- Check API filters (platform, isActive, page)
- Verify banners exist in backend for platform "web"

#### Scenario D: Banners Found But Not Visible
```
🔍 [BANNERS] Found 1 banners
🔍 [BANNERS] Banner 0: (details shown)
```
**Problem**: UI not rendering banners
**Solutions**:
1. Check if banner container height is correct
2. Verify image URLs are valid and accessible
3. Check for network/CORS issues with images
4. Look for any Flutter widget errors in console

#### Scenario E: Image Loading Issues
```
🔍 [BANNERS] Using desktop image: https://via.placeholder.com/1920x600
```
**Problem**: Placeholder images or broken image URLs
**Solution**: Check if image URLs in API response are valid and accessible

## Common Issues & Solutions

### Issue 1: Banner Height Too Small

The banner container has height: `MediaQuery.of(context).size.height * 0.2`

If your screen is small, this might be too small to display properly.

**Fix**: Increase the height in `homepage_widget.dart` line 658:

```dart
height: MediaQuery.of(context).size.height * 0.25, // Changed from 0.2 to 0.25
```

### Issue 2: Images Not Loading (CORS/Network)

If images fail to load, you'll see the gradient placeholder.

**Check**:
1. Image URLs are accessible in browser
2. Images are HTTPS (required for Flutter web)
3. CORS headers allow access from your app

**Test**: Open image URL in browser:
```
https://cdn.thevoiceoffashion.com/article_images/Banner2-5f80140f9e402.jpg
```

### Issue 3: Widget Not in View

The banner might be outside the visible area.

**Fix**: Scroll up on the homepage to see the banner section (it's at the top).

### Issue 4: FutureBuilder Error

Look for Flutter widget errors:

```
════════ Exception caught by widgets library ═════════════════════════════════
```

This indicates a problem with the widget rendering.

## Quick Test

To quickly test if banners can display, temporarily hardcode the data in `homepage_widget.dart`:

```dart
// Replace FutureBuilder with this temporarily:
final banners = [
  {
    'title': 'Test Banner',
    'subtitle': 'Test Subtitle',
    'image': 'https://via.placeholder.com/1920x600',
    'buttonText': 'Shop Now',
    'buttonColor': '#FF6B6B',
    'textColor': '#FFFFFF',
    'actionUrl': '/products',
  }
];

return Stack(
  children: [
    PageView.builder(
      itemCount: banners.length,
      itemBuilder: (context, index) {
        // ... rest of the code
      },
    ),
  ],
);
```

If this displays, the issue is with the API. If it doesn't, the issue is with the UI rendering.

## Check List

- [ ] App runs without errors
- [ ] Console shows `🔍 [BANNERS] Fetching banners...`
- [ ] Console shows `🔍 [BANNERS] Found X banners` (X > 0)
- [ ] Console shows banner details (title, image, platform)
- [ ] Console shows image selection logs
- [ ] No Flutter widget errors in console
- [ ] Banner container height is adequate
- [ ] Image URLs are accessible
- [ ] Scrolled to top of homepage to see banners

## Expected Behavior

When working correctly, you should see:

```
┌─────────────────────────────────────────┐
│  Homepage                               │
├─────────────────────────────────────────┤
│                                         │
│  ┌───────────────────────────────────┐ │
│  │                                   │ │
│  │      Banner Image                 │ │
│  │                                   │ │
│  │  ┌─────────────────────────────┐ │ │
│  │  │ Welcome to Our Store        │ │ │
│  │  │ Shop the Latest Fashion     │ │ │
│  │  │ [Shop Now]                  │ │ │
│  │  └─────────────────────────────┘ │ │
│  └───────────────────────────────────┘ │
│           ● ○ ○                        │
│                                         │
└─────────────────────────────────────────┘
```

## Getting Help

When reporting issues, include:

1. **Console logs**: All `🔍 [BANNERS]` logs
2. **Flutter logs**: Any error messages
3. **Device info**: Device type, screen size
4. **API response**: The raw JSON from `/banner/platform/web`
5. **Screenshots**: What you see (or don't see) on the homepage

## Next Steps

1. Run the app
2. Check console for the detailed logs
3. Identify which scenario matches your situation
4. Apply the corresponding solution
5. If issue persists, share the console logs for further debugging

---

**Note**: The enhanced logging will help pinpoint exactly where the issue is occurring in the banner loading and display process.

