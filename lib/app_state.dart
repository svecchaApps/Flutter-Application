import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _userId = prefs.getString('ff_userId') ?? _userId;
    });
    _safeInit(() {
      _cartcreated = prefs.getBool('ff_cartcreated') ?? _cartcreated;
    });
    _safeInit(() {
      _cartId = prefs.getString('ff_cartId') ?? _cartId;
    });
    _safeInit(() {
      _applyCoupon = prefs.getBool('ff_applyCoupon') ?? _applyCoupon;
    });
    _safeInit(() {
      _likedVideo = prefs.getBool('ff_likedVideo') ?? _likedVideo;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _userId = '';
  String get userId => _userId;
  set userId(String value) {
    _userId = value;
    prefs.setString('ff_userId', value);
  }

  bool _cartcreated = false;
  bool get cartcreated => _cartcreated;
  set cartcreated(bool value) {
    _cartcreated = value;
    prefs.setBool('ff_cartcreated', value);
  }

  String state = '';
  String city = '';
  String address = '';
  String pincode = '';

  String _cartId = '';
  String get cartId => _cartId;
  set cartId(String value) {
    _cartId = value;
    prefs.setString('ff_cartId', value);
  }

  String _selectedSize = '';
  String get selectedSize => _selectedSize;
  set selectedSize(String value) {
    _selectedSize = value;
  }

  String _color = '';
  String get color => _color;
  set color(String value) {
    _color = value;
  }

  String _min = '';
  String get min => _min;
  set min(String value) {
    _min = value;
  }

  String _max = '';
  String get max => _max;
  set max(String value) {
    _max = value;
  }

  String _fit = '';
  String get fit => _fit;
  set fit(String value) {
    _fit = value;
  }

  String _sort = '';
  String get sort => _sort;
  set sort(String value) {
    _sort = value;
  }

  bool _applyCoupon = false;
  bool get applyCoupon => _applyCoupon;
  set applyCoupon(bool value) {
    _applyCoupon = value;
    prefs.setBool('ff_applyCoupon', value);
  }

  String _categoryFilter = '';
  String get categoryFilter => _categoryFilter;
  set categoryFilter(String value) {
    _categoryFilter = value;
  }

  String _paymentId = '';
  String get paymentId => _paymentId;
  set paymentId(String value) {
    _paymentId = value;
  }

  bool _likedVideo = false;
  bool get likedVideo => _likedVideo;
  set likedVideo(bool value) {
    _likedVideo = value;
    prefs.setBool('ff_likedVideo', value);
  }

  bool _timer = false;
  bool get timer => _timer;
  set timer(bool value) {
    _timer = value;
  }

  final _categoriesManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> categories({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _categoriesManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearCategoriesCache() => _categoriesManager.clear();
  void clearCategoriesCacheKey(String? uniqueKey) =>
      _categoriesManager.clearRequest(uniqueKey);

  final _subcategoryManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> subcategory({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _subcategoryManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearSubcategoryCache() => _subcategoryManager.clear();
  void clearSubcategoryCacheKey(String? uniqueKey) =>
      _subcategoryManager.clearRequest(uniqueKey);

  final _designerManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> designer({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _designerManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearDesignerCache() => _designerManager.clear();
  void clearDesignerCacheKey(String? uniqueKey) =>
      _designerManager.clearRequest(uniqueKey);

  final _videosectionManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> videosection({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _videosectionManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearVideosectionCache() => _videosectionManager.clear();
  void clearVideosectionCacheKey(String? uniqueKey) =>
      _videosectionManager.clearRequest(uniqueKey);

  final _productsManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> products({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _productsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearProductsCache() => _productsManager.clear();
  void clearProductsCacheKey(String? uniqueKey) =>
      _productsManager.clearRequest(uniqueKey);

  final _carouselManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> carousel({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _carouselManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearCarouselCache() => _carouselManager.clear();
  void clearCarouselCacheKey(String? uniqueKey) =>
      _carouselManager.clearRequest(uniqueKey);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
