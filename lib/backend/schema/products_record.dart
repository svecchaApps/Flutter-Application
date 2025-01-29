import 'dart:async';

import '/backend/algolia/serialization_util.dart';
import '/backend/algolia/algolia_manager.dart';
import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ProductsRecord extends FirestoreRecord {
  ProductsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "catref" field.
  DocumentReference? _catref;
  DocumentReference? get catref => _catref;
  bool hasCatref() => _catref != null;

  // "designerref" field.
  DocumentReference? _designerref;
  DocumentReference? get designerref => _designerref;
  bool hasDesignerref() => _designerref != null;

  // "Productname" field.
  String? _productname;
  String get productname => _productname ?? '';
  bool hasProductname() => _productname != null;

  // "MRP" field.
  double? _mrp;
  double get mrp => _mrp ?? 0.0;
  bool hasMrp() => _mrp != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "size" field.
  String? _size;
  String get size => _size ?? '';
  bool hasSize() => _size != null;

  // "stock" field.
  double? _stock;
  double get stock => _stock ?? 0.0;
  bool hasStock() => _stock != null;

  // "imagelist" field.
  List<String>? _imagelist;
  List<String> get imagelist => _imagelist ?? const [];
  bool hasImagelist() => _imagelist != null;

  // "isfav" field.
  bool? _isfav;
  bool get isfav => _isfav ?? false;
  bool hasIsfav() => _isfav != null;

  // "subcategoreyref1" field.
  DocumentReference? _subcategoreyref1;
  DocumentReference? get subcategoreyref1 => _subcategoreyref1;
  bool hasSubcategoreyref1() => _subcategoreyref1 != null;

  // "spotlight_on" field.
  bool? _spotlightOn;
  bool get spotlightOn => _spotlightOn ?? false;
  bool hasSpotlightOn() => _spotlightOn != null;

  // "On_sale" field.
  bool? _onSale;
  bool get onSale => _onSale ?? false;
  bool hasOnSale() => _onSale != null;

  // "sal_percentage" field.
  double? _salPercentage;
  double get salPercentage => _salPercentage ?? 0.0;
  bool hasSalPercentage() => _salPercentage != null;

  // "review" field.
  String? _review;
  String get review => _review ?? '';
  bool hasReview() => _review != null;

  // "ratings" field.
  double? _ratings;
  double get ratings => _ratings ?? 0.0;
  bool hasRatings() => _ratings != null;

  // "shipping_returns" field.
  String? _shippingReturns;
  String get shippingReturns => _shippingReturns ?? '';
  bool hasShippingReturns() => _shippingReturns != null;

  // "Sustainable" field.
  bool? _sustainable;
  bool get sustainable => _sustainable ?? false;
  bool hasSustainable() => _sustainable != null;

  // "fabric" field.
  String? _fabric;
  String get fabric => _fabric ?? '';
  bool hasFabric() => _fabric != null;

  // "weavepattern" field.
  String? _weavepattern;
  String get weavepattern => _weavepattern ?? '';
  bool hasWeavepattern() => _weavepattern != null;

  // "fit" field.
  String? _fit;
  String get fit => _fit ?? '';
  bool hasFit() => _fit != null;

  // "productdetails" field.
  String? _productdetails;
  String get productdetails => _productdetails ?? '';
  bool hasProductdetails() => _productdetails != null;

  // "sizefit" field.
  String? _sizefit;
  String get sizefit => _sizefit ?? '';
  bool hasSizefit() => _sizefit != null;

  // "materialandcare" field.
  String? _materialandcare;
  String get materialandcare => _materialandcare ?? '';
  bool hasMaterialandcare() => _materialandcare != null;

  // "customizable" field.
  String? _customizable;
  String get customizable => _customizable ?? '';
  bool hasCustomizable() => _customizable != null;

  // "color" field.
  String? _color;
  String get color => _color ?? '';
  bool hasColor() => _color != null;

  // "sku" field.
  String? _sku;
  String get sku => _sku ?? '';
  bool hasSku() => _sku != null;

  // "OutOfStock" field.
  bool? _outOfStock;
  bool get outOfStock => _outOfStock ?? false;
  bool hasOutOfStock() => _outOfStock != null;

  void _initializeFields() {
    _catref = snapshotData['catref'] as DocumentReference?;
    _designerref = snapshotData['designerref'] as DocumentReference?;
    _productname = snapshotData['Productname'] as String?;
    _mrp = castToType<double>(snapshotData['MRP']);
    _description = snapshotData['description'] as String?;
    _image = snapshotData['image'] as String?;
    _size = snapshotData['size'] as String?;
    _stock = castToType<double>(snapshotData['stock']);
    _imagelist = getDataList(snapshotData['imagelist']);
    _isfav = snapshotData['isfav'] as bool?;
    _subcategoreyref1 = snapshotData['subcategoreyref1'] as DocumentReference?;
    _spotlightOn = snapshotData['spotlight_on'] as bool?;
    _onSale = snapshotData['On_sale'] as bool?;
    _salPercentage = castToType<double>(snapshotData['sal_percentage']);
    _review = snapshotData['review'] as String?;
    _ratings = castToType<double>(snapshotData['ratings']);
    _shippingReturns = snapshotData['shipping_returns'] as String?;
    _sustainable = snapshotData['Sustainable'] as bool?;
    _fabric = snapshotData['fabric'] as String?;
    _weavepattern = snapshotData['weavepattern'] as String?;
    _fit = snapshotData['fit'] as String?;
    _productdetails = snapshotData['productdetails'] as String?;
    _sizefit = snapshotData['sizefit'] as String?;
    _materialandcare = snapshotData['materialandcare'] as String?;
    _customizable = snapshotData['customizable'] as String?;
    _color = snapshotData['color'] as String?;
    _sku = snapshotData['sku'] as String?;
    _outOfStock = snapshotData['OutOfStock'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Products');

  static Stream<ProductsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ProductsRecord.fromSnapshot(s));

  static Future<ProductsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ProductsRecord.fromSnapshot(s));

  static ProductsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ProductsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ProductsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ProductsRecord._(reference, mapFromFirestore(data));

  static ProductsRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      ProductsRecord.getDocumentFromData(
        {
          'catref': convertAlgoliaParam(
            snapshot.data['catref'],
            ParamType.DocumentReference,
            false,
          ),
          'designerref': convertAlgoliaParam(
            snapshot.data['designerref'],
            ParamType.DocumentReference,
            false,
          ),
          'Productname': snapshot.data['Productname'],
          'MRP': convertAlgoliaParam(
            snapshot.data['MRP'],
            ParamType.double,
            false,
          ),
          'description': snapshot.data['description'],
          'image': snapshot.data['image'],
          'size': snapshot.data['size'],
          'stock': convertAlgoliaParam(
            snapshot.data['stock'],
            ParamType.double,
            false,
          ),
          'imagelist': safeGet(
            () => snapshot.data['imagelist'].toList(),
          ),
          'isfav': snapshot.data['isfav'],
          'subcategoreyref1': convertAlgoliaParam(
            snapshot.data['subcategoreyref1'],
            ParamType.DocumentReference,
            false,
          ),
          'spotlight_on': snapshot.data['spotlight_on'],
          'On_sale': snapshot.data['On_sale'],
          'sal_percentage': convertAlgoliaParam(
            snapshot.data['sal_percentage'],
            ParamType.double,
            false,
          ),
          'review': snapshot.data['review'],
          'ratings': convertAlgoliaParam(
            snapshot.data['ratings'],
            ParamType.double,
            false,
          ),
          'shipping_returns': snapshot.data['shipping_returns'],
          'Sustainable': snapshot.data['Sustainable'],
          'fabric': snapshot.data['fabric'],
          'weavepattern': snapshot.data['weavepattern'],
          'fit': snapshot.data['fit'],
          'productdetails': snapshot.data['productdetails'],
          'sizefit': snapshot.data['sizefit'],
          'materialandcare': snapshot.data['materialandcare'],
          'customizable': snapshot.data['customizable'],
          'color': snapshot.data['color'],
          'sku': snapshot.data['sku'],
          'OutOfStock': snapshot.data['OutOfStock'],
        },
        ProductsRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<ProductsRecord>> search({
    String? term,
    FutureOr<LatLng>? location,
    int? maxResults,
    double? searchRadiusMeters,
    bool useCache = false,
  }) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'Products',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
            useCache: useCache,
          )
          .then((r) => r.map(fromAlgolia).toList());

  @override
  String toString() =>
      'ProductsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ProductsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createProductsRecordData({
  DocumentReference? catref,
  DocumentReference? designerref,
  String? productname,
  double? mrp,
  String? description,
  String? image,
  String? size,
  double? stock,
  bool? isfav,
  DocumentReference? subcategoreyref1,
  bool? spotlightOn,
  bool? onSale,
  double? salPercentage,
  String? review,
  double? ratings,
  String? shippingReturns,
  bool? sustainable,
  String? fabric,
  String? weavepattern,
  String? fit,
  String? productdetails,
  String? sizefit,
  String? materialandcare,
  String? customizable,
  String? color,
  String? sku,
  bool? outOfStock,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'catref': catref,
      'designerref': designerref,
      'Productname': productname,
      'MRP': mrp,
      'description': description,
      'image': image,
      'size': size,
      'stock': stock,
      'isfav': isfav,
      'subcategoreyref1': subcategoreyref1,
      'spotlight_on': spotlightOn,
      'On_sale': onSale,
      'sal_percentage': salPercentage,
      'review': review,
      'ratings': ratings,
      'shipping_returns': shippingReturns,
      'Sustainable': sustainable,
      'fabric': fabric,
      'weavepattern': weavepattern,
      'fit': fit,
      'productdetails': productdetails,
      'sizefit': sizefit,
      'materialandcare': materialandcare,
      'customizable': customizable,
      'color': color,
      'sku': sku,
      'OutOfStock': outOfStock,
    }.withoutNulls,
  );

  return firestoreData;
}

