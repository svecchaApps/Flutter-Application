// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ProductordersStruct extends FFFirebaseStruct {
  ProductordersStruct({
    double? quantity,
    DocumentReference? productref,
    String? productname,
    DocumentReference? designnerref,
    double? price,
    String? shiprocketInvoice,
    String? sku,
    DocumentReference? subproductref,
    bool? isreturn,
    String? returnReason,
    String? returnComments,
    String? color,
    String? orderStatus,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _quantity = quantity,
        _productref = productref,
        _productname = productname,
        _designnerref = designnerref,
        _price = price,
        _shiprocketInvoice = shiprocketInvoice,
        _sku = sku,
        _subproductref = subproductref,
        _isreturn = isreturn,
        _returnReason = returnReason,
        _returnComments = returnComments,
        _color = color,
        _orderStatus = orderStatus,
        super(firestoreUtilData);

  // "quantity" field.
  double? _quantity;
  double get quantity => _quantity ?? 0.0;
  set quantity(double? val) => _quantity = val;

  void incrementQuantity(double amount) => quantity = quantity + amount;

  bool hasQuantity() => _quantity != null;

  // "productref" field.
  DocumentReference? _productref;
  DocumentReference? get productref => _productref;
  set productref(DocumentReference? val) => _productref = val;

  bool hasProductref() => _productref != null;

  // "productname" field.
  String? _productname;
  String get productname => _productname ?? '';
  set productname(String? val) => _productname = val;

  bool hasProductname() => _productname != null;

  // "designnerref" field.
  DocumentReference? _designnerref;
  DocumentReference? get designnerref => _designnerref;
  set designnerref(DocumentReference? val) => _designnerref = val;

  bool hasDesignnerref() => _designnerref != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  set price(double? val) => _price = val;

  void incrementPrice(double amount) => price = price + amount;

  bool hasPrice() => _price != null;

  // "shiprocket_invoice" field.
  String? _shiprocketInvoice;
  String get shiprocketInvoice => _shiprocketInvoice ?? '';
  set shiprocketInvoice(String? val) => _shiprocketInvoice = val;

  bool hasShiprocketInvoice() => _shiprocketInvoice != null;

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

  // "isreturn" field.
  bool? _isreturn;
  bool get isreturn => _isreturn ?? false;
  set isreturn(bool? val) => _isreturn = val;

  bool hasIsreturn() => _isreturn != null;

  // "return_reason" field.
  String? _returnReason;
  String get returnReason => _returnReason ?? '';
  set returnReason(String? val) => _returnReason = val;

  bool hasReturnReason() => _returnReason != null;

  // "return_comments" field.
  String? _returnComments;
  String get returnComments => _returnComments ?? '';
  set returnComments(String? val) => _returnComments = val;

  bool hasReturnComments() => _returnComments != null;

  // "color" field.
  String? _color;
  String get color => _color ?? '';
  set color(String? val) => _color = val;

  bool hasColor() => _color != null;

  // "Order_status" field.
  String? _orderStatus;
  String get orderStatus => _orderStatus ?? 'Created';
  set orderStatus(String? val) => _orderStatus = val;

  bool hasOrderStatus() => _orderStatus != null;

  static ProductordersStruct fromMap(Map<String, dynamic> data) =>
      ProductordersStruct(
        quantity: castToType<double>(data['quantity']),
        productref: data['productref'] as DocumentReference?,
        productname: data['productname'] as String?,
        designnerref: data['designnerref'] as DocumentReference?,
        price: castToType<double>(data['price']),
        shiprocketInvoice: data['shiprocket_invoice'] as String?,
        sku: data['sku'] as String?,
        subproductref: data['subproductref'] as DocumentReference?,
        isreturn: data['isreturn'] as bool?,
        returnReason: data['return_reason'] as String?,
        returnComments: data['return_comments'] as String?,
        color: data['color'] as String?,
        orderStatus: data['Order_status'] as String?,
      );

  static ProductordersStruct? maybeFromMap(dynamic data) => data is Map
      ? ProductordersStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'quantity': _quantity,
        'productref': _productref,
        'productname': _productname,
        'designnerref': _designnerref,
        'price': _price,
        'shiprocket_invoice': _shiprocketInvoice,
        'sku': _sku,
        'subproductref': _subproductref,
        'isreturn': _isreturn,
        'return_reason': _returnReason,
        'return_comments': _returnComments,
        'color': _color,
        'Order_status': _orderStatus,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'quantity': serializeParam(
          _quantity,
          ParamType.double,
        ),
        'productref': serializeParam(
          _productref,
          ParamType.DocumentReference,
        ),
        'productname': serializeParam(
          _productname,
          ParamType.String,
        ),
        'designnerref': serializeParam(
          _designnerref,
          ParamType.DocumentReference,
        ),
        'price': serializeParam(
          _price,
          ParamType.double,
        ),
        'shiprocket_invoice': serializeParam(
          _shiprocketInvoice,
          ParamType.String,
        ),
        'sku': serializeParam(
          _sku,
          ParamType.String,
        ),
        'subproductref': serializeParam(
          _subproductref,
          ParamType.DocumentReference,
        ),
        'isreturn': serializeParam(
          _isreturn,
          ParamType.bool,
        ),
        'return_reason': serializeParam(
          _returnReason,
          ParamType.String,
        ),
        'return_comments': serializeParam(
          _returnComments,
          ParamType.String,
        ),
        'color': serializeParam(
          _color,
          ParamType.String,
        ),
        'Order_status': serializeParam(
          _orderStatus,
          ParamType.String,
        ),
      }.withoutNulls;

  static ProductordersStruct fromSerializableMap(Map<String, dynamic> data) =>
      ProductordersStruct(
        quantity: deserializeParam(
          data['quantity'],
          ParamType.double,
          false,
        ),
        productref: deserializeParam(
          data['productref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['Products'],
        ),
        productname: deserializeParam(
          data['productname'],
          ParamType.String,
          false,
        ),
        designnerref: deserializeParam(
          data['designnerref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['Designer'],
        ),
        price: deserializeParam(
          data['price'],
          ParamType.double,
          false,
        ),
        shiprocketInvoice: deserializeParam(
          data['shiprocket_invoice'],
          ParamType.String,
          false,
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
        isreturn: deserializeParam(
          data['isreturn'],
          ParamType.bool,
          false,
        ),
        returnReason: deserializeParam(
          data['return_reason'],
          ParamType.String,
          false,
        ),
        returnComments: deserializeParam(
          data['return_comments'],
          ParamType.String,
          false,
        ),
        color: deserializeParam(
          data['color'],
          ParamType.String,
          false,
        ),
        orderStatus: deserializeParam(
          data['Order_status'],
          ParamType.String,
          false,
        ),
      );

  static ProductordersStruct fromAlgoliaData(Map<String, dynamic> data) =>
      ProductordersStruct(
        quantity: convertAlgoliaParam(
          data['quantity'],
          ParamType.double,
          false,
        ),
        productref: convertAlgoliaParam(
          data['productref'],
          ParamType.DocumentReference,
          false,
        ),
        productname: convertAlgoliaParam(
          data['productname'],
          ParamType.String,
          false,
        ),
        designnerref: convertAlgoliaParam(
          data['designnerref'],
          ParamType.DocumentReference,
          false,
        ),
        price: convertAlgoliaParam(
          data['price'],
          ParamType.double,
          false,
        ),
        shiprocketInvoice: convertAlgoliaParam(
          data['shiprocket_invoice'],
          ParamType.String,
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
        isreturn: convertAlgoliaParam(
          data['isreturn'],
          ParamType.bool,
          false,
        ),
        returnReason: convertAlgoliaParam(
          data['return_reason'],
          ParamType.String,
          false,
        ),
        returnComments: convertAlgoliaParam(
          data['return_comments'],
          ParamType.String,
          false,
        ),
        color: convertAlgoliaParam(
          data['color'],
          ParamType.String,
          false,
        ),
        orderStatus: convertAlgoliaParam(
          data['Order_status'],
          ParamType.String,
          false,
        ),
        firestoreUtilData: const FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'ProductordersStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ProductordersStruct &&
        quantity == other.quantity &&
        productref == other.productref &&
        productname == other.productname &&
        designnerref == other.designnerref &&
        price == other.price &&
        shiprocketInvoice == other.shiprocketInvoice &&
        sku == other.sku &&
        subproductref == other.subproductref &&
        isreturn == other.isreturn &&
        returnReason == other.returnReason &&
        returnComments == other.returnComments &&
        color == other.color &&
        orderStatus == other.orderStatus;
  }

  @override
  int get hashCode => const ListEquality().hash([
        quantity,
        productref,
        productname,
        designnerref,
        price,
        shiprocketInvoice,
        sku,
        subproductref,
        isreturn,
        returnReason,
        returnComments,
        color,
        orderStatus
      ]);
}

ProductordersStruct createProductordersStruct({
  double? quantity,
  DocumentReference? productref,
  String? productname,
  DocumentReference? designnerref,
  double? price,
  String? shiprocketInvoice,
  String? sku,
  DocumentReference? subproductref,
  bool? isreturn,
  String? returnReason,
  String? returnComments,
  String? color,
  String? orderStatus,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ProductordersStruct(
      quantity: quantity,
      productref: productref,
      productname: productname,
      designnerref: designnerref,
      price: price,
      shiprocketInvoice: shiprocketInvoice,
      sku: sku,
      subproductref: subproductref,
      isreturn: isreturn,
      returnReason: returnReason,
      returnComments: returnComments,
      color: color,
      orderStatus: orderStatus,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ProductordersStruct? updateProductordersStruct(
  ProductordersStruct? productorders, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    productorders
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addProductordersStructData(
  Map<String, dynamic> firestoreData,
  ProductordersStruct? productorders,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (productorders == null) {
    return;
  }
  if (productorders.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && productorders.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final productordersData =
      getProductordersFirestoreData(productorders, forFieldValue);
  final nestedData =
      productordersData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = productorders.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getProductordersFirestoreData(
  ProductordersStruct? productorders, [
  bool forFieldValue = false,
]) {
  if (productorders == null) {
    return {};
  }
  final firestoreData = mapToFirestore(productorders.toMap());

  // Add any Firestore field values
  productorders.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getProductordersListFirestoreData(
  List<ProductordersStruct>? productorderss,
) =>
    productorderss
        ?.map((e) => getProductordersFirestoreData(e, true))
        .toList() ??
    [];
