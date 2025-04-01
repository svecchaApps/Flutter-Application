import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start BackendAPI Group Code

class BackendAPIGroup {
  static String getBaseUrl() =>
      'https://indigo-rhapsody-backend-ten.vercel.app';
  static Map<String, String> headers = {};
  static ProductsApiCall productsApiCall = ProductsApiCall();
  static GetCategoriesCall getCategoriesCall = GetCategoriesCall();
  static BannersCall bannersCall = BannersCall();
  static SubcategoriesCall subcategoriesCall = SubcategoriesCall();
  static GetDesignersCall getDesignersCall = GetDesignersCall();
  static GetLatestProductsCall getLatestProductsCall = GetLatestProductsCall();
  static GetProductByIdCall getProductByIdCall = GetProductByIdCall();
  static SubcategoryByidCall subcategoryByidCall = SubcategoryByidCall();
  static GetProductsBySubcategoryCall getProductsBySubcategoryCall =
      GetProductsBySubcategoryCall();
  static FitfiltersCall fitfiltersCall = FitfiltersCall();
  static ColorFiltersCall colorFiltersCall = ColorFiltersCall();
  static GetDesignerByidCall getDesignerByidCall = GetDesignerByidCall();
  static CreateUserSiginCall createUserSiginCall = CreateUserSiginCall();
  static AddItemTocartCall addItemTocartCall = AddItemTocartCall();
  static AddnewItemTocartCall addnewItemTocartCall = AddnewItemTocartCall();
  static GetCartForUserCall getCartForUserCall = GetCartForUserCall();
  static GetProductBycolorCall getProductBycolorCall = GetProductBycolorCall();
  static UpdateQuantityForCartItemsCall updateQuantityForCartItemsCall =
      UpdateQuantityForCartItemsCall();
  static UpdateUserrCall updateUserrCall = UpdateUserrCall();
  static GetUserInfoCall getUserInfoCall = GetUserInfoCall();
  static CreateOrderCall createOrderCall = CreateOrderCall();
  static AlluserOrdersCall alluserOrdersCall = AlluserOrdersCall();
  static GetBannersCall getBannersCall = GetBannersCall();
  static GetOrderForParticularidCall getOrderForParticularidCall =
      GetOrderForParticularidCall();
  static GetDesignerProductsCall getDesignerProductsCall =
      GetDesignerProductsCall();
  static CreateDesigneranduserCall createDesigneranduserCall =
      CreateDesigneranduserCall();
  static CreateVideoCreatorCall createVideoCreatorCall =
      CreateVideoCreatorCall();
  static CheckStatusCall checkStatusCall = CheckStatusCall();
  static CreateOrUpdateVideoCall createOrUpdateVideoCall =
      CreateOrUpdateVideoCall();
  static GetallvideosCall getallvideosCall = GetallvideosCall();
  static VideosbyvideoIdforuserCall videosbyvideoIdforuserCall =
      VideosbyvideoIdforuserCall();
  static DeleteVideoCall deleteVideoCall = DeleteVideoCall();
  static GetOrderDetailsForParticularUserCall
      getOrderDetailsForParticularUserCall =
      GetOrderDetailsForParticularUserCall();
  static CreateCartandUpdateCartOneFunctionCall
      createCartandUpdateCartOneFunctionCall =
      CreateCartandUpdateCartOneFunctionCall();
  static GetAllCouponsCall getAllCouponsCall = GetAllCouponsCall();
  static ApplyCouponsCall applyCouponsCall = ApplyCouponsCall();
  static CreateReturnRequestCall createReturnRequestCall =
      CreateReturnRequestCall();
  static LikeVideoCall likeVideoCall = LikeVideoCall();
  static PERSONALvIDEOiDCall pERSONALvIDEOiDCall = PERSONALvIDEOiDCall();
  static CreatePaymentCall createPaymentCall = CreatePaymentCall();
  static GetPaymentDetailsCall getPaymentDetailsCall = GetPaymentDetailsCall();
  static ToggleLikeVideoCall toggleLikeVideoCall = ToggleLikeVideoCall();
  static GetCommentCall getCommentCall = GetCommentCall();
  static CreateCommentCall createCommentCall = CreateCommentCall();
  static WishlistCall wishlistCall = WishlistCall();
  static CreateWishListCall createWishListCall = CreateWishListCall();
  static StatesApiCall statesApiCall = StatesApiCall();
  static CreateStateCall createStateCall = CreateStateCall();
  static GetaddressCall getaddressCall = GetaddressCall();
}

class ProductsApiCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'ProductsApi',
      apiUrl: '$baseUrl/products/products',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetCategoriesCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getCategories',
      apiUrl: '$baseUrl/category',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? categoryId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.categories[:]._id''',
      ));
  List<String>? name(dynamic response) => (getJsonField(
        response,
        r'''$.categories.*.name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  String? categoryImage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.categories[:].image''',
      ));
  List? categoryPath(dynamic response) => getJsonField(
        response,
        r'''$.categories.*''',
        true,
      ) as List?;
}

class BannersCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Banners',
      apiUrl: '$baseUrl/banner',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SubcategoriesCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Subcategories',
      apiUrl: '$baseUrl/subcategory/subcategories',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? body(dynamic response) => getJsonField(
        response,
        r'''$.approvedSubCategories.*''',
        true,
      ) as List?;
  List<String>? mainBody(dynamic response) => (getJsonField(
        response,
        r'''$.approvedSubCategories[:]._id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? image(dynamic response) => (getJsonField(
        response,
        r'''$.approvedSubCategories[:].image''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetDesignersCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getDesigners',
      apiUrl: '$baseUrl/designer/designers',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? designerBody(dynamic response) => getJsonField(
        response,
        r'''$.designers.*''',
        true,
      ) as List?;
}

class GetLatestProductsCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getLatestProducts',
      apiUrl: '$baseUrl/products/latestProducts',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? productId(dynamic response) => (getJsonField(
        response,
        r'''$.products[:]._id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? productName(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].productName''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? rating(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].averageRating''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? createdDate(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].createdDate''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? productDescription(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? productDesigner(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].designerRef''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? productDiscount(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].discount''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? productFabric(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].fabric''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? productFit(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].fit''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<bool>? productInStock(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].in_stock''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  List<bool>? productIsSustainable(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].is_sustainable''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  List<String>? productMaterial(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].material''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? productDetails(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].productDetails''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? productSklu(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].sku''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? productsSizePrices(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].variants[:].sizes[:].price''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? productStock(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].variants[:].sizes[:].stock''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? productColor(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].variants[:].color''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? productVariants(dynamic response) => getJsonField(
        response,
        r'''$.products[:].variants''',
        true,
      ) as List?;
  List<String>? productSubcategory(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].subCategory.name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? productSubcategoryId(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].subCategory._id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? productReviews(dynamic response) => getJsonField(
        response,
        r'''$.products[:].reviews''',
        true,
      ) as List?;
  List<int>? productPrice(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].price''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<bool>? productIsCustomizable(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].is_customizable''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  List<String>? productSizes(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].variants[:].sizes[:].size''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? productCategoryId(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].category._id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? body(dynamic response) => getJsonField(
        response,
        r'''$.products.*''',
        true,
      ) as List?;
}

class GetProductByIdCall {
  Future<ApiCallResponse> call({
    String? productId = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getProductById',
      apiUrl: '$baseUrl/products/products/$productId',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? productId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.productId''',
      ));
  String? productName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.productName''',
      ));
  String? description(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.description''',
      ));
  int? price(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.price''',
      ));
  String? categoryName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.category.name''',
      ));
  String? subcategoryId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.subCategory._id''',
      ));
  String? subcategoryName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.subCategory.name''',
      ));
  String? fit(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.fit''',
      ));
  String? material(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.material''',
      ));
  String? fabric(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.fabric''',
      ));
  String? variantColor(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.variant.color''',
      ));
  List<String>? variantSize(dynamic response) => (getJsonField(
        response,
        r'''$.variant.sizes[:].size''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? variantSizePrice(dynamic response) => (getJsonField(
        response,
        r'''$.variant.sizes[:].price''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  String? sku(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.sku''',
      ));
  List<String>? availableColors(dynamic response) => (getJsonField(
        response,
        r'''$.availableColors''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  String? designerRef(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.designerRef''',
      ));
  String? coverImage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.coverImage''',
      ));
  List<String>? variantImage(dynamic response) => (getJsonField(
        response,
        r'''$.variant.imageList''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? variantDetails(dynamic response) => getJsonField(
        response,
        r'''$.variant.sizes.*''',
        true,
      ) as List?;
  List? availableColorsnew(dynamic response) => getJsonField(
        response,
        r'''$.availableColors.*''',
        true,
      ) as List?;
  List? wishlistedbY(dynamic response) => getJsonField(
        response,
        r'''$.wishlistedBy''',
        true,
      ) as List?;
}

