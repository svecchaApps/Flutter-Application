// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class RecentlyviewedStruct extends FFFirebaseStruct {
  RecentlyviewedStruct({
    String? productname,
    double? price,
    DocumentReference? productref,
    String? image,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _productname = productname,
        _price = price,
        _productref = productref,
        _image = image,
        super(firestoreUtilData);

  // "productname" field.
  String? _productname;
  String get productname => _productname ?? '';
  set productname(String? val) => _productname = val;

  bool hasProductname() => _productname != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  set price(double? val) => _price = val;

  void incrementPrice(double amount) => price = price + amount;

  bool hasPrice() => _price != null;

  // "productref" field.
  DocumentReference? _productref;
  DocumentReference? get productref => _productref;
  set productref(DocumentReference? val) => _productref = val;

  bool hasProductref() => _productref != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  set image(String? val) => _image = val;

  bool hasImage() => _image != null;

  static RecentlyviewedStruct fromMap(Map<String, dynamic> data) =>
      RecentlyviewedStruct(
        productname: data['productname'] as String?,
        price: castToType<double>(data['price']),
        productref: data['productref'] as DocumentReference?,
        image: data['image'] as String?,
      );

  static RecentlyviewedStruct? maybeFromMap(dynamic data) => data is Map
      ? RecentlyviewedStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'productname': _productname,
        'price': _price,
        'productref': _productref,
        'image': _image,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'productname': serializeParam(
          _productname,
          ParamType.String,
        ),
        'price': serializeParam(
          _price,
          ParamType.double,
        ),
        'productref': serializeParam(
          _productref,
          ParamType.DocumentReference,
        ),
        'image': serializeParam(
          _image,
          ParamType.String,
        ),
      }.withoutNulls;

  static RecentlyviewedStruct fromSerializableMap(Map<String, dynamic> data) =>
      RecentlyviewedStruct(
        productname: deserializeParam(
          data['productname'],
          ParamType.String,
          false,
        ),
        price: deserializeParam(
          data['price'],
          ParamType.double,
          false,
        ),
        productref: deserializeParam(
          data['productref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['Products'],
        ),
        image: deserializeParam(
          data['image'],
          ParamType.String,
          false,
        ),
      );

  static RecentlyviewedStruct fromAlgoliaData(Map<String, dynamic> data) =>
      RecentlyviewedStruct(
        productname: convertAlgoliaParam(
          data['productname'],
          ParamType.String,
          false,
        ),
        price: convertAlgoliaParam(
          data['price'],
          ParamType.double,
          false,
        ),
        productref: convertAlgoliaParam(
          data['productref'],
          ParamType.DocumentReference,
          false,
        ),
        image: convertAlgoliaParam(
          data['image'],
          ParamType.String,
          false,
        ),
        firestoreUtilData: const FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'RecentlyviewedStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RecentlyviewedStruct &&
        productname == other.productname &&
        price == other.price &&
        productref == other.productref &&
        image == other.image;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([productname, price, productref, image]);
}

RecentlyviewedStruct createRecentlyviewedStruct({
  String? productname,
  double? price,
  DocumentReference? productref,
  String? image,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RecentlyviewedStruct(
      productname: productname,
      price: price,
      productref: productref,
      image: image,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RecentlyviewedStruct? updateRecentlyviewedStruct(
  RecentlyviewedStruct? recentlyviewed, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    recentlyviewed
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRecentlyviewedStructData(
  Map<String, dynamic> firestoreData,
  RecentlyviewedStruct? recentlyviewed,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (recentlyviewed == null) {
    return;
  }
  if (recentlyviewed.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && recentlyviewed.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final recentlyviewedData =
      getRecentlyviewedFirestoreData(recentlyviewed, forFieldValue);
  final nestedData =
      recentlyviewedData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = recentlyviewed.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRecentlyviewedFirestoreData(
  RecentlyviewedStruct? recentlyviewed, [
  bool forFieldValue = false,
]) {
  if (recentlyviewed == null) {
    return {};
  }
  final firestoreData = mapToFirestore(recentlyviewed.toMap());

  // Add any Firestore field values
  recentlyviewed.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRecentlyviewedListFirestoreData(
  List<RecentlyviewedStruct>? recentlyvieweds,
) =>
    recentlyvieweds
        ?.map((e) => getRecentlyviewedFirestoreData(e, true))
        .toList() ??
    [];
