import 'package:http/http.dart' as http;
import 'dart:convert';
import '/config/environment_config.dart';

class BannersApi {
  static String get _baseUrl => EnvironmentConfig.baseUrl;

  /// Fetch banners from the /banner/platform/web endpoint
  static Future<List<Map<String, dynamic>>> getBanners() async {
    try {
      final endpoint = '$_baseUrl/banner/platform/web';
      print('🔍 [BANNERS] Fetching banners from $endpoint');

      final response = await http.get(
        Uri.parse(endpoint),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'User-Agent': 'IndigoRhapsody/1.0',
        },
      );

      print('🔍 [BANNERS] Response status: ${response.statusCode}');
      print('🔍 [BANNERS] Response body length: ${response.body.length}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(
            '🔍 [BANNERS] Parsed response success: ${responseData['success']}');

        // Check if the request was successful
        if (responseData['success'] == true) {
          final List<dynamic> banners = responseData['data'] ?? [];
          print('🔍 [BANNERS] Found ${banners.length} banners');

          // Debug: Print each banner
          for (int i = 0; i < banners.length; i++) {
            final banner = banners[i];
            print('🔍 [BANNERS] Banner $i:');
            print('   - Title: ${banner['title']}');
            print('   - Image: ${banner['image']}');
            print('   - Platform: ${banner['platform']}');
            print('   - isActive: ${banner['isActive']}');
          }

          return banners
              .map((banner) => Map<String, dynamic>.from(banner))
              .toList();
        } else {
          print('🔍 [BANNERS] Error: API returned success: false');
          return [];
        }
      } else {
        print('🔍 [BANNERS] Error: HTTP ${response.statusCode}');
        return [];
      }
    } catch (e, stackTrace) {
      print('🔍 [BANNERS] Exception: $e');
      print('🔍 [BANNERS] Stack trace: $stackTrace');
      return [];
    }
  }

  /// Get the appropriate image URL based on screen size
  static String getBannerImage(
    Map<String, dynamic> banner,
    double screenWidth,
  ) {
    try {
      print('🔍 [BANNERS] Getting image for banner: ${banner['title']}');
      print('🔍 [BANNERS] Screen width: $screenWidth');

      // First, check for platform-specific images
      if (banner['images'] != null && banner['images'] is Map) {
        final images = banner['images'] as Map<String, dynamic>;
        print('🔍 [BANNERS] Found images object: $images');

        // Check for web images
        if (images['web'] != null && images['web'] is Map) {
          final webImages = images['web'] as Map<String, dynamic>;
          print('🔍 [BANNERS] Found web images: $webImages');

          // For tablets and smaller devices
          if (screenWidth < 1024 && webImages['tablet'] != null) {
            final tabletUrl = webImages['tablet'] as String;
            if (tabletUrl.isNotEmpty) {
              print('🔍 [BANNERS] Using tablet image: $tabletUrl');
              return tabletUrl;
            }
          }

          // For desktop
          if (webImages['desktop'] != null) {
            final desktopUrl = webImages['desktop'] as String;
            if (desktopUrl.isNotEmpty) {
              print('🔍 [BANNERS] Using desktop image: $desktopUrl');
              return desktopUrl;
            }
          }
        }

        // Check for mobile images
        if (images['mobile'] != null) {
          final mobileUrl = images['mobile'] as String;
          if (mobileUrl.isNotEmpty) {
            print('🔍 [BANNERS] Using mobile image: $mobileUrl');
            return mobileUrl;
          }
        }
      }

      // Fallback to the main image field
      if (banner['image'] != null && banner['image'] is String) {
        final imageUrl = banner['image'] as String;
        if (imageUrl.isNotEmpty) {
          print('🔍 [BANNERS] Using main image field: $imageUrl');
          return imageUrl;
        }
      }

      // Return placeholder if no image found
      print('🔍 [BANNERS] No valid image found, using placeholder');
      return 'https://via.placeholder.com/1920x600';
    } catch (e) {
      print('🔍 [BANNERS] Error getting image: $e');
      return 'https://via.placeholder.com/1920x600';
    }
  }

  /// Test the banners endpoint
  static Future<void> testBannersEndpoint() async {
    try {
      print('🔍 [BANNERS] Testing banners endpoint...');
      final banners = await getBanners();
      print('🔍 [BANNERS] Test completed. Found ${banners.length} banners');

      for (int i = 0; i < banners.length; i++) {
        final banner = banners[i];
        print(
            '🔍 [BANNERS] Banner $i: ${banner['title'] ?? 'No title'} - Platform: ${banner['platform'] ?? 'unknown'}');
        print(
            '🔍 [BANNERS]   Button: ${banner['buttonText'] ?? 'No button'} - Action: ${banner['actionUrl'] ?? 'No action'}');
      }
    } catch (e) {
      print('🔍 [BANNERS] Test failed: $e');
    }
  }
}
