import '/backend/api_requests/recently_viewed_api.dart';

class RecentlyViewedHelper {
  // Callback to notify when products are added
  static Function()? _onProductAdded;

  /// Set callback to be called when a product is added to recently viewed
  static void setOnProductAddedCallback(Function() callback) {
    _onProductAdded = callback;
  }

  /// Remove the callback
  static void removeOnProductAddedCallback() {
    _onProductAdded = null;
  }

  /// Track product view (add to recently viewed)
  /// This function can be called from anywhere in the app
  static Future<bool> trackProductView(String productId) async {
    try {
      print('👁️ [RECENTLY_VIEWED_HELPER] Tracking product view: $productId');
      final success = await RecentlyViewedApi.trackProductView(
        productId: productId,
      );

      if (success) {
        print('👁️ [RECENTLY_VIEWED_HELPER] Successfully tracked product view');

        // Notify callback if set
        if (_onProductAdded != null) {
          print('👁️ [RECENTLY_VIEWED_HELPER] Notifying UI to refresh');
          _onProductAdded!();
        }
      } else {
        print('👁️ [RECENTLY_VIEWED_HELPER] Failed to track product view');
      }

      return success;
    } catch (e) {
      print('👁️ [RECENTLY_VIEWED_HELPER] Error tracking product view: $e');
      return false;
    }
  }

  /// Get recently viewed products
  /// This function can be called from anywhere in the app
  static Future<List<Map<String, dynamic>>?> getRecentlyViewedProducts() async {
    try {
      print('🔄 [RECENTLY_VIEWED_HELPER] Getting recently viewed products');
      final products = await RecentlyViewedApi.getRecentlyViewedProducts();

      if (products != null) {
        print(
            '🔄 [RECENTLY_VIEWED_HELPER] Successfully loaded ${products.length} recently viewed products');
      } else {
        print(
            '🔄 [RECENTLY_VIEWED_HELPER] Failed to load recently viewed products');
      }

      return products;
    } catch (e) {
      print(
          '🔄 [RECENTLY_VIEWED_HELPER] Error getting recently viewed products: $e');
      return null;
    }
  }

  /// Legacy method for backward compatibility
  /// @deprecated Use trackProductView instead
  static Future<bool> addProductToRecentlyViewed(String productId) async {
    print(
        '⚠️ [RECENTLY_VIEWED_HELPER] addProductToRecentlyViewed is deprecated, use trackProductView instead');
    return trackProductView(productId);
  }
}
