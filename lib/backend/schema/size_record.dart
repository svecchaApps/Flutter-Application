import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SizeRecord extends FirestoreRecord {
  SizeRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "Size" field.
  String? _size;
  String get size => _size ?? '';
  bool hasSize() => _size != null;

  // "Price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  // "coloref" field.
  DocumentReference? _coloref;
  DocumentReference? get coloref => _coloref;
  bool hasColoref() => _coloref != null;

  void _initializeFields() {
    _size = snapshotData['Size'] as String?;
    _price = castToType<double>(snapshotData['Price']);
    _coloref = snapshotData['coloref'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Size');

  static Stream<SizeRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SizeRecord.fromSnapshot(s));

  static Future<SizeRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SizeRecord.fromSnapshot(s));

  static SizeRecord fromSnapshot(DocumentSnapshot snapshot) => SizeRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SizeRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SizeRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SizeRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SizeRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSizeRecordData({
  String? size,
  double? price,
  DocumentReference? coloref,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Size': size,
      'Price': price,
      'coloref': coloref,
    }.withoutNulls,
  );

  return firestoreData;
}

class SizeRecordDocumentEquality implements Equality<SizeRecord> {
  const SizeRecordDocumentEquality();

  @override
  bool equals(SizeRecord? e1, SizeRecord? e2) {
    return e1?.size == e2?.size &&
        e1?.price == e2?.price &&
        e1?.coloref == e2?.coloref;
  }

  @override
  int hash(SizeRecord? e) =>
      const ListEquality().hash([e?.size, e?.price, e?.coloref]);

  @override
  bool isValidKey(Object? o) => o is SizeRecord;
}
