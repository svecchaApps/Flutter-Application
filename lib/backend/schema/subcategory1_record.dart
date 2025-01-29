import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class Subcategory1Record extends FirestoreRecord {
  Subcategory1Record._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "categoryref" field.
  DocumentReference? _categoryref;
  DocumentReference? get categoryref => _categoryref;
  bool hasCategoryref() => _categoryref != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "imagepath" field.
  String? _imagepath;
  String get imagepath => _imagepath ?? '';
  bool hasImagepath() => _imagepath != null;

  // "dateadded" field.
  DateTime? _dateadded;
  DateTime? get dateadded => _dateadded;
  bool hasDateadded() => _dateadded != null;

  // "designerref" field.
  DocumentReference? _designerref;
  DocumentReference? get designerref => _designerref;
  bool hasDesignerref() => _designerref != null;

  void _initializeFields() {
    _categoryref = snapshotData['categoryref'] as DocumentReference?;
    _name = snapshotData['name'] as String?;
    _imagepath = snapshotData['imagepath'] as String?;
    _dateadded = snapshotData['dateadded'] as DateTime?;
    _designerref = snapshotData['designerref'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('subcategory1');

  static Stream<Subcategory1Record> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => Subcategory1Record.fromSnapshot(s));

  static Future<Subcategory1Record> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => Subcategory1Record.fromSnapshot(s));

  static Subcategory1Record fromSnapshot(DocumentSnapshot snapshot) =>
      Subcategory1Record._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static Subcategory1Record getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      Subcategory1Record._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'Subcategory1Record(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is Subcategory1Record &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSubcategory1RecordData({
  DocumentReference? categoryref,
  String? name,
  String? imagepath,
  DateTime? dateadded,
  DocumentReference? designerref,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'categoryref': categoryref,
      'name': name,
      'imagepath': imagepath,
      'dateadded': dateadded,
      'designerref': designerref,
    }.withoutNulls,
  );

  return firestoreData;
}

class Subcategory1RecordDocumentEquality
    implements Equality<Subcategory1Record> {
  const Subcategory1RecordDocumentEquality();

  @override
  bool equals(Subcategory1Record? e1, Subcategory1Record? e2) {
    return e1?.categoryref == e2?.categoryref &&
        e1?.name == e2?.name &&
        e1?.imagepath == e2?.imagepath &&
        e1?.dateadded == e2?.dateadded &&
        e1?.designerref == e2?.designerref;
  }

  @override
  int hash(Subcategory1Record? e) => const ListEquality().hash(
      [e?.categoryref, e?.name, e?.imagepath, e?.dateadded, e?.designerref]);

  @override
  bool isValidKey(Object? o) => o is Subcategory1Record;
}
