import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FlashBannersRecord extends FirestoreRecord {
  FlashBannersRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "Flah_url_image" field.
  String? _flahUrlImage;
  String get flahUrlImage => _flahUrlImage ?? '';
  bool hasFlahUrlImage() => _flahUrlImage != null;

  void _initializeFields() {
    _flahUrlImage = snapshotData['Flah_url_image'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Flash_Banners');

  static Stream<FlashBannersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => FlashBannersRecord.fromSnapshot(s));

  static Future<FlashBannersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => FlashBannersRecord.fromSnapshot(s));

  static FlashBannersRecord fromSnapshot(DocumentSnapshot snapshot) =>
      FlashBannersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FlashBannersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FlashBannersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FlashBannersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FlashBannersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createFlashBannersRecordData({
  String? flahUrlImage,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Flah_url_image': flahUrlImage,
    }.withoutNulls,
  );

  return firestoreData;
}

class FlashBannersRecordDocumentEquality
    implements Equality<FlashBannersRecord> {
  const FlashBannersRecordDocumentEquality();

  @override
  bool equals(FlashBannersRecord? e1, FlashBannersRecord? e2) {
    return e1?.flahUrlImage == e2?.flahUrlImage;
  }

  @override
  int hash(FlashBannersRecord? e) =>
      const ListEquality().hash([e?.flahUrlImage]);

  @override
  bool isValidKey(Object? o) => o is FlashBannersRecord;
}
