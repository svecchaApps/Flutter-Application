import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PromotionalImageRecord extends FirestoreRecord {
  PromotionalImageRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "Image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "Descprition1" field.
  String? _descprition1;
  String get descprition1 => _descprition1 ?? '';
  bool hasDescprition1() => _descprition1 != null;

  // "Description2" field.
  String? _description2;
  String get description2 => _description2 ?? '';
  bool hasDescription2() => _description2 != null;

  void _initializeFields() {
    _image = snapshotData['Image'] as String?;
    _descprition1 = snapshotData['Descprition1'] as String?;
    _description2 = snapshotData['Description2'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('PromotionalImage');

  static Stream<PromotionalImageRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PromotionalImageRecord.fromSnapshot(s));

  static Future<PromotionalImageRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => PromotionalImageRecord.fromSnapshot(s));

  static PromotionalImageRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PromotionalImageRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PromotionalImageRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PromotionalImageRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PromotionalImageRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PromotionalImageRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPromotionalImageRecordData({
  String? image,
  String? descprition1,
  String? description2,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Image': image,
      'Descprition1': descprition1,
      'Description2': description2,
    }.withoutNulls,
  );

  return firestoreData;
}

class PromotionalImageRecordDocumentEquality
    implements Equality<PromotionalImageRecord> {
  const PromotionalImageRecordDocumentEquality();

  @override
  bool equals(PromotionalImageRecord? e1, PromotionalImageRecord? e2) {
    return e1?.image == e2?.image &&
        e1?.descprition1 == e2?.descprition1 &&
        e1?.description2 == e2?.description2;
  }

  @override
  int hash(PromotionalImageRecord? e) =>
      const ListEquality().hash([e?.image, e?.descprition1, e?.description2]);

  @override
  bool isValidKey(Object? o) => o is PromotionalImageRecord;
}
