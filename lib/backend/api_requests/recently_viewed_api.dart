import 'dart:convert';
import 'package:http/http.dart' as http;
import '/auth/jwt_auth_manager.dart';
import '/config/environment_config.dart';

class RecentlyViewedApi {
  static String get _baseUrl => EnvironmentConfig.baseUrl;

  // Get recently viewed products
  static Future<List<Map<String, dynamic>>?> getRecentlyViewedProducts() async {
    print('🔄 [RECENTLY_VIEWED] Starting to fetch recently viewed products');
    print('🔄 [RECENTLY_VIEWED] API URL: $_baseUrl/products/recently-viewed');

    try {
      // Get JWT token for authentication
      final jwtAuthManager = JwtAuthManager.instance;
      final token = await jwtAuthManager.getJwtToken();

      if (token == null) {
        print(
            '🔄 [RECENTLY_VIEWED] No JWT token available, user not authenticated');
        return null;
      }

      print(
          '🔄 [RECENTLY_VIEWED] JWT token available: ${token.substring(0, 50)}...');
      print(
          '🔄 [RECENTLY_VIEWED] Making authenticated request to: $_baseUrl/products/recently-viewed');

      final response = await http.get(
        Uri.parse('$_baseUrl/products/recently-viewed'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'User-Agent': 'IndigoRhapsody/1.0',
        },
      );

      print(
          '🔄 [RECENTLY_VIEWED] Response status code: ${response.statusCode}');
      print('🔄 [RECENTLY_VIEWED] Response headers: ${response.headers}');
      print('🔄 [RECENTLY_VIEWED] Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('🔄 [RECENTLY_VIEWED] Successfully parsed response data: $data');

        // Check if the response has the expected structure
        if (data['products'] != null) {
          final List<dynamic> products = data['products'];
          print(
              '🔄 [RECENTLY_VIEWED] Found ${products.length} recently viewed products');

          // Convert to List<Map<String, dynamic>> and normalize the data structure
          final List<Map<String, dynamic>> productList =
              products.map((product) {
            final Map<String, dynamic> normalizedProduct =
                Map<String, dynamic>.from(product);

            // Normalize the data structure to match what the UI expects
            normalizedProduct['_id'] =
                product['productId']; // Map productId to _id
            normalizedProduct['name'] =
                product['productName']; // Map productName to name
            normalizedProduct['title'] =
                product['productName']; // Also map to title for compatibility
            normalizedProduct['images'] = [
              product['coverImage']
            ]; // Map coverImage to images array
            normalizedProduct['image'] =
                product['coverImage']; // Also map to image for compatibility

            print(
                '🔄 [RECENTLY_VIEWED] Normalized product: ${normalizedProduct['name']}');
            return normalizedProduct;
          }).toList();

          print('🔄 [RECENTLY_VIEWED] Successfully converted to product list');
          return productList;
        } else if (data['success'] == true && data['data'] != null) {
          // Fallback for old structure
          final List<dynamic> products = data['data'];
          print(
              '🔄 [RECENTLY_VIEWED] Found ${products.length} recently viewed products (old structure)');

          final List<Map<String, dynamic>> productList = products
              .map((product) => Map<String, dynamic>.from(product))
              .toList();

          print('🔄 [RECENTLY_VIEWED] Successfully converted to product list');
          return productList;
        } else if (data['success'] == true && data['data'] == null) {
          print(
              '🔄 [RECENTLY_VIEWED] Success but no data (empty recently viewed)');
          return [];
        } else if (data['success'] == true && data['recentlyViewed'] != null) {
          // Alternative response structure
          final List<dynamic> products = data['recentlyViewed'];
          print(
              '🔄 [RECENTLY_VIEWED] Found ${products.length} recently viewed products (alternative structure)');

          final List<Map<String, dynamic>> productList = products
              .map((product) => Map<String, dynamic>.from(product))
              .toList();

          print('🔄 [RECENTLY_VIEWED] Successfully converted to product list');
          return productList;
        } else {
          print('🔄 [RECENTLY_VIEWED] Response structure not as expected');
          print('🔄 [RECENTLY_VIEWED] Response data: $data');
          print('🔄 [RECENTLY_VIEWED] Available keys: ${data.keys.toList()}');
          return null;
        }
      } else if (response.statusCode == 401) {
        print(
            '🔄 [RECENTLY_VIEWED] Authentication failed - token might be expired');
        return null;
      } else if (response.statusCode == 404) {
        print(
            '🔄 [RECENTLY_VIEWED] Endpoint not found - check if URL is correct');
        return null;
      } else {
        final errorData = json.decode(response.body);
        final errorMessage =
            errorData['message'] ?? 'Failed to fetch recently viewed products';
        print(
            '🔄 [RECENTLY_VIEWED] Failed with status ${response.statusCode}: $errorMessage');
        return null;
      }
    } catch (e) {
      print('🔄 [RECENTLY_VIEWED] Exception during API call: $e');
      return null;
    }
  }

  // Track product view (add to recently viewed)
  static Future<bool> trackProductView({
    required String productId,
  }) async {
    print('👁️ [TRACK_VIEW] Tracking product view: $productId');
    print('👁️ [TRACK_VIEW] API URL: $_baseUrl/products/$productId/track-view');

    try {
      // Get JWT token for authentication
      final jwtAuthManager = JwtAuthManager.instance;
      final token = await jwtAuthManager.getJwtToken();

      if (token == null) {
        print(
            '👁️ [TRACK_VIEW] No JWT token available, user not authenticated');
        return false;
      }

      print(
          '👁️ [TRACK_VIEW] JWT token available, making authenticated request');

      final response = await http.post(
        Uri.parse('$_baseUrl/products/$productId/track-view'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('👁️ [TRACK_VIEW] Response status code: ${response.statusCode}');
      print('👁️ [TRACK_VIEW] Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('👁️ [TRACK_VIEW] Successfully tracked product view');
        return true;
      } else {
        final errorData = json.decode(response.body);
        final errorMessage =
            errorData['message'] ?? 'Failed to track product view';
        print(
            '👁️ [TRACK_VIEW] Failed with status ${response.statusCode}: $errorMessage');
        return false;
      }
    } catch (e) {
      print('👁️ [TRACK_VIEW] Exception during API call: $e');
      return false;
    }
  }

  // Test method to debug the API call
  static Future<void> testRecentlyViewedEndpoint() async {
    print('🧪 [TEST] Testing recently viewed endpoint...');

    try {
      final jwtAuthManager = JwtAuthManager.instance;
      final token = await jwtAuthManager.getJwtToken();

      if (token == null) {
        print('🧪 [TEST] No JWT token available');
        return;
      }

      print('🧪 [TEST] JWT token available: ${token.substring(0, 50)}...');

      // Test the endpoint
      final result = await getRecentlyViewedProducts();

      if (result != null) {
        print('🧪 [TEST] Success! Found ${result.length} products');
        if (result.isNotEmpty) {
          print('🧪 [TEST] First product: ${result.first}');
        }
      } else {
        print('🧪 [TEST] Failed to get recently viewed products');
      }
    } catch (e) {
      print('🧪 [TEST] Exception: $e');
    }
  }
}