class SubcategoryByidCall {
  Future<ApiCallResponse> call({
    String? categoryId = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'subcategoryByid',
      apiUrl: '$baseUrl/subcategory/getSubCategoriesByCategory/$categoryId',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? subcategoryId(dynamic response) => (getJsonField(
        response,
        r'''$.subCategories[:]._id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? subcategoryName(dynamic response) => (getJsonField(
        response,
        r'''$.subCategories[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? categoryIdarray(dynamic response) => getJsonField(
        response,
        r'''$.subCategories[:].categoryId''',
        true,
      ) as List?;
  List<String>? categoryId(dynamic response) => (getJsonField(
        response,
        r'''$.subCategories[:].categoryId._id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? categoryName(dynamic response) => (getJsonField(
        response,
        r'''$.subCategories[:].categoryId.name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? subcategoryCreated(dynamic response) => (getJsonField(
        response,
        r'''$.subCategories[:].createdDate''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? mainBody(dynamic response) => getJsonField(
        response,
        r'''$.subCategories.*''',
        true,
      ) as List?;
}

class GetProductsBySubcategoryCall {
  Future<ApiCallResponse> call({
    String? subcategoryId = '',
    String? sort = '',
    String? color = '',
    String? fit = '',
    String? minPrice = '',
    String? maxPrice = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'get products By subcategory',
      apiUrl: '$baseUrl/products/subCategory/$subcategoryId',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'sortBy': "price",
        'color': color,
        'fit': fit,
        'minPrice': minPrice,
        'maxPrice': maxPrice,
        'sortOrder': sort,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<int>? rating(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].averageRating''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? productId(dynamic response) => (getJsonField(
        response,
        r'''$.products[:]._id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? name(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].productName''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? categoryId(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].category._id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? categoryName(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].category.name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? coverImage(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].coverImage''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? price(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].price''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List? pRODUCTbODY(dynamic response) => getJsonField(
        response,
        r'''$.products.*''',
        true,
      ) as List?;
  List? wishlisteBy(dynamic response) => getJsonField(
        response,
        r'''$.products[:].wishlistedBy''',
        true,
      ) as List?;
}

class FitfiltersCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Fitfilters',
      apiUrl: '$baseUrl/filter/getFitFilters',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? fitfilterName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.filters[:].name''',
      ));
  List? filterBody(dynamic response) => getJsonField(
        response,
        r'''$.filters.*''',
        true,
      ) as List?;
}

class ColorFiltersCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'colorFilters',
      apiUrl: '$baseUrl/filter/getColorFilters',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? colorBody(dynamic response) => getJsonField(
        response,
        r'''$.colorFilters.*''',
        true,
      ) as List?;
}

class GetDesignerByidCall {
  Future<ApiCallResponse> call({
    String? designerId = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getDesignerByid',
      apiUrl: '$baseUrl/designer/designers/$designerId',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? deisgnerId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.designer._id''',
      ));
  String? displayName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.designer.userId.displayName''',
      ));
  String? logo(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.designer.logoUrl''',
      ));
  bool? isapproved(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.designer.is_approved''',
      ));
  String? shortDescription(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.designer.shortDescription''',
      ));
  String? backGroundImage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.designer.backGroundImage''',
      ));
  String? description(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.designer.about''',
      ));
  List<String>? designerMAIN(dynamic response) => (getJsonField(
        response,
        r'''$.designer.*''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class CreateUserSiginCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? displayName = '',
    String? phoneNumber = '',
    String? password = '',
    String? role = '',
    bool? isCreator,
    String? nickName = '',
    String? street = '',
    String? city = '',
    String? state1 = '',
    int? pincode,
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "email": "$email",
  "displayName": "$displayName",
  "phoneNumber": "$phoneNumber",
  "password": "$password",
  "role": "$role",
  "is_creator": $isCreator,
  "address": [
    {
      "nick_name": "$nickName",
      "city": "$city",
      "pincode": "$pincode",
      "state":"$state1",
      "street_details": "$street"
    }
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createUserSigin',
      apiUrl: '$baseUrl/user/createUser',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AddItemTocartCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? productId = '',
    String? designerRef = '',
    int? quantity,
    String? size = '',
    String? color = '',
    bool? isCustomizable,
    String? customizations = '',
    String? discount = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "userId": "$userId",
  "products": [
    {
      "productId": "$productId",
      "designerRef": "$designerRef",
      "quantity": $quantity,
      "size": "$size",
      "color": "$color",
      "is_customizable": "$isCustomizable",
      "customizations": "$customizations",
      "discount": "$discount"
    }
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'addItemTocart',
      apiUrl: '$baseUrl/cart',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AddnewItemTocartCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? productId = '',
    int? quantity,
    String? size = '',
    String? color = '',
    bool? isCustomizable,
    String? customizations = '',
    String? price = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "userId": "$userId",
  "productId": "$productId",
  "quantity": $quantity,
  "size": "$size",
  "color": "$color",
  "is_customizable": $isCustomizable,
  "customizations": "$customizations"

}''';
    return ApiManager.instance.makeApiCall(
      callName: 'addnewItemTocart',
      apiUrl: '$baseUrl/cart/addItem',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetCartForUserCall {
  Future<ApiCallResponse> call({
    String? userId = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getCartForUser',
      apiUrl: '$baseUrl/cart/getCart/$userId',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? cartID(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.cart._id''',
      ));
  String? cartUserId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.cart.userId''',
      ));
  String? cartProductName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.cart.products[:].productId.productName''',
      ));
  int? cartProductPrice(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.cart.products[:].productId.price''',
      ));
  List? cartItems(dynamic response) => getJsonField(
        response,
        r'''$.cart.products.*''',
        true,
      ) as List?;
  dynamic cartitemsId(dynamic response) => getJsonField(
        response,
        r'''$.cart.products[:].productId''',
      );
  List<String>? cartImageList(dynamic response) => (getJsonField(
        response,
        r'''$.cart.products[:].productId.variants[:].imageList''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  String? cartproductsidno(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.cart.products[:].productId._id''',
      ));
  String? cartproductsize(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.cart.products[:].size''',
      ));
  String? cartproductColors(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.cart.products[:].color''',
      ));
  String? cartproductsingleId(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.cart.products[:]._id''',
      ));
  String? cartproductsnames(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.cart.products[:].productName''',
      ));
  double? cartSubtotal(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.cart.subtotal''',
      ));
  double? cartTotalAmount(dynamic response) =>
      double.tryParse(castToType<double>(getJsonField(
            response,
            r'''$.cart.total_amount''',
          ))?.toStringAsFixed(2) ??
          '');
  bool? discountApplied(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.cart.discount_applied''',
      ));
  double? cartDiscount(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.cart.products[:].discount''',
      ));
  int? cartTotalQuantity(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.cart.products[:].quantity''',
      ));
  int? cartPrice(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.cart.products[:].price''',
      ));
  List<String>? cARTtOTALiTEMS(dynamic response) => (getJsonField(
        response,
        r'''$.cart.*''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  double? tax(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.cart.tax_amount''',
      ));
  double? deliveryCost(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.cart.shipping_cost''',
      ));
  double? discountAmount1(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.cart.discount_amount''',
      ));
}

class GetProductBycolorCall {
  Future<ApiCallResponse> call({
    String? productId = '',
    String? color = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getProductBycolor',
      apiUrl: '$baseUrl/products/products/$productId/variants/$color',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? productId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.productId''',
      ));
  String? productName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.productName''',
      ));
  String? description(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.description''',
      ));
  String? categoryId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.category._id''',
      ));
  String? categoryName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.category.name''',
      ));
  String? subcategoryName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.subCategory.name''',
      ));
  String? subcategoryId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.subCategory._id''',
      ));
  String? fit(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.fit''',
      ));
  String? material(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.material''',
      ));
  String? fabric(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.fabric''',
      ));
  String? designerRef(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.designerRef''',
      ));
  String? variantColor(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.variant.color''',
      ));
  List<String>? availableSize(dynamic response) => (getJsonField(
        response,
        r'''$.variant.sizes[:].size''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? availablePrice(dynamic response) => (getJsonField(
        response,
        r'''$.variant.sizes[:].price''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List? variantsizesandprioces(dynamic response) => getJsonField(
        response,
        r'''$.variant.sizes''',
        true,
      ) as List?;
  List<String>? variantsData(dynamic response) => (getJsonField(
        response,
        r'''$.variant.*''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? variantDataImage(dynamic response) => (getJsonField(
        response,
        r'''$.variant.imageList''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? wishListedBy(dynamic response) => getJsonField(
        response,
        r'''$.wishlistedBy''',
        true,
      ) as List?;
}

class UpdateQuantityForCartItemsCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? productId = '',
    String? size = '',
    int? quantity,
    String? color = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "userId": "$userId",
  "productId": "$productId",
  "size": "$size",
  "color": "$color",
  "quantity": $quantity
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updateQuantityForCartItems',
      apiUrl: '$baseUrl/cart/update',
      callType: ApiCallType.PUT,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateUserrCall {
  Future<ApiCallResponse> call({
    String? address = '',
    String? city = '',
    String? state = '',
    String? pincode = '',
    String? userId = '',
    String? nickName = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "nick_name": "$nickName",
  "city": "$city",
  "pincode": "$pincode",
  "state": "$state",
  "street_details": "$address"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updateUserr',
      apiUrl: '$baseUrl/user/$userId',
      callType: ApiCallType.PUT,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetUserInfoCall {
  Future<ApiCallResponse> call({
    String? userId = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getUserInfo',
      apiUrl: '$baseUrl/user/$userId',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? userBody(dynamic response) => (getJsonField(
        response,
        r'''$.user.*''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  bool? creatorIstrue(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.user.is_creator''',
      ));
}

class CreateOrderCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? cartId = '',
    String? paymentmethod = '',
    String? address = '',
    String? city = '',
    String? state = '',
    String? postalcode = '',
    String? shippingMethod = '',
    String? shippingcost = '',
    String? notes = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "userId": "$userId",
  "cartId": "$cartId",
  "paymentMethod": "$paymentmethod",
  "address": {
    "street": "$address",
    "city": "$city",
    "state": "$state",
    "pincode": "$postalcode"
  },
  "notes": "$notes"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createOrder',
      apiUrl: '$baseUrl/order',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AlluserOrdersCall {
  Future<ApiCallResponse> call({
    String? userId = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'AlluserOrders',
      apiUrl: '$baseUrl/order/getOrders/$userId',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? ordersBody(dynamic response) => getJsonField(
        response,
        r'''$.orders.*''',
        true,
      ) as List?;
  String? orderPlaced(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.orders[:].statusTimestamps.orderPlaced''',
      ));
  String? orderStatus(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.orders[:].status''',
      ));
  String? orderId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.orders[:].orderId''',
      ));
}

class GetBannersCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getBanners',
      apiUrl: '$baseUrl/banner',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? bannersMain(dynamic response) => getJsonField(
        response,
        r'''$.banners.*''',
        true,
      ) as List?;
}

class GetOrderForParticularidCall {
  Future<ApiCallResponse> call({
    String? orderId = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getOrderForParticularid',
      apiUrl: '$baseUrl/order/order/$orderId',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetDesignerProductsCall {
  Future<ApiCallResponse> call({
    String? designerId = '',
    String? category = '',
    String? minPrice = '',
    String? maxPrice = '',
    String? sortBy = '',
    String? order = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getDesignerProducts',
      apiUrl: '$baseUrl/products//getProductsByDesigner/$designerId',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'category': category,
        'minPrice': minPrice,
        'maxPrice': maxPrice,
        'sortBy': sortBy,
        'order': order,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? productsMain(dynamic response) => getJsonField(
        response,
        r'''$.products.*''',
        true,
      ) as List?;
  List<String>? productNaME(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].productName''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? pRODUCTiD(dynamic response) => (getJsonField(
        response,
        r'''$.products[:]._id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? coverImage(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].coverImage''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? productPrice(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].price''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
}

class CreateDesigneranduserCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? password = '',
    String? displayName = '',
    String? phoneNumber = '',
    String? role = '',
    String? address = '',
    String? city = '',
    String? state = '',
    String? pincode = '',
    bool? isCreator,
    String? shortDescription = '',
    String? about = '',
    String? logoUrl = '',
    String? groundImageUrl = '',
    String? nickName = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "email":"$email",
  "password":"$password" ,
  "displayName":"$displayName" ,
  "phoneNumber":"$phoneNumber" ,
  "role":"$role" ,
  "is_creator":false ,
  "shortDescription":"$shortDescription" ,
  "about":"$about" ,
  "logoUrl":"$logoUrl" ,
  "backgroundImageUrl":"$groundImageUrl" ,
"address": [
    {
      "nick_name": "$nickName",
      "street_details": "$address",
      "city": "$city",
      "state":"$state",
      "pincode":"$pincode" 
    }
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createDesigneranduser',
      apiUrl: '$baseUrl/user/user-designer',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? error(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.error''',
      ));
}

class CreateVideoCreatorCall {
  Future<ApiCallResponse> call({
    String? userrId = '',
    String? instaUser = '',
    String? demoUrl = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "userId": "$userrId",
  "instagram_User": "$instaUser",
  "demo_url": "$demoUrl"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createVideoCreator',
      apiUrl: '$baseUrl/video/video-creator',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class CheckStatusCall {
  Future<ApiCallResponse> call({
    String? userId = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "userId":"$userId" 
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'checkStatus',
      apiUrl: '$baseUrl/video/video-creator/status',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? errormessage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  bool? isApproved(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.is_approved''',
      ));
}

class CreateOrUpdateVideoCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? creatorId = '',
    String? videoUrl = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "userId": "$userId",
  "creatorId": "$creatorId",
  "videoUrl": "$videoUrl"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createOrUpdateVideo',
      apiUrl: '$baseUrl/content-video/videos',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? status(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class GetallvideosCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getallvideos',
      apiUrl: '$baseUrl/content-video/videos',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? body(dynamic response) => getJsonField(
        response,
        r'''$.videos.*''',
        true,
      ) as List?;
  String? url(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.videos[:].videoUrl''',
      ));
  String? userId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.videos[:].userId._id''',
      ));
  String? displayName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.videos[:].userId.displayName''',
      ));
  List<String>? likedBy(dynamic response) => (getJsonField(
        response,
        r'''$.videos[:].likedBy.*''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class VideosbyvideoIdforuserCall {
  Future<ApiCallResponse> call({
    String? userId = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'videosbyvideoIdforuser',
      apiUrl: '$baseUrl/content-video/videos/user/$userId',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? mainBody(dynamic response) => getJsonField(
        response,
        r'''$.videos.*''',
        true,
      ) as List?;
  String? displayName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.videos[:].userId.displayName''',
      ));
  String? creatorId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.videos[:].creatorId._id''',
      ));
}

class DeleteVideoCall {
  Future<ApiCallResponse> call({
    String? videoId = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'deleteVideo',
      apiUrl: '$baseUrl/content-video/videos/$videoId',
      callType: ApiCallType.DELETE,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetOrderDetailsForParticularUserCall {
  Future<ApiCallResponse> call({
    String? orderId = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'GetOrderDetailsForParticularUser',
      apiUrl: '$baseUrl/order/order/$orderId',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? orderBody(dynamic response) => getJsonField(
        response,
        r'''$.order.products.*''',
        true,
      ) as List?;
  List? shippingDetails(dynamic response) => getJsonField(
        response,
        r'''$.order.shippingDetails.*''',
        true,
      ) as List?;
  String? street(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.order.shippingDetails.address.street''',
      ));
  String? city(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.order.shippingDetails.address.city''',
      ));
  String? state(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.order.shippingDetails.address.state''',
      ));
  String? country(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.order.shippingDetails.address.country''',
      ));
  String? createdTime(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.order.statusTimestamps.orderPlaced''',
      ));
  String? orderId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.order.orderId''',
      ));
  String? status(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.order.status''',
      ));
  String? paymentMethod(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.order.paymentMethod''',
      ));
  List? products(dynamic response) => getJsonField(
        response,
        r'''$.order.products''',
        true,
      ) as List?;
  double? priceOrder(dynamic response) =>
      double.tryParse(castToType<double>(getJsonField(
            response,
            r'''$.order.amount''',
          ))?.toStringAsFixed(2) ??
          '');
  String? mainId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.order._id''',
      ));
  double? subTotal(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.order.subtotal''',
      ));
  double? shippingCost(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.order.shipping_cost''',
      ));
  double? taxAmount(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.order.tax_amount''',
      ));
  double? discountAmount(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.order.discountAmount''',
      ));
}

class CreateCartandUpdateCartOneFunctionCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? productId = '',
    int? quantity,
    String? size = '',
    String? color = '',
    String? isCustomized = '',
    String? customizations = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "userId":"$userId" ,
  "productId":"$productId" ,
  "quantity":$quantity ,
  "size": "$size",
  "color":"$color" ,
  "is_customizable": false,
  "customizations":"$customizations" 
}
''';
    return ApiManager.instance.makeApiCall(
      callName: 'createCartandUpdateCartOneFunction',
      apiUrl: '$baseUrl/cart/CreateCart',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? cartId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.cart._id''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class GetAllCouponsCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getAllCoupons',
      apiUrl: '$baseUrl/coupon',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? couponId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:]._id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? couponCode(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].couponCode''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? couponAmount(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].couponAmount''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? expiryDate(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].expiryDate''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<bool>? isActive(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_active''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  List? usedBy(dynamic response) => getJsonField(
        response,
        r'''$.data[:].usedBy''',
        true,
      ) as List?;
  List? body(dynamic response) => getJsonField(
        response,
        r'''$.data.*''',
        true,
      ) as List?;
}

class ApplyCouponsCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? couponCode = '',
    String? cartId = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "cartId":"$cartId" ,
  "couponId": "$couponCode",
  "userId":"$userId"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'applyCoupons',
      apiUrl: '$baseUrl/coupon/applyCoupon',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CreateReturnRequestCall {
  Future<ApiCallResponse> call({
    String? orderId = '',
    String? productId = '',
    String? reason = '',
    String? imageUrl = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "orderId": "$orderId",
  "productId": "$productId",
  "reason": "$reason",
  "imageUrl": "$imageUrl"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createReturnRequest',
      apiUrl: '$baseUrl/order/return-request',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class LikeVideoCall {
  Future<ApiCallResponse> call({
    String? videoId = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'likeVideo',
      apiUrl: '$baseUrl/video/$videoId/like',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PERSONALvIDEOiDCall {
  Future<ApiCallResponse> call({
    String? uSERiD = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'pERSONALvIDEOiD',
      apiUrl: '$baseUrl/video/videos/user/$uSERiD',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? main(dynamic response) => getJsonField(
        response,
        r'''$.videos''',
        true,
      ) as List?;
  String? creatorId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.videos[:]._id''',
      ));
}