class ProductsRecordDocumentEquality implements Equality<ProductsRecord> {
  const ProductsRecordDocumentEquality();

  @override
  bool equals(ProductsRecord? e1, ProductsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.catref == e2?.catref &&
        e1?.designerref == e2?.designerref &&
        e1?.productname == e2?.productname &&
        e1?.mrp == e2?.mrp &&
        e1?.description == e2?.description &&
        e1?.image == e2?.image &&
        e1?.size == e2?.size &&
        e1?.stock == e2?.stock &&
        listEquality.equals(e1?.imagelist, e2?.imagelist) &&
        e1?.isfav == e2?.isfav &&
        e1?.subcategoreyref1 == e2?.subcategoreyref1 &&
        e1?.spotlightOn == e2?.spotlightOn &&
        e1?.onSale == e2?.onSale &&
        e1?.salPercentage == e2?.salPercentage &&
        e1?.review == e2?.review &&
        e1?.ratings == e2?.ratings &&
        e1?.shippingReturns == e2?.shippingReturns &&
        e1?.sustainable == e2?.sustainable &&
        e1?.fabric == e2?.fabric &&
        e1?.weavepattern == e2?.weavepattern &&
        e1?.fit == e2?.fit &&
        e1?.productdetails == e2?.productdetails &&
        e1?.sizefit == e2?.sizefit &&
        e1?.materialandcare == e2?.materialandcare &&
        e1?.customizable == e2?.customizable &&
        e1?.color == e2?.color &&
        e1?.sku == e2?.sku &&
        e1?.outOfStock == e2?.outOfStock;
  }

  @override
  int hash(ProductsRecord? e) => const ListEquality().hash([
        e?.catref,
        e?.designerref,
        e?.productname,
        e?.mrp,
        e?.description,
        e?.image,
        e?.size,
        e?.stock,
        e?.imagelist,
        e?.isfav,
        e?.subcategoreyref1,
        e?.spotlightOn,
        e?.onSale,
        e?.salPercentage,
        e?.review,
        e?.ratings,
        e?.shippingReturns,
        e?.sustainable,
        e?.fabric,
        e?.weavepattern,
        e?.fit,
        e?.productdetails,
        e?.sizefit,
        e?.materialandcare,
        e?.customizable,
        e?.color,
        e?.sku,
        e?.outOfStock
      ]);

  @override
  bool isValidKey(Object? o) => o is ProductsRecord;
}
