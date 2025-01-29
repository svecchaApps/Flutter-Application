import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class Subproducts1colorsRecord extends FirestoreRecord {
  Subproducts1colorsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "Productref" field.
  DocumentReference? _productref;
  DocumentReference? get productref => _productref;
  bool hasProductref() => _productref != null;

  // "Mainproductref" field.
  DocumentReference? _mainproductref;
  DocumentReference? get mainproductref => _mainproductref;
  bool hasMainproductref() => _mainproductref != null;

  // "Color" field.
  String? _color;
  String get color => _color ?? '';
  bool hasColor() => _color != null;

  // "colorProductRef" field.
  DocumentReference? _colorProductRef;
  DocumentReference? get colorProductRef => _colorProductRef;
  bool hasColorProductRef() => _colorProductRef != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  void _initializeFields() {
    _productref = snapshotData['Productref'] as DocumentReference?;
    _mainproductref = snapshotData['Mainproductref'] as DocumentReference?;
    _color = snapshotData['Color'] as String?;
    _colorProductRef = snapshotData['colorProductRef'] as DocumentReference?;
    _image = snapshotData['image'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('subproducts1colors');

  static Stream<Subproducts1colorsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => Subproducts1colorsRecord.fromSnapshot(s));

  static Future<Subproducts1colorsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => Subproducts1colorsRecord.fromSnapshot(s));

  static Subproducts1colorsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      Subproducts1colorsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static Subproducts1colorsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      Subproducts1colorsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'Subproducts1colorsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is Subproducts1colorsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSubproducts1colorsRecordData({
  DocumentReference? productref,
  DocumentReference? mainproductref,
  String? color,
  DocumentReference? colorProductRef,
  String? image,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Productref': productref,
      'Mainproductref': mainproductref,
      'Color': color,
      'colorProductRef': colorProductRef,
      'image': image,
    }.withoutNulls,
  );

  return firestoreData;
}

class Subproducts1colorsRecordDocumentEquality
    implements Equality<Subproducts1colorsRecord> {
  const Subproducts1colorsRecordDocumentEquality();

  @override
  bool equals(Subproducts1colorsRecord? e1, Subproducts1colorsRecord? e2) {
    return e1?.productref == e2?.productref &&
        e1?.mainproductref == e2?.mainproductref &&
        e1?.color == e2?.color &&
        e1?.colorProductRef == e2?.colorProductRef &&
        e1?.image == e2?.image;
  }

  @override
  int hash(Subproducts1colorsRecord? e) => const ListEquality().hash([
        e?.productref,
        e?.mainproductref,
        e?.color,
        e?.colorProductRef,
        e?.image
      ]);

  @override
  bool isValidKey(Object? o) => o is Subproducts1colorsRecord;
}
