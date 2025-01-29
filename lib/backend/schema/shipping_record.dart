import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ShippingRecord extends FirestoreRecord {
  ShippingRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "shippingpolicy" field.
  String? _shippingpolicy;
  String get shippingpolicy => _shippingpolicy ?? '';
  bool hasShippingpolicy() => _shippingpolicy != null;

  void _initializeFields() {
    _shippingpolicy = snapshotData['shippingpolicy'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('shipping');

  static Stream<ShippingRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ShippingRecord.fromSnapshot(s));

  static Future<ShippingRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ShippingRecord.fromSnapshot(s));

  static ShippingRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ShippingRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ShippingRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ShippingRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ShippingRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ShippingRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createShippingRecordData({
  String? shippingpolicy,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'shippingpolicy': shippingpolicy,
    }.withoutNulls,
  );

  return firestoreData;
}

class ShippingRecordDocumentEquality implements Equality<ShippingRecord> {
  const ShippingRecordDocumentEquality();

  @override
  bool equals(ShippingRecord? e1, ShippingRecord? e2) {
    return e1?.shippingpolicy == e2?.shippingpolicy;
  }

  @override
  int hash(ShippingRecord? e) => const ListEquality().hash([e?.shippingpolicy]);

  @override
  bool isValidKey(Object? o) => o is ShippingRecord;
}
