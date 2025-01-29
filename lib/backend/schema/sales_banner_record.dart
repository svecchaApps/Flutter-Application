import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SalesBannerRecord extends FirestoreRecord {
  SalesBannerRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "Banner" field.
  String? _banner;
  String get banner => _banner ?? '';
  bool hasBanner() => _banner != null;

  void _initializeFields() {
    _banner = snapshotData['Banner'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('salesBanner');

  static Stream<SalesBannerRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SalesBannerRecord.fromSnapshot(s));

  static Future<SalesBannerRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SalesBannerRecord.fromSnapshot(s));

  static SalesBannerRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SalesBannerRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SalesBannerRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SalesBannerRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SalesBannerRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SalesBannerRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSalesBannerRecordData({
  String? banner,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Banner': banner,
    }.withoutNulls,
  );

  return firestoreData;
}

class SalesBannerRecordDocumentEquality implements Equality<SalesBannerRecord> {
  const SalesBannerRecordDocumentEquality();

  @override
  bool equals(SalesBannerRecord? e1, SalesBannerRecord? e2) {
    return e1?.banner == e2?.banner;
  }

  @override
  int hash(SalesBannerRecord? e) => const ListEquality().hash([e?.banner]);

  @override
  bool isValidKey(Object? o) => o is SalesBannerRecord;
}
