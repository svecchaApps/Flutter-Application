// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class CartStruct extends FFFirebaseStruct {
  CartStruct({
    double? price,
    String? productname,
    int? quantity,
    String? image,
    String? size,
    double? total,
    String? finalamounttopay,
    double? totalvalueofcart,
    double? designerId,
    DocumentReference? designerref,
    DocumentReference? productref,
    String? sku,
    DocumentReference? subproductref,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _price = price,
        _productname = productname,
        _quantity = quantity,
        _image = image,
        _size = size,
        _total = total,
        _finalamounttopay = finalamounttopay,
        _totalvalueofcart = totalvalueofcart,
        _designerId = designerId,
        _designerref = designerref,
        _productref = productref,
        _sku = sku,
        _subproductref = subproductref,
        super(firestoreUtilData);

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  set price(double? val) => _price = val;

  void incrementPrice(double amount) => price = price + amount;

  bool hasPrice() => _price != null;

  // "productname" field.
  String? _productname;
  String get productname => _productname ?? '';
  set productname(String? val) => _productname = val;

  bool hasProductname() => _productname != null;

  // "quantity" field.
  int? _quantity;
  int get quantity => _quantity ?? 0;
  set quantity(int? val) => _quantity = val;

  void incrementQuantity(int amount) => quantity = quantity + amount;

  bool hasQuantity() => _quantity != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  set image(String? val) => _image = val;

  bool hasImage() => _image != null;

  // "size" field.
  String? _size;
  String get size => _size ?? '';
  set size(String? val) => _size = val;

  bool hasSize() => _size != null;

  // "total" field.
  double? _total;
  double get total => _total ?? 0.0;
  set total(double? val) => _total = val;

  void incrementTotal(double amount) => total = total + amount;

  bool hasTotal() => _total != null;

  // "finalamounttopay" field.
  String? _finalamounttopay;
  String get finalamounttopay => _finalamounttopay ?? '';
  set finalamounttopay(String? val) => _finalamounttopay = val;

  bool hasFinalamounttopay() => _finalamounttopay != null;

  // "totalvalueofcart" field.
  double? _totalvalueofcart;
  double get totalvalueofcart => _totalvalueofcart ?? 0.0;
  set totalvalueofcart(double? val) => _totalvalueofcart = val;

  void incrementTotalvalueofcart(double amount) =>
      totalvalueofcart = totalvalueofcart + amount;

  bool hasTotalvalueofcart() => _totalvalueofcart != null;

  // "designer_id" field.
  double? _designerId;
  double get designerId => _designerId ?? 0.0;
  set designerId(double? val) => _designerId = val;

  void incrementDesignerId(double amount) => designerId = designerId + amount;

  bool hasDesignerId() => _designerId != null;

  // "designerref" field.
  DocumentReference? _designerref;
  DocumentReference? get designerref => _designerref;
  set designerref(DocumentReference? val) => _designerref = val;

  bool hasDesignerref() => _designerref != null;

  // "productref" field.
  DocumentReference? _productref;
  DocumentReference? get productref => _productref;
  set productref(DocumentReference? val) => _productref = val;

  bool hasProductref() => _productref != null;

  // "sku" field.
  String? _sku;
  String get sku => _sku ?? '';
  set sku(String? val) => _sku = val;

  bool hasSku() => _sku != null;

  // "subproductref" field.
  DocumentReference? _subproductref;
  DocumentReference? get subproductref => _subproductref;
  set subproductref(DocumentReference? val) => _subproductref = val;

  bool hasSubproductref() => _subproductref != null;

  static CartStruct fromMap(Map<String, dynamic> data) => CartStruct(
        price: castToType<double>(data['price']),
        productname: data['productname'] as String?,
        quantity: castToType<int>(data['quantity']),
        image: data['image'] as String?,
        size: data['size'] as String?,
        total: castToType<double>(data['total']),
        finalamounttopay: data['finalamounttopay'] as String?,
        totalvalueofcart: castToType<double>(data['totalvalueofcart']),
        designerId: castToType<double>(data['designer_id']),
        designerref: data['designerref'] as DocumentReference?,
        productref: data['productref'] as DocumentReference?,
        sku: data['sku'] as String?,
        subproductref: data['subproductref'] as DocumentReference?,
      );

  static CartStruct? maybeFromMap(dynamic data) =>
      data is Map ? CartStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'price': _price,
        'productname': _productname,
        'quantity': _quantity,
        'image': _image,
        'size': _size,
        'total': _total,
        'finalamounttopay': _finalamounttopay,
        'totalvalueofcart': _totalvalueofcart,
        'designer_id': _designerId,
        'designerref': _designerref,
        'productref': _productref,
        'sku': _sku,
        'subproductref': _subproductref,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'price': serializeParam(
          _price,
          ParamType.double,
        ),
        'productname': serializeParam(
          _productname,
          ParamType.String,
        ),
        'quantity': serializeParam(
          _quantity,
          ParamType.int,
        ),
        'image': serializeParam(
          _image,
          ParamType.String,
        ),
        'size': serializeParam(
          _size,
          ParamType.String,
        ),
        'total': serializeParam(
          _total,
          ParamType.double,
        ),
        'finalamounttopay': serializeParam(
          _finalamounttopay,
          ParamType.String,
        ),
        'totalvalueofcart': serializeParam(
          _totalvalueofcart,
          ParamType.double,
        ),
        'designer_id': serializeParam(
          _designerId,
          ParamType.double,
        ),
        'designerref': serializeParam(
          _designerref,
          ParamType.DocumentReference,
        ),
        'productref': serializeParam(
          _productref,
          ParamType.DocumentReference,
        ),
        'sku': serializeParam(
          _sku,
          ParamType.String,
        ),
        'subproductref': serializeParam(
          _subproductref,
          ParamType.DocumentReference,
        ),
      }.withoutNulls;

  static CartStruct fromSerializableMap(Map<String, dynamic> data) =>
      CartStruct(
        price: deserializeParam(
          data['price'],
          ParamType.double,
          false,
        ),
        productname: deserializeParam(
          data['productname'],
          ParamType.String,
          false,
        ),
        quantity: deserializeParam(
          data['quantity'],
          ParamType.int,
          false,
        ),
        image: deserializeParam(
          data['image'],
          ParamType.String,
          false,
        ),
        size: deserializeParam(
          data['size'],
          ParamType.String,
          false,
        ),
        total: deserializeParam(
          data['total'],
          ParamType.double,
          false,
        ),
        finalamounttopay: deserializeParam(
          data['finalamounttopay'],
          ParamType.String,
          false,
        ),
        totalvalueofcart: deserializeParam(
          data['totalvalueofcart'],
          ParamType.double,
          false,
        ),
        designerId: deserializeParam(
          data['designer_id'],
          ParamType.double,
          false,
        ),
        designerref: deserializeParam(
          data['designerref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['Designer'],
        ),
        productref: deserializeParam(
          data['productref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['Products'],
        ),
        sku: deserializeParam(
          data['sku'],
          ParamType.String,
          false,
        ),
        subproductref: deserializeParam(
          data['subproductref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['subproducts1'],
        ),
      );

  static CartStruct fromAlgoliaData(Map<String, dynamic> data) => CartStruct(
        price: convertAlgoliaParam(
          data['price'],
          ParamType.double,
          false,
        ),
        productname: convertAlgoliaParam(
          data['productname'],
          ParamType.String,
          false,
        ),
        quantity: convertAlgoliaParam(
          data['quantity'],
          ParamType.int,
          false,
        ),
        image: convertAlgoliaParam(
          data['image'],
          ParamType.String,
          false,
        ),
        size: convertAlgoliaParam(
          data['size'],
          ParamType.String,
          false,
        ),
        total: convertAlgoliaParam(
          data['total'],
          ParamType.double,
          false,
        ),
        finalamounttopay: convertAlgoliaParam(
          data['finalamounttopay'],
          ParamType.String,
          false,
        ),
        totalvalueofcart: convertAlgoliaParam(
          data['totalvalueofcart'],
          ParamType.double,
          false,
        ),
        designerId: convertAlgoliaParam(
          data['designer_id'],
          ParamType.double,
          false,
        ),
        designerref: convertAlgoliaParam(
          data['designerref'],
          ParamType.DocumentReference,
          false,
        ),
        productref: convertAlgoliaParam(
          data['productref'],
          ParamType.DocumentReference,
          false,
        ),
        sku: convertAlgoliaParam(
          data['sku'],
          ParamType.String,
          false,
        ),
        subproductref: convertAlgoliaParam(
          data['subproductref'],
          ParamType.DocumentReference,
          false,
        ),
        firestoreUtilData: const FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'CartStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CartStruct &&
        price == other.price &&
        productname == other.productname &&
        quantity == other.quantity &&
        image == other.image &&
        size == other.size &&
        total == other.total &&
        finalamounttopay == other.finalamounttopay &&
        totalvalueofcart == other.totalvalueofcart &&
        designerId == other.designerId &&
        designerref == other.designerref &&
        productref == other.productref &&
        sku == other.sku &&
        subproductref == other.subproductref;
  }

  @override
  int get hashCode => const ListEquality().hash([
        price,
        productname,
        quantity,
        image,
        size,
        total,
        finalamounttopay,
        totalvalueofcart,
        designerId,
        designerref,
        productref,
        sku,
        subproductref
      ]);
}

CartStruct createCartStruct({
  double? price,
  String? productname,
  int? quantity,
  String? image,
  String? size,
  double? total,
  String? finalamounttopay,
  double? totalvalueofcart,
  double? designerId,
  DocumentReference? designerref,
  DocumentReference? productref,
  String? sku,
  DocumentReference? subproductref,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CartStruct(
      price: price,
      productname: productname,
      quantity: quantity,
      image: image,
      size: size,
      total: total,
      finalamounttopay: finalamounttopay,
      totalvalueofcart: totalvalueofcart,
      designerId: designerId,
      designerref: designerref,
      productref: productref,
      sku: sku,
      subproductref: subproductref,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CartStruct? updateCartStruct(
  CartStruct? cart, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    cart
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCartStructData(
  Map<String, dynamic> firestoreData,
  CartStruct? cart,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (cart == null) {
    return;
  }
  if (cart.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue && cart.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final cartData = getCartFirestoreData(cart, forFieldValue);
  final nestedData = cartData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = cart.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCartFirestoreData(
  CartStruct? cart, [
  bool forFieldValue = false,
]) {
  if (cart == null) {
    return {};
  }
  final firestoreData = mapToFirestore(cart.toMap());

  // Add any Firestore field values
  cart.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCartListFirestoreData(
  List<CartStruct>? carts,
) =>
    carts?.map((e) => getCartFirestoreData(e, true)).toList() ?? [];
