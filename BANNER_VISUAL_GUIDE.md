# Banner Display Visual Guide

## How Banners Will Appear on Homepage

### Banner Structure

Based on your API response, here's how the banners will be displayed:

```
┌────────────────────────────────────────────────────────┐
│                                                        │
│                    Banner Image                        │
│              (Auto-selected based on                   │
│               screen size: desktop/                    │
│              tablet/mobile images)                     │
│                                                        │
│                                                        │
│  ┌──────────────────────────────────────────────┐    │
│  │  ╔════════════════════════════════════════╗  │    │
│  │  ║                                        ║  │    │
│  │  ║  Welcome to Our Store11                ║  │    │
│  │  ║  (title - Bold, 20px, white)          ║  │    │
│  │  ║                                        ║  │    │
│  │  ║  Shop the Latest Fashion11             ║  │    │
│  │  ║  (subtitle - Regular, 16px, white)    ║  │    │
│  │  ║                                        ║  │    │
│  │  ║  ┌──────────────┐                     ║  │    │
│  │  ║  │  Shop Now    │                     ║  │    │
│  │  ║  └──────────────┘                     ║  │    │
│  │  ║  (Button with custom color #FF6B6B)   ║  │    │
│  │  ╚════════════════════════════════════════╝  │    │
│  │       (Dark gradient overlay)                │    │
│  └──────────────────────────────────────────────┘    │
│                                                        │
│                    ● ● ○                               │
│              (Page indicators for                      │
│               multiple banners)                        │
└────────────────────────────────────────────────────────┘
```

## API Response Mapping

### Example 1: Banner with Image
```json
{
  "title": "Welcome to Our Store11",
  "subtitle": "Shop the Latest Fashion11",
  "buttonText": "Shop Now",
  "buttonColor": "#FF6B6B",
  "textColor": "#FFFFFF",
  "actionUrl": "/products",
  "image": "https://cdn.example.com/banner.jpg"
}
```

**Result**: Banner displays with image, title, subtitle, and "Shop Now" button in red (#FF6B6B)

### Example 2: Banner with Responsive Images
```json
{
  "title": "Summer Sale",
  "subtitle": "Up to 50% Off",
  "images": {
    "web": {
      "desktop": "https://cdn.example.com/desktop-1920x600.jpg",
      "tablet": "https://cdn.example.com/tablet-1024x400.jpg"
    },
    "mobile": "https://cdn.example.com/mobile-750x400.jpg"
  },
  "buttonText": "Shop Now",
  "buttonColor": "#4CAF50",
  "textColor": "#FFFFFF",
  "actionUrl": "/sale"
}
```

**Result**: 
- Desktop (>1024px): Shows `desktop` image
- Tablet (768-1024px): Shows `tablet` image  
- Mobile (<768px): Shows `mobile` image

### Example 3: Banner without Button
```json
{
  "title": "New Collection",
  "subtitle": "Spring 2025",
  "image": "https://cdn.example.com/collection.jpg",
  "textColor": "#FFFFFF",
  "actionUrl": "/collection/spring-2025"
}
```

**Result**: Banner displays with only title and subtitle (no button). Tapping anywhere on the banner navigates to `/collection/spring-2025`

## Interactive Features

### 1. **Swipe Navigation**
Users can swipe left/right to view multiple banners
```
Banner 1  →  Banner 2  →  Banner 3
   ●           ○           ○
```

### 2. **Tap Actions**
- **Tap on Banner**: Navigates to `actionUrl`
- **Tap on Button**: Also navigates to `actionUrl` (with console log)

### 3. **Loading States**

**Initial Load:**
```
┌────────────────────────────────────┐
│  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓   │
│  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓   │
│  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓   │
└────────────────────────────────────┘
     (Shimmer loading animation)
```

**Error State:**
```
┌────────────────────────────────────┐
│                                    │
│           ⚠                        │
│    Error loading banners           │
│                                    │
└────────────────────────────────────┘
```

**Empty State:**
```
┌────────────────────────────────────┐
│                                    │
│           📭                       │
│     No banners available           │
│                                    │
└────────────────────────────────────┘
```

## Responsive Behavior

### Mobile (< 768px)
- Banner height: ~20% of screen height
- Uses `images.mobile` if available
- Compact text and button layout
- Horizontal margins: 10px

### Tablet (768px - 1024px)
- Banner height: ~20% of screen height
- Uses `images.web.tablet` if available
- Medium text sizes
- Horizontal margins: 10px

### Desktop (> 1024px)
- Banner height: ~20% of screen height
- Uses `images.web.desktop` if available
- Larger text sizes
- Horizontal margins: 10px

## Color Customization

Your API supports custom colors for each banner:

```dart
// Example color values from API
buttonColor: "#FF6B6B"  // Coral red button
textColor: "#FFFFFF"     // White text

// These are automatically converted to Flutter Color objects
```

Supported color formats:
- `#RRGGBB` (e.g., `#FF6B6B`)
- `#AARRGGBB` (e.g., `#80FF6B6B` for semi-transparent)

## Console Output

When running the app, you'll see:
```
🔍 [BANNERS] Fetching banners from https://indigo-rhapsody-backend-ten.vercel.app/banner/platform/web
🔍 [BANNERS] Response status: 200
🔍 [BANNERS] Found 2 banners
🔍 [BANNERS] Banner 0: Welcome to Our Store11 - Platform: mobile
🔍 [BANNERS]   Button: Shop Now - Action: /products
🔍 [BANNERS] Banner 1: Welcome to Our Store11 - Platform: mobile
🔍 [BANNERS]   Button: Shop Now - Action: /products
```

When a banner is tapped:
```
🔍 [BANNERS] Banner tapped: /products
```

When a button is tapped:
```
🔍 [BANNERS] Button tapped: /products
```

## Testing Your Banners

1. **Run the app**: `flutter run`
2. **Navigate to Homepage**: The app starts on the homepage
3. **Observe the banner section**: Located at the top, below the app bar
4. **Test interactions**:
   - Swipe left/right to view multiple banners
   - Tap on a banner to test navigation
   - Tap on a button to test button action
5. **Check console logs**: Verify API calls and responses

## Troubleshooting

### No banners showing?
- Check console for API errors
- Verify the endpoint is accessible: `https://indigo-rhapsody-backend-ten.vercel.app/banner/platform/web`
- Ensure `isActive: true` in your banner data

### Images not loading?
- Verify image URLs are valid and accessible
- Check if images are HTTPS (required for Flutter web)
- Look for CORS issues in browser console (for Flutter web)

### Button not showing?
- Ensure `buttonText` field is not empty in API response
- Check if banner has `actionUrl` defined

### Colors not working?
- Verify color format is valid hex (e.g., `#FF6B6B`)
- Colors must include `#` prefix
- Check console for color parsing errors