class CreatePaymentCall {
  Future<ApiCallResponse> call({
    String? cartId = '',
    String? userId = '',
    double? amount,
    String? paymentMethod = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "userId": "$userId",
  "cartId": "$cartId",
  "amount": $amount,
  "paymentMethod": "$paymentMethod"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createPayment',
      apiUrl: '$baseUrl/payment/createPayment',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  String? id(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.paymentDetails._id''',
      ));
  String? transactionId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.payment.transactionId''',
      ));
}

class GetPaymentDetailsCall {
  Future<ApiCallResponse> call({
    String? transactionId = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getPaymentDetails',
      apiUrl: '$baseUrl/payment/transaction/$transactionId',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic paymentDetails(dynamic response) => getJsonField(
        response,
        r'''$.paymentDetails''',
      );
  String? status(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.paymentDetails.paymentStatus''',
      ));
  String? method(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.paymentDetails.paymentMethod''',
      ));
  String? userId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.paymentDetails.userId''',
      ));
  String? paymentId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.paymentDetails._id''',
      ));
  String? dateCreated(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.paymentDetails.createdDate''',
      ));
  String? cartId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.paymentDetails.cartId''',
      ));
  String? transactionId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.paymentDetails.transactionId''',
      ));
}

class ToggleLikeVideoCall {
  Future<ApiCallResponse> call({
    String? videoId = '',
    String? userId = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "userId": "$userId"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'toggleLikeVideo',
      apiUrl: '$baseUrl/content-video/videos/$videoId/like',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetCommentCall {
  Future<ApiCallResponse> call({
    String? videoId = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getComment',
      apiUrl: '$baseUrl/content-video/videos/$videoId/comments',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? body(dynamic response) => getJsonField(
        response,
        r'''$.comments.*''',
        true,
      ) as List?;
}

class CreateCommentCall {
  Future<ApiCallResponse> call({
    String? videoId = '',
    String? userId = '',
    String? commentText = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "videoId":"$videoId" ,
  "userId":"$userId" ,
  "commentText": "$commentText"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createComment',
      apiUrl: '$baseUrl/content-video/comments',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class WishlistCall {
  Future<ApiCallResponse> call({
    String? userId = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Wishlist',
      apiUrl: '$baseUrl/wishlist/$userId',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? productsBody(dynamic response) => getJsonField(
        response,
        r'''$[:].productId''',
        true,
      ) as List?;
}

class CreateWishListCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? productId = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "userId": "$userId",
  "productId": "$productId"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createWishList',
      apiUrl: '$baseUrl/wishlist/toggle',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? productId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.productId''',
      ));
}

class StatesApiCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'statesApi',
      apiUrl: '$baseUrl/states',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? body(dynamic response) => getJsonField(
        response,
        r'''$.states.*''',
        true,
      ) as List?;
}

class CreateStateCall {
  Future<ApiCallResponse> call({
    String? state = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
"name":"$state"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createState',
      apiUrl: '$baseUrl/states',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetaddressCall {
  Future<ApiCallResponse> call({
    String? userId = '',
  }) async {
    final baseUrl = BackendAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getaddress',
      apiUrl: '$baseUrl/user/user/$userId/addresses',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  List? body(dynamic response) => getJsonField(
        response,
        r'''$.addresses''',
        true,
      ) as List?;
}

/// End BackendAPI Group Code

class PhonepeCall {
  static Future<ApiCallResponse> call({
    String? xVerify = '',
    String? base64 = '',
  }) async {
    final ffApiRequestBody = '''
{
  "request": "$base64"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'phonepe',
      apiUrl: 'https://api.phonepe.com/apis/hermes/pg/v1/pay',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'X-VERIFY': '$xVerify',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic paymenturl(dynamic response) => getJsonField(
        response,
        r'''$.data.instrumentResponse.redirectInfo.url''',
      );
  static dynamic merchanttransactionid(dynamic response) => getJsonField(
        response,
        r'''$.data.merchantTransactionId''',
      );
  static dynamic merchantid(dynamic response) => getJsonField(
        response,
        r'''$.data.merchantId''',
      );
  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  static String? code(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.code''',
      ));
  static bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
}

class PhonepestatusCall {
  static Future<ApiCallResponse> call({
    String? merchantId = '',
    String? transactionId = '',
    String? xVerify = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'phonepestatus',
      apiUrl:
          'https://mercury-t2.phonepe.com/v3/transaction/$merchantId/$transactionId/status',
      callType: ApiCallType.GET,
      headers: {
        'accept': 'application/json',
        'X-VERIFY': '$xVerify',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic success(dynamic response) => getJsonField(
        response,
        r'''$.success''',
      );
  static dynamic code(dynamic response) => getJsonField(
        response,
        r'''$.code''',
      );
  static dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
  static dynamic paymentState(dynamic response) => getJsonField(
        response,
        r'''$.data.paymentState''',
      );
  static dynamic payResponseCode(dynamic response) => getJsonField(
        response,
        r'''$.data.payResponseCode''',
      );
}

class InvoiceCall {
  static Future<ApiCallResponse> call({
    String? date = '',
    String? number = '',
    String? from = '',
    String? fromAddress = '',
    String? to = '',
    String? shipTo = '',
    dynamic itemsJson,
    String? logo = '',
    String? apiKey = '',
  }) async {
    final items = _serializeJson(itemsJson, true);

    return ApiManager.instance.makeApiCall(
      callName: 'invoice',
      apiUrl: 'https://anyapi.io/api/v1/invoice/generate',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'date': date,
        'number': number,
        'from': from,
        'from_address': fromAddress,
        'to': to,
        'ship_to': shipTo,
        'items': items,
        'logo': logo,
        'apiKey': "9j2v1p5cuppok8cd8o5f8r8uupcd1mpusqfrhi37botp8ir1lgai8",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ShiprocketloginCall {
  static Future<ApiCallResponse> call() async {
    const ffApiRequestBody = '''
{
  "email": "rajatjiedm@gmail.com",
  "password": "Raaxas12#"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'shiprocketlogin',
      apiUrl: 'https://apiv2.shiprocket.in/v1/external/auth/login',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AddAdressCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? pickupLocation = '',
    String? name = '',
    String? email = '',
    String? phone = '',
    String? adress = '',
    String? city = '',
    String? state = '',
    String? country = '',
    int? pincode,
  }) async {
    final ffApiRequestBody = '''
{
  "pickup_location": "$pickupLocation",
  "name": "$name",
  "email": "$email",
  "phone": "$phone",
  "address": "$adress",
  "city": "$city",
  "state": "$state",
  "country": "$country",
  "pin_code": "$pincode"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'add adress',
      apiUrl:
          'https://apiv2.shiprocket.in/v1/external/settings/company/addpickup',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class OrdertrackingCall {
  static Future<ApiCallResponse> call({
    String? shippingid = '',
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'ordertracking',
      apiUrl:
          'https://indigorhapsodyserver.vercel.app/courier/track/shipment/$shippingid',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.tracking_data.shipment_track''',
        true,
      ) as List?;
  static String? dataname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.tracking_data.shipment_track[:].current_status''',
      ));
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
