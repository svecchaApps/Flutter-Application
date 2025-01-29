// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RegisterbussinessStruct extends FFFirebaseStruct {
  RegisterbussinessStruct({
    String? name,
    String? username,
    String? email,
    String? password,
    String? companyName,
    String? bussinessesName,
    LatLng? location,
    String? bussinessEstablishmentyear,
    String? descriptionofbussiness,
    List<String>? imageList,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _username = username,
        _email = email,
        _password = password,
        _companyName = companyName,
        _bussinessesName = bussinessesName,
        _location = location,
        _bussinessEstablishmentyear = bussinessEstablishmentyear,
        _descriptionofbussiness = descriptionofbussiness,
        _imageList = imageList,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "username" field.
  String? _username;
  String get username => _username ?? '';
  set username(String? val) => _username = val;

  bool hasUsername() => _username != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  set email(String? val) => _email = val;

  bool hasEmail() => _email != null;

  // "Password" field.
  String? _password;
  String get password => _password ?? '';
  set password(String? val) => _password = val;

  bool hasPassword() => _password != null;

  // "CompanyName" field.
  String? _companyName;
  String get companyName => _companyName ?? '';
  set companyName(String? val) => _companyName = val;

  bool hasCompanyName() => _companyName != null;

  // "BussinessesName" field.
  String? _bussinessesName;
  String get bussinessesName => _bussinessesName ?? '';
  set bussinessesName(String? val) => _bussinessesName = val;

  bool hasBussinessesName() => _bussinessesName != null;

  // "Location" field.
  LatLng? _location;
  LatLng? get location => _location;
  set location(LatLng? val) => _location = val;

  bool hasLocation() => _location != null;

  // "BussinessEstablishmentyear" field.
  String? _bussinessEstablishmentyear;
  String get bussinessEstablishmentyear => _bussinessEstablishmentyear ?? '';
  set bussinessEstablishmentyear(String? val) =>
      _bussinessEstablishmentyear = val;

  bool hasBussinessEstablishmentyear() => _bussinessEstablishmentyear != null;

  // "Descriptionofbussiness" field.
  String? _descriptionofbussiness;
  String get descriptionofbussiness => _descriptionofbussiness ?? '';
  set descriptionofbussiness(String? val) => _descriptionofbussiness = val;

  bool hasDescriptionofbussiness() => _descriptionofbussiness != null;

  // "ImageList" field.
  List<String>? _imageList;
  List<String> get imageList => _imageList ?? const [];
  set imageList(List<String>? val) => _imageList = val;

  void updateImageList(Function(List<String>) updateFn) {
    updateFn(_imageList ??= []);
  }

  bool hasImageList() => _imageList != null;

  static RegisterbussinessStruct fromMap(Map<String, dynamic> data) =>
      RegisterbussinessStruct(
        name: data['name'] as String?,
        username: data['username'] as String?,
        email: data['email'] as String?,
        password: data['Password'] as String?,
        companyName: data['CompanyName'] as String?,
        bussinessesName: data['BussinessesName'] as String?,
        location: data['Location'] as LatLng?,
        bussinessEstablishmentyear:
            data['BussinessEstablishmentyear'] as String?,
        descriptionofbussiness: data['Descriptionofbussiness'] as String?,
        imageList: getDataList(data['ImageList']),
      );

  static RegisterbussinessStruct? maybeFromMap(dynamic data) => data is Map
      ? RegisterbussinessStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'username': _username,
        'email': _email,
        'Password': _password,
        'CompanyName': _companyName,
        'BussinessesName': _bussinessesName,
        'Location': _location,
        'BussinessEstablishmentyear': _bussinessEstablishmentyear,
        'Descriptionofbussiness': _descriptionofbussiness,
        'ImageList': _imageList,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'username': serializeParam(
          _username,
          ParamType.String,
        ),
        'email': serializeParam(
          _email,
          ParamType.String,
        ),
        'Password': serializeParam(
          _password,
          ParamType.String,
        ),
        'CompanyName': serializeParam(
          _companyName,
          ParamType.String,
        ),
        'BussinessesName': serializeParam(
          _bussinessesName,
          ParamType.String,
        ),
        'Location': serializeParam(
          _location,
          ParamType.LatLng,
        ),
        'BussinessEstablishmentyear': serializeParam(
          _bussinessEstablishmentyear,
          ParamType.String,
        ),
        'Descriptionofbussiness': serializeParam(
          _descriptionofbussiness,
          ParamType.String,
        ),
        'ImageList': serializeParam(
          _imageList,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static RegisterbussinessStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      RegisterbussinessStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        username: deserializeParam(
          data['username'],
          ParamType.String,
          false,
        ),
        email: deserializeParam(
          data['email'],
          ParamType.String,
          false,
        ),
        password: deserializeParam(
          data['Password'],
          ParamType.String,
          false,
        ),
        companyName: deserializeParam(
          data['CompanyName'],
          ParamType.String,
          false,
        ),
        bussinessesName: deserializeParam(
          data['BussinessesName'],
          ParamType.String,
          false,
        ),
        location: deserializeParam(
          data['Location'],
          ParamType.LatLng,
          false,
        ),
        bussinessEstablishmentyear: deserializeParam(
          data['BussinessEstablishmentyear'],
          ParamType.String,
          false,
        ),
        descriptionofbussiness: deserializeParam(
          data['Descriptionofbussiness'],
          ParamType.String,
          false,
        ),
        imageList: deserializeParam<String>(
          data['ImageList'],
          ParamType.String,
          true,
        ),
      );

  static RegisterbussinessStruct fromAlgoliaData(Map<String, dynamic> data) =>
      RegisterbussinessStruct(
        name: convertAlgoliaParam(
          data['name'],
          ParamType.String,
          false,
        ),
        username: convertAlgoliaParam(
          data['username'],
          ParamType.String,
          false,
        ),
        email: convertAlgoliaParam(
          data['email'],
          ParamType.String,
          false,
        ),
        password: convertAlgoliaParam(
          data['Password'],
          ParamType.String,
          false,
        ),
        companyName: convertAlgoliaParam(
          data['CompanyName'],
          ParamType.String,
          false,
        ),
        bussinessesName: convertAlgoliaParam(
          data['BussinessesName'],
          ParamType.String,
          false,
        ),
        location: convertAlgoliaParam(
          data,
          ParamType.LatLng,
          false,
        ),
        bussinessEstablishmentyear: convertAlgoliaParam(
          data['BussinessEstablishmentyear'],
          ParamType.String,
          false,
        ),
        descriptionofbussiness: convertAlgoliaParam(
          data['Descriptionofbussiness'],
          ParamType.String,
          false,
        ),
        imageList: convertAlgoliaParam<String>(
          data['ImageList'],
          ParamType.String,
          true,
        ),
        firestoreUtilData: const FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'RegisterbussinessStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is RegisterbussinessStruct &&
        name == other.name &&
        username == other.username &&
        email == other.email &&
        password == other.password &&
        companyName == other.companyName &&
        bussinessesName == other.bussinessesName &&
        location == other.location &&
        bussinessEstablishmentyear == other.bussinessEstablishmentyear &&
        descriptionofbussiness == other.descriptionofbussiness &&
        listEquality.equals(imageList, other.imageList);
  }

  @override
  int get hashCode => const ListEquality().hash([
        name,
        username,
        email,
        password,
        companyName,
        bussinessesName,
        location,
        bussinessEstablishmentyear,
        descriptionofbussiness,
        imageList
      ]);
}

RegisterbussinessStruct createRegisterbussinessStruct({
  String? name,
  String? username,
  String? email,
  String? password,
  String? companyName,
  String? bussinessesName,
  LatLng? location,
  String? bussinessEstablishmentyear,
  String? descriptionofbussiness,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RegisterbussinessStruct(
      name: name,
      username: username,
      email: email,
      password: password,
      companyName: companyName,
      bussinessesName: bussinessesName,
      location: location,
      bussinessEstablishmentyear: bussinessEstablishmentyear,
      descriptionofbussiness: descriptionofbussiness,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RegisterbussinessStruct? updateRegisterbussinessStruct(
  RegisterbussinessStruct? registerbussiness, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    registerbussiness
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRegisterbussinessStructData(
  Map<String, dynamic> firestoreData,
  RegisterbussinessStruct? registerbussiness,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (registerbussiness == null) {
    return;
  }
  if (registerbussiness.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && registerbussiness.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final registerbussinessData =
      getRegisterbussinessFirestoreData(registerbussiness, forFieldValue);
  final nestedData =
      registerbussinessData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = registerbussiness.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRegisterbussinessFirestoreData(
  RegisterbussinessStruct? registerbussiness, [
  bool forFieldValue = false,
]) {
  if (registerbussiness == null) {
    return {};
  }
  final firestoreData = mapToFirestore(registerbussiness.toMap());

  // Add any Firestore field values
  registerbussiness.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRegisterbussinessListFirestoreData(
  List<RegisterbussinessStruct>? registerbussinesss,
) =>
    registerbussinesss
        ?.map((e) => getRegisterbussinessFirestoreData(e, true))
        .toList() ??
    [];
