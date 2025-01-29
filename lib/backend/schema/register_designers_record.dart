import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RegisterDesignersRecord extends FirestoreRecord {
  RegisterDesignersRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "Username" field.
  String? _username;
  String get username => _username ?? '';
  bool hasUsername() => _username != null;

  // "emailid" field.
  String? _emailid;
  String get emailid => _emailid ?? '';
  bool hasEmailid() => _emailid != null;

  // "password" field.
  String? _password;
  String get password => _password ?? '';
  bool hasPassword() => _password != null;

  // "CompanyName" field.
  String? _companyName;
  String get companyName => _companyName ?? '';
  bool hasCompanyName() => _companyName != null;

  // "BussinessName" field.
  String? _bussinessName;
  String get bussinessName => _bussinessName ?? '';
  bool hasBussinessName() => _bussinessName != null;

  // "Location" field.
  LatLng? _location;
  LatLng? get location => _location;
  bool hasLocation() => _location != null;

  // "BussinessEstablishmentYear" field.
  String? _bussinessEstablishmentYear;
  String get bussinessEstablishmentYear => _bussinessEstablishmentYear ?? '';
  bool hasBussinessEstablishmentYear() => _bussinessEstablishmentYear != null;

  // "Description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "imageListOfBussinesses" field.
  List<String>? _imageListOfBussinesses;
  List<String> get imageListOfBussinesses =>
      _imageListOfBussinesses ?? const [];
  bool hasImageListOfBussinesses() => _imageListOfBussinesses != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _username = snapshotData['Username'] as String?;
    _emailid = snapshotData['emailid'] as String?;
    _password = snapshotData['password'] as String?;
    _companyName = snapshotData['CompanyName'] as String?;
    _bussinessName = snapshotData['BussinessName'] as String?;
    _location = snapshotData['Location'] as LatLng?;
    _bussinessEstablishmentYear =
        snapshotData['BussinessEstablishmentYear'] as String?;
    _description = snapshotData['Description'] as String?;
    _imageListOfBussinesses =
        getDataList(snapshotData['imageListOfBussinesses']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('RegisterDesigners');

  static Stream<RegisterDesignersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RegisterDesignersRecord.fromSnapshot(s));

  static Future<RegisterDesignersRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => RegisterDesignersRecord.fromSnapshot(s));

  static RegisterDesignersRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RegisterDesignersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RegisterDesignersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RegisterDesignersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RegisterDesignersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RegisterDesignersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRegisterDesignersRecordData({
  String? name,
  String? username,
  String? emailid,
  String? password,
  String? companyName,
  String? bussinessName,
  LatLng? location,
  String? bussinessEstablishmentYear,
  String? description,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'Username': username,
      'emailid': emailid,
      'password': password,
      'CompanyName': companyName,
      'BussinessName': bussinessName,
      'Location': location,
      'BussinessEstablishmentYear': bussinessEstablishmentYear,
      'Description': description,
    }.withoutNulls,
  );

  return firestoreData;
}

class RegisterDesignersRecordDocumentEquality
    implements Equality<RegisterDesignersRecord> {
  const RegisterDesignersRecordDocumentEquality();

  @override
  bool equals(RegisterDesignersRecord? e1, RegisterDesignersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        e1?.username == e2?.username &&
        e1?.emailid == e2?.emailid &&
        e1?.password == e2?.password &&
        e1?.companyName == e2?.companyName &&
        e1?.bussinessName == e2?.bussinessName &&
        e1?.location == e2?.location &&
        e1?.bussinessEstablishmentYear == e2?.bussinessEstablishmentYear &&
        e1?.description == e2?.description &&
        listEquality.equals(
            e1?.imageListOfBussinesses, e2?.imageListOfBussinesses);
  }

  @override
  int hash(RegisterDesignersRecord? e) => const ListEquality().hash([
        e?.name,
        e?.username,
        e?.emailid,
        e?.password,
        e?.companyName,
        e?.bussinessName,
        e?.location,
        e?.bussinessEstablishmentYear,
        e?.description,
        e?.imageListOfBussinesses
      ]);

  @override
  bool isValidKey(Object? o) => o is RegisterDesignersRecord;
}
