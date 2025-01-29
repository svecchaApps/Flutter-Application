// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class LikedByStruct extends FFFirebaseStruct {
  LikedByStruct({
    String? likeBy,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _likeBy = likeBy,
        super(firestoreUtilData);

  // "likeBy" field.
  String? _likeBy;
  String get likeBy => _likeBy ?? '';
  set likeBy(String? val) => _likeBy = val;

  bool hasLikeBy() => _likeBy != null;

  static LikedByStruct fromMap(Map<String, dynamic> data) => LikedByStruct(
        likeBy: data['likeBy'] as String?,
      );

  static LikedByStruct? maybeFromMap(dynamic data) =>
      data is Map ? LikedByStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'likeBy': _likeBy,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'likeBy': serializeParam(
          _likeBy,
          ParamType.String,
        ),
      }.withoutNulls;

  static LikedByStruct fromSerializableMap(Map<String, dynamic> data) =>
      LikedByStruct(
        likeBy: deserializeParam(
          data['likeBy'],
          ParamType.String,
          false,
        ),
      );

  static LikedByStruct fromAlgoliaData(Map<String, dynamic> data) =>
      LikedByStruct(
        likeBy: convertAlgoliaParam(
          data['likeBy'],
          ParamType.String,
          false,
        ),
        firestoreUtilData: const FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'LikedByStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LikedByStruct && likeBy == other.likeBy;
  }

  @override
  int get hashCode => const ListEquality().hash([likeBy]);
}

LikedByStruct createLikedByStruct({
  String? likeBy,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LikedByStruct(
      likeBy: likeBy,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

LikedByStruct? updateLikedByStruct(
  LikedByStruct? likedBy, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    likedBy
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addLikedByStructData(
  Map<String, dynamic> firestoreData,
  LikedByStruct? likedBy,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (likedBy == null) {
    return;
  }
  if (likedBy.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && likedBy.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final likedByData = getLikedByFirestoreData(likedBy, forFieldValue);
  final nestedData = likedByData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = likedBy.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLikedByFirestoreData(
  LikedByStruct? likedBy, [
  bool forFieldValue = false,
]) {
  if (likedBy == null) {
    return {};
  }
  final firestoreData = mapToFirestore(likedBy.toMap());

  // Add any Firestore field values
  likedBy.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLikedByListFirestoreData(
  List<LikedByStruct>? likedBys,
) =>
    likedBys?.map((e) => getLikedByFirestoreData(e, true)).toList() ?? [];
