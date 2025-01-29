// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class AddressesStruct extends FFFirebaseStruct {
  AddressesStruct({
    String? area,
    String? exactLocation,
    String? city,
    String? pincode,
    String? state,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _area = area,
        _exactLocation = exactLocation,
        _city = city,
        _pincode = pincode,
        _state = state,
        super(firestoreUtilData);

  // "Area" field.
  String? _area;
  String get area => _area ?? '';
  set area(String? val) => _area = val;

  bool hasArea() => _area != null;

  // "ExactLocation" field.
  String? _exactLocation;
  String get exactLocation => _exactLocation ?? '';
  set exactLocation(String? val) => _exactLocation = val;

  bool hasExactLocation() => _exactLocation != null;

  // "City" field.
  String? _city;
  String get city => _city ?? '';
  set city(String? val) => _city = val;

  bool hasCity() => _city != null;

  // "Pincode" field.
  String? _pincode;
  String get pincode => _pincode ?? '';
  set pincode(String? val) => _pincode = val;

  bool hasPincode() => _pincode != null;

  // "State" field.
  String? _state;
  String get state => _state ?? '';
  set state(String? val) => _state = val;

  bool hasState() => _state != null;

  static AddressesStruct fromMap(Map<String, dynamic> data) => AddressesStruct(
        area: data['Area'] as String?,
        exactLocation: data['ExactLocation'] as String?,
        city: data['City'] as String?,
        pincode: data['Pincode'] as String?,
        state: data['State'] as String?,
      );

  static AddressesStruct? maybeFromMap(dynamic data) => data is Map
      ? AddressesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Area': _area,
        'ExactLocation': _exactLocation,
        'City': _city,
        'Pincode': _pincode,
        'State': _state,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Area': serializeParam(
          _area,
          ParamType.String,
        ),
        'ExactLocation': serializeParam(
          _exactLocation,
          ParamType.String,
        ),
        'City': serializeParam(
          _city,
          ParamType.String,
        ),
        'Pincode': serializeParam(
          _pincode,
          ParamType.String,
        ),
        'State': serializeParam(
          _state,
          ParamType.String,
        ),
      }.withoutNulls;

  static AddressesStruct fromSerializableMap(Map<String, dynamic> data) =>
      AddressesStruct(
        area: deserializeParam(
          data['Area'],
          ParamType.String,
          false,
        ),
        exactLocation: deserializeParam(
          data['ExactLocation'],
          ParamType.String,
          false,
        ),
        city: deserializeParam(
          data['City'],
          ParamType.String,
          false,
        ),
        pincode: deserializeParam(
          data['Pincode'],
          ParamType.String,
          false,
        ),
        state: deserializeParam(
          data['State'],
          ParamType.String,
          false,
        ),
      );

  static AddressesStruct fromAlgoliaData(Map<String, dynamic> data) =>
      AddressesStruct(
        area: convertAlgoliaParam(
          data['Area'],
          ParamType.String,
          false,
        ),
        exactLocation: convertAlgoliaParam(
          data['ExactLocation'],
          ParamType.String,
          false,
        ),
        city: convertAlgoliaParam(
          data['City'],
          ParamType.String,
          false,
        ),
        pincode: convertAlgoliaParam(
          data['Pincode'],
          ParamType.String,
          false,
        ),
        state: convertAlgoliaParam(
          data['State'],
          ParamType.String,
          false,
        ),
        firestoreUtilData: const FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'AddressesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AddressesStruct &&
        area == other.area &&
        exactLocation == other.exactLocation &&
        city == other.city &&
        pincode == other.pincode &&
        state == other.state;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([area, exactLocation, city, pincode, state]);
}

AddressesStruct createAddressesStruct({
  String? area,
  String? exactLocation,
  String? city,
  String? pincode,
  String? state,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    AddressesStruct(
      area: area,
      exactLocation: exactLocation,
      city: city,
      pincode: pincode,
      state: state,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

AddressesStruct? updateAddressesStruct(
  AddressesStruct? addresses, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    addresses
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addAddressesStructData(
  Map<String, dynamic> firestoreData,
  AddressesStruct? addresses,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (addresses == null) {
    return;
  }
  if (addresses.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && addresses.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final addressesData = getAddressesFirestoreData(addresses, forFieldValue);
  final nestedData = addressesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = addresses.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getAddressesFirestoreData(
  AddressesStruct? addresses, [
  bool forFieldValue = false,
]) {
  if (addresses == null) {
    return {};
  }
  final firestoreData = mapToFirestore(addresses.toMap());

  // Add any Firestore field values
  addresses.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getAddressesListFirestoreData(
  List<AddressesStruct>? addressess,
) =>
    addressess?.map((e) => getAddressesFirestoreData(e, true)).toList() ?? [];
