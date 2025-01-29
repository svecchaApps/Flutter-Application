import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CouponscodeRecord extends FirestoreRecord {
  CouponscodeRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "Couponcode" field.
  String? _couponcode;
  String get couponcode => _couponcode ?? '';
  bool hasCouponcode() => _couponcode != null;

  // "discountpercentage" field.
  double? _discountpercentage;
  double get discountpercentage => _discountpercentage ?? 0.0;
  bool hasDiscountpercentage() => _discountpercentage != null;

  void _initializeFields() {
    _couponcode = snapshotData['Couponcode'] as String?;
    _discountpercentage =
        castToType<double>(snapshotData['discountpercentage']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('couponscode');

  static Stream<CouponscodeRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CouponscodeRecord.fromSnapshot(s));

  static Future<CouponscodeRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CouponscodeRecord.fromSnapshot(s));

  static CouponscodeRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CouponscodeRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CouponscodeRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CouponscodeRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CouponscodeRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CouponscodeRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCouponscodeRecordData({
  String? couponcode,
  double? discountpercentage,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Couponcode': couponcode,
      'discountpercentage': discountpercentage,
    }.withoutNulls,
  );

  return firestoreData;
}

class CouponscodeRecordDocumentEquality implements Equality<CouponscodeRecord> {
  const CouponscodeRecordDocumentEquality();

  @override
  bool equals(CouponscodeRecord? e1, CouponscodeRecord? e2) {
    return e1?.couponcode == e2?.couponcode &&
        e1?.discountpercentage == e2?.discountpercentage;
  }

  @override
  int hash(CouponscodeRecord? e) =>
      const ListEquality().hash([e?.couponcode, e?.discountpercentage]);

  @override
  bool isValidKey(Object? o) => o is CouponscodeRecord;
}
