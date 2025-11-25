# Banner API Integration Guide

## Overview
This document describes the integration of the banner API endpoint (`/banner/platform/web`) into the homepage of the Indigo Rhapsody Flutter application.

## API Endpoint
- **URL**: `https://indigo-rhapsody-backend-ten.vercel.app/banner/platform/web`
- **Method**: GET
- **Headers**: 
  - Accept: application/json
  - Content-Type: application/json

## Response Structure
```json
{
  "success": true,
  "data": [
    {
      "_id": "68ec0d6b2b66bb706a75f411",
      "name": "Test Web Banner111",
      "title": "Welcome to Our Store11",
      "subtitle": "Shop the Latest Fashion11",
      "description": "",
      "platform": "mobile",
      "image": "",
      "images": {
        "web": {
          "desktop": "",
          "tablet": ""
        },
        "mobile": ""
      },
      "page": "home",
      "actionType": "url",
      "actionUrl": "/products",
      "buttonText": "Shop Now",
      "buttonColor": "#FF6B6B",
      "textColor": "#FFFFFF",
      "isActive": true,
      "displayOrder": 0
    }
  ],
  "count": 2,
  "pagination": {
    "total": 2,
    "limit": 50,
    "skip": 0,
    "hasMore": false
  }
}
```

## Implementation Details

### 1. BannersApi Class (`lib/backend/api_requests/banners_api.dart`)

#### Methods:
- **`getBanners()`**: Fetches banners from the API endpoint
  - Returns `Future<List<Map<String, dynamic>>>`
  - Handles success/error states
  - Parses the nested response structure

- **`getBannerImage(banner, screenWidth)`**: Intelligently selects the appropriate image URL
  - Checks for platform-specific images (web.desktop, web.tablet, mobile)
  - Falls back to the main `image` field if platform-specific images are empty
  - Returns placeholder image if no valid image is found
  - Responsive based on screen width

- **`testBannersEndpoint()`**: Test method for debugging the API connection

### 2. Homepage Integration (`lib/designer/homepage/homepage_widget.dart`)

#### Features:
- **FutureBuilder**: Loads banners asynchronously
- **Shimmer Loading**: Shows loading state while fetching banners
- **Error Handling**: Displays error message if API fails
- **Empty State**: Shows message when no banners are available

#### Banner Display:
- **PageView**: Swipeable banner carousel
- **Responsive Images**: Automatically selects appropriate image based on screen size
- **Title & Subtitle**: Displays banner title and subtitle with proper styling
- **Custom Colors**: Uses banner-specific colors for text and buttons
- **Action Button**: Displays customizable CTA button with banner-specific text and color
- **Page Indicators**: Shows dots for multiple banners

#### Helper Methods:
- **`_parseColor(hexColor)`**: Converts hex color strings (e.g., "#FF6B6B") to Flutter Color objects

## Banner Fields Supported

| Field | Type | Description | Used In UI |
|-------|------|-------------|-----------|
| `title` | String | Main banner title | Yes - Bold text |
| `subtitle` | String | Banner subtitle | Yes - Regular text |
| `description` | String | Detailed description | No (reserved for future use) |
| `image` | String | Fallback image URL | Yes - As fallback |
| `images.web.desktop` | String | Desktop-specific image | Yes - For wide screens |
| `images.web.tablet` | String | Tablet-specific image | Yes - For medium screens |
| `images.mobile` | String | Mobile-specific image | Yes - For small screens |
| `buttonText` | String | CTA button text | Yes - Button label |
| `buttonColor` | String (hex) | Button background color | Yes - Button styling |
| `textColor` | String (hex) | Text color | Yes - Text styling |
| `actionUrl` | String | Navigation URL on tap | Yes - Click handler |
| `platform` | String | Platform filter | No (filtered by API) |
| `isActive` | Boolean | Banner visibility | No (filtered by API) |

## Visual Design

### Banner Layout:
```
┌─────────────────────────────────────┐
│                                     │
│         Banner Image                │
│         (Responsive)                │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ Title (Bold, 20px)          │   │
│  │ Subtitle (Regular, 16px)    │   │
│  │ [Shop Now Button]           │   │
│  └─────────────────────────────┘   │
└─────────────────────────────────────┘
         • • ○  (Page indicators)
```

### Styling:
- **Container**: Rounded corners (12px), shadow
- **Overlay**: Gradient from transparent to black (0.7 opacity)
- **Spacing**: 16px padding in content area
- **Typography**: Custom font sizes with color from API
- **Button**: Rounded corners (8px), custom colors from API

## Testing

The API can be tested by:
1. Running the app
2. Navigating to the homepage
3. Checking console logs for banner fetch status
4. Observing the banner carousel at the top of the page

### Test Endpoint:
```dart
// Called automatically on homepage init
BannersApi.testBannersEndpoint();
```

## Error Handling

1. **Network Errors**: Shows error icon and message
2. **Empty Response**: Shows "No banners available" message
3. **Invalid Images**: Shows gradient placeholder
4. **Invalid Colors**: Falls back to white color
5. **Loading State**: Shows shimmer loading animation

## Future Enhancements

- [ ] Analytics tracking (impression count, click count)
- [ ] Deep link navigation for actionUrl
- [ ] Video banner support
- [ ] Auto-play carousel with configurable timing
- [ ] A/B testing support for different banner variants
- [ ] Cache banners locally for offline viewing
- [ ] Pull-to-refresh support

## Files Modified

1. `lib/backend/api_requests/banners_api.dart` - API service layer
2. `lib/designer/homepage/homepage_widget.dart` - UI integration

## Dependencies

No new dependencies were added. Uses existing packages:
- `http` - For API calls
- `flutter/material.dart` - For UI components

