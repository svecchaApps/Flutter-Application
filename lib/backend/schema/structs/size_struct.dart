// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class SizeStruct extends FFFirebaseStruct {
  SizeStruct({
    double? price,
    String? sIzeofProduct,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _price = price,
        _sIzeofProduct = sIzeofProduct,
        super(firestoreUtilData);

  // "Price" field.
  double? _price;
  double get price => _price ?? 0.0;
  set price(double? val) => _price = val;

  void incrementPrice(double amount) => price = price + amount;

  bool hasPrice() => _price != null;

  // "SIzeofProduct" field.
  String? _sIzeofProduct;
  String get sIzeofProduct => _sIzeofProduct ?? '';
  set sIzeofProduct(String? val) => _sIzeofProduct = val;

  bool hasSIzeofProduct() => _sIzeofProduct != null;

  static SizeStruct fromMap(Map<String, dynamic> data) => SizeStruct(
        price: castToType<double>(data['Price']),
        sIzeofProduct: data['SIzeofProduct'] as String?,
      );

  static SizeStruct? maybeFromMap(dynamic data) =>
      data is Map ? SizeStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'Price': _price,
        'SIzeofProduct': _sIzeofProduct,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Price': serializeParam(
          _price,
          ParamType.double,
        ),
        'SIzeofProduct': serializeParam(
          _sIzeofProduct,
          ParamType.String,
        ),
      }.withoutNulls;

  static SizeStruct fromSerializableMap(Map<String, dynamic> data) =>
      SizeStruct(
        price: deserializeParam(
          data['Price'],
          ParamType.double,
          false,
        ),
        sIzeofProduct: deserializeParam(
          data['SIzeofProduct'],
          ParamType.String,
          false,
        ),
      );

  static SizeStruct fromAlgoliaData(Map<String, dynamic> data) => SizeStruct(
        price: convertAlgoliaParam(
          data['Price'],
          ParamType.double,
          false,
        ),
        sIzeofProduct: convertAlgoliaParam(
          data['SIzeofProduct'],
          ParamType.String,
          false,
        ),
        firestoreUtilData: const FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'SizeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SizeStruct &&
        price == other.price &&
        sIzeofProduct == other.sIzeofProduct;
  }

  @override
  int get hashCode => const ListEquality().hash([price, sIzeofProduct]);
}

SizeStruct createSizeStruct({
  double? price,
  String? sIzeofProduct,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SizeStruct(
      price: price,
      sIzeofProduct: sIzeofProduct,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SizeStruct? updateSizeStruct(
  SizeStruct? size, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    size
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSizeStructData(
  Map<String, dynamic> firestoreData,
  SizeStruct? size,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (size == null) {
    return;
  }
  if (size.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue && size.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final sizeData = getSizeFirestoreData(size, forFieldValue);
  final nestedData = sizeData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = size.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSizeFirestoreData(
  SizeStruct? size, [
  bool forFieldValue = false,
]) {
  if (size == null) {
    return {};
  }
  final firestoreData = mapToFirestore(size.toMap());

  // Add any Firestore field values
  size.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSizeListFirestoreData(
  List<SizeStruct>? sizes,
) =>
    sizes?.map((e) => getSizeFirestoreData(e, true)).toList() ?? [];
