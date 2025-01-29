import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DesignerRecord extends FirestoreRecord {
  DesignerRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "logo_url" field.
  String? _logoUrl;
  String get logoUrl => _logoUrl ?? '';
  bool hasLogoUrl() => _logoUrl != null;

  // "background" field.
  String? _background;
  String get background => _background ?? '';
  bool hasBackground() => _background != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "address" field.
  String? _address;
  String get address => _address ?? '';
  bool hasAddress() => _address != null;

  // "is_approved" field.
  bool? _isApproved;
  bool get isApproved => _isApproved ?? false;
  bool hasIsApproved() => _isApproved != null;

  // "user_id" field.
  DocumentReference? _userId;
  DocumentReference? get userId => _userId;
  bool hasUserId() => _userId != null;

  // "short_description" field.
  String? _shortDescription;
  String get shortDescription => _shortDescription ?? '';
  bool hasShortDescription() => _shortDescription != null;

  // "deesignerLocationimage" field.
  String? _deesignerLocationimage;
  String get deesignerLocationimage => _deesignerLocationimage ?? '';
  bool hasDeesignerLocationimage() => _deesignerLocationimage != null;

  // "desigbanner1" field.
  String? _desigbanner1;
  String get desigbanner1 => _desigbanner1 ?? '';
  bool hasDesigbanner1() => _desigbanner1 != null;

  // "caraousel_images" field.
  List<String>? _caraouselImages;
  List<String> get caraouselImages => _caraouselImages ?? const [];
  bool hasCaraouselImages() => _caraouselImages != null;

  // "exclusive" field.
  bool? _exclusive;
  bool get exclusive => _exclusive ?? false;
  bool hasExclusive() => _exclusive != null;

  // "isBrand" field.
  bool? _isBrand;
  bool get isBrand => _isBrand ?? false;
  bool hasIsBrand() => _isBrand != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _logoUrl = snapshotData['logo_url'] as String?;
    _background = snapshotData['background'] as String?;
    _description = snapshotData['description'] as String?;
    _email = snapshotData['email'] as String?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _address = snapshotData['address'] as String?;
    _isApproved = snapshotData['is_approved'] as bool?;
    _userId = snapshotData['user_id'] as DocumentReference?;
    _shortDescription = snapshotData['short_description'] as String?;
    _deesignerLocationimage = snapshotData['deesignerLocationimage'] as String?;
    _desigbanner1 = snapshotData['desigbanner1'] as String?;
    _caraouselImages = getDataList(snapshotData['caraousel_images']);
    _exclusive = snapshotData['exclusive'] as bool?;
    _isBrand = snapshotData['isBrand'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Designer');

  static Stream<DesignerRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DesignerRecord.fromSnapshot(s));

  static Future<DesignerRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DesignerRecord.fromSnapshot(s));

  static DesignerRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DesignerRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DesignerRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DesignerRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DesignerRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DesignerRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDesignerRecordData({
  String? name,
  String? logoUrl,
  String? background,
  String? description,
  String? email,
  String? phoneNumber,
  String? address,
  bool? isApproved,
  DocumentReference? userId,
  String? shortDescription,
  String? deesignerLocationimage,
  String? desigbanner1,
  bool? exclusive,
  bool? isBrand,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'logo_url': logoUrl,
      'background': background,
      'description': description,
      'email': email,
      'phone_number': phoneNumber,
      'address': address,
      'is_approved': isApproved,
      'user_id': userId,
      'short_description': shortDescription,
      'deesignerLocationimage': deesignerLocationimage,
      'desigbanner1': desigbanner1,
      'exclusive': exclusive,
      'isBrand': isBrand,
    }.withoutNulls,
  );

  return firestoreData;
}

class DesignerRecordDocumentEquality implements Equality<DesignerRecord> {
  const DesignerRecordDocumentEquality();

  @override
  bool equals(DesignerRecord? e1, DesignerRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        e1?.logoUrl == e2?.logoUrl &&
        e1?.background == e2?.background &&
        e1?.description == e2?.description &&
        e1?.email == e2?.email &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.address == e2?.address &&
        e1?.isApproved == e2?.isApproved &&
        e1?.userId == e2?.userId &&
        e1?.shortDescription == e2?.shortDescription &&
        e1?.deesignerLocationimage == e2?.deesignerLocationimage &&
        e1?.desigbanner1 == e2?.desigbanner1 &&
        listEquality.equals(e1?.caraouselImages, e2?.caraouselImages) &&
        e1?.exclusive == e2?.exclusive &&
        e1?.isBrand == e2?.isBrand;
  }

  @override
  int hash(DesignerRecord? e) => const ListEquality().hash([
        e?.name,
        e?.logoUrl,
        e?.background,
        e?.description,
        e?.email,
        e?.phoneNumber,
        e?.address,
        e?.isApproved,
        e?.userId,
        e?.shortDescription,
        e?.deesignerLocationimage,
        e?.desigbanner1,
        e?.caraouselImages,
        e?.exclusive,
        e?.isBrand
      ]);

  @override
  bool isValidKey(Object? o) => o is DesignerRecord;
}
