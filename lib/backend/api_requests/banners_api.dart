import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_manager.dart';

class BannersApi {
  static const String _baseUrl =
      'https://indigo-rhapsody-backend-ten.vercel.app';

  /// Fetch banners from the /banner endpoint
  static Future<List<Map<String, dynamic>>> getBanners() async {
    try {
      print('🔍 [BANNERS] Fetching banners from $_baseUrl/banner');

      final response = await http.get(
        Uri.parse('$_baseUrl/banner'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'User-Agent': 'IndigoRhapsody/1.0',
        },
      );

      print('🔍 [BANNERS] Response status: ${response.statusCode}');
      print('🔍 [BANNERS] Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> banners = data['banners'] ?? [];

        print('🔍 [BANNERS] Found ${banners.length} banners');

        return banners
            .map((banner) => Map<String, dynamic>.from(banner))
            .toList();
      } else {
        print('🔍 [BANNERS] Error: HTTP ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('🔍 [BANNERS] Exception: $e');
      return [];
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
            '🔍 [BANNERS] Banner $i: ${banner['title'] ?? 'No title'} - ${banner['imageUrl'] ?? 'No image'}');
      }
    } catch (e) {
      print('🔍 [BANNERS] Test failed: $e');
    }
  }
}
