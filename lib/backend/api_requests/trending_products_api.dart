import 'dart:convert';
import 'package:http/http.dart' as http;
import '/auth/jwt_auth_manager.dart';
import '/config/environment_config.dart';

class TrendingProductsApi {
  static String get _baseUrl => EnvironmentConfig.baseUrl;

  // Get trending products
  static Future<List<Map<String, dynamic>>?> getTrendingProducts() async {
    print('🔥 [TRENDING] Starting to fetch trending products');
    print('🔥 [TRENDING] API URL: $_baseUrl/products/trending');

    try {
      // Get JWT token for authentication
      final jwtAuthManager = JwtAuthManager.instance;
      final token = await jwtAuthManager.getJwtToken();

      if (token == null) {
        print('🔥 [TRENDING] No JWT token available, user not authenticated');
        return null;
      }

      print('🔥 [TRENDING] JWT token available: ${token.substring(0, 50)}...');
      print(
          '🔥 [TRENDING] Making authenticated request to: $_baseUrl/products/trending');

      final response = await http.get(
        Uri.parse('$_baseUrl/products/trending'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'User-Agent': 'IndigoRhapsody/1.0',
        },
      );

      print('🔥 [TRENDING] Response status code: ${response.statusCode}');
      print('🔥 [TRENDING] Response headers: ${response.headers}');
      print('🔥 [TRENDING] Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('🔥 [TRENDING] Successfully parsed response data: $data');

        // Check if the response has the expected structure
        if (data['products'] != null) {
          final List<dynamic> products = data['products'];
          print('🔥 [TRENDING] Found ${products.length} trending products');

          // Convert to List<Map<String, dynamic>> and normalize the data structure
          final List<Map<String, dynamic>> productList =
              products.map((product) {
            final Map<String, dynamic> normalizedProduct =
                Map<String, dynamic>.from(product);

            // Normalize the data structure to match what the UI expects
            normalizedProduct['_id'] =
                product['productId'] ?? product['_id']; // Map productId to _id
            normalizedProduct['name'] = product['productName'] ??
                product['name']; // Map productName to name
            normalizedProduct['title'] = product['productName'] ??
                product['name']; // Also map to title for compatibility
            normalizedProduct['images'] = product['coverImage'] != null
                ? [product['coverImage']]
                : product['images']; // Map coverImage to images array
            normalizedProduct['image'] = product['coverImage'] ??
                product['image']; // Also map to image for compatibility

            print(
                '🔥 [TRENDING] Normalized product: ${normalizedProduct['name']}');
            return normalizedProduct;
          }).toList();

          print('🔥 [TRENDING] Successfully converted to product list');
          return productList;
        } else if (data['success'] == true && data['data'] != null) {
          // Fallback for old structure
          final List<dynamic> products = data['data'];
          print(
              '🔥 [TRENDING] Found ${products.length} trending products (old structure)');

          final List<Map<String, dynamic>> productList = products
              .map((product) => Map<String, dynamic>.from(product))
              .toList();

          print('🔥 [TRENDING] Successfully converted to product list');
          return productList;
        } else if (data['success'] == true && data['data'] == null) {
          print('🔥 [TRENDING] Success but no data (empty trending products)');
          return [];
        } else {
          print('🔥 [TRENDING] Response structure not as expected');
          print('🔥 [TRENDING] Response data: $data');
          print('🔥 [TRENDING] Available keys: ${data.keys.toList()}');
          return null;
        }
      } else if (response.statusCode == 401) {
        print('🔥 [TRENDING] Authentication failed - token might be expired');
        return null;
      } else if (response.statusCode == 404) {
        print('🔥 [TRENDING] Endpoint not found - check if URL is correct');
        return null;
      } else {
        final errorData = json.decode(response.body);
        final errorMessage =
            errorData['message'] ?? 'Failed to fetch trending products';
        print(
            '🔥 [TRENDING] Failed with status ${response.statusCode}: $errorMessage');
        return null;
      }
    } catch (e) {
      print('🔥 [TRENDING] Exception during API call: $e');
      return null;
    }
  }

  // Test method to debug the API call
  static Future<void> testTrendingEndpoint() async {
    print('🧪 [TEST] Testing trending products endpoint...');

    try {
      final jwtAuthManager = JwtAuthManager.instance;
      final token = await jwtAuthManager.getJwtToken();

      if (token == null) {
        print('🧪 [TEST] No JWT token available');
        return;
      }

      print('🧪 [TEST] JWT token available: ${token.substring(0, 50)}...');

      // Test the endpoint
      final result = await getTrendingProducts();

      if (result != null) {
        print('🧪 [TEST] Success! Found ${result.length} trending products');
        if (result.isNotEmpty) {
          print('🧪 [TEST] First product: ${result.first}');
        }
      } else {
        print('🧪 [TEST] Failed to get trending products');
      }
    } catch (e) {
      print('🧪 [TEST] Exception: $e');
    }
  }
}
