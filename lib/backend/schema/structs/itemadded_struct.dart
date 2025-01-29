// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ItemaddedStruct extends FFFirebaseStruct {
  ItemaddedStruct({
    String? name,
    String? size,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _size = size,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "size" field.
  String? _size;
  String get size => _size ?? '';
  set size(String? val) => _size = val;

  bool hasSize() => _size != null;

  static ItemaddedStruct fromMap(Map<String, dynamic> data) => ItemaddedStruct(
        name: data['name'] as String?,
        size: data['size'] as String?,
      );

  static ItemaddedStruct? maybeFromMap(dynamic data) => data is Map
      ? ItemaddedStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'size': _size,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'size': serializeParam(
          _size,
          ParamType.String,
        ),
      }.withoutNulls;

  static ItemaddedStruct fromSerializableMap(Map<String, dynamic> data) =>
      ItemaddedStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        size: deserializeParam(
          data['size'],
          ParamType.String,
          false,
        ),
      );

  static ItemaddedStruct fromAlgoliaData(Map<String, dynamic> data) =>
      ItemaddedStruct(
        name: convertAlgoliaParam(
          data['name'],
          ParamType.String,
          false,
        ),
        size: convertAlgoliaParam(
          data['size'],
          ParamType.String,
          false,
        ),
        firestoreUtilData: const FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'ItemaddedStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ItemaddedStruct && name == other.name && size == other.size;
  }

  @override
  int get hashCode => const ListEquality().hash([name, size]);
}

ItemaddedStruct createItemaddedStruct({
  String? name,
  String? size,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ItemaddedStruct(
      name: name,
      size: size,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ItemaddedStruct? updateItemaddedStruct(
  ItemaddedStruct? itemadded, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    itemadded
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addItemaddedStructData(
  Map<String, dynamic> firestoreData,
  ItemaddedStruct? itemadded,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (itemadded == null) {
    return;
  }
  if (itemadded.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && itemadded.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final itemaddedData = getItemaddedFirestoreData(itemadded, forFieldValue);
  final nestedData = itemaddedData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = itemadded.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getItemaddedFirestoreData(
  ItemaddedStruct? itemadded, [
  bool forFieldValue = false,
]) {
  if (itemadded == null) {
    return {};
  }
  final firestoreData = mapToFirestore(itemadded.toMap());

  // Add any Firestore field values
  itemadded.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getItemaddedListFirestoreData(
  List<ItemaddedStruct>? itemaddeds,
) =>
    itemaddeds?.map((e) => getItemaddedFirestoreData(e, true)).toList() ?? [];
