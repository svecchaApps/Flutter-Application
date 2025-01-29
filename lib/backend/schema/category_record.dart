import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CategoryRecord extends FirestoreRecord {
  CategoryRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "namecat" field.
  String? _namecat;
  String get namecat => _namecat ?? '';
  bool hasNamecat() => _namecat != null;

  // "catimage" field.
  String? _catimage;
  String get catimage => _catimage ?? '';
  bool hasCatimage() => _catimage != null;

  // "designeref" field.
  DocumentReference? _designeref;
  DocumentReference? get designeref => _designeref;
  bool hasDesigneref() => _designeref != null;

  void _initializeFields() {
    _namecat = snapshotData['namecat'] as String?;
    _catimage = snapshotData['catimage'] as String?;
    _designeref = snapshotData['designeref'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('category');

  static Stream<CategoryRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CategoryRecord.fromSnapshot(s));

  static Future<CategoryRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CategoryRecord.fromSnapshot(s));

  static CategoryRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CategoryRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CategoryRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CategoryRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CategoryRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CategoryRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCategoryRecordData({
  String? namecat,
  String? catimage,
  DocumentReference? designeref,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'namecat': namecat,
      'catimage': catimage,
      'designeref': designeref,
    }.withoutNulls,
  );

  return firestoreData;
}

class CategoryRecordDocumentEquality implements Equality<CategoryRecord> {
  const CategoryRecordDocumentEquality();

  @override
  bool equals(CategoryRecord? e1, CategoryRecord? e2) {
    return e1?.namecat == e2?.namecat &&
        e1?.catimage == e2?.catimage &&
        e1?.designeref == e2?.designeref;
  }

  @override
  int hash(CategoryRecord? e) =>
      const ListEquality().hash([e?.namecat, e?.catimage, e?.designeref]);

  @override
  bool isValidKey(Object? o) => o is CategoryRecord;
}
