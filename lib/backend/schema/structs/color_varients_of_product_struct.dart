// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ColorVarientsOfProductStruct extends FFFirebaseStruct {
  ColorVarientsOfProductStruct({
    Color? color,
    List<String>? image,
    List<SizeStruct>? size,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _color = color,
        _image = image,
        _size = size,
        super(firestoreUtilData);

  // "Color" field.
  Color? _color;
  Color? get color => _color;
  set color(Color? val) => _color = val;

  bool hasColor() => _color != null;

  // "Image" field.
  List<String>? _image;
  List<String> get image => _image ?? const [];
  set image(List<String>? val) => _image = val;

  void updateImage(Function(List<String>) updateFn) {
    updateFn(_image ??= []);
  }

  bool hasImage() => _image != null;

  // "size" field.
  List<SizeStruct>? _size;
  List<SizeStruct> get size => _size ?? const [];
  set size(List<SizeStruct>? val) => _size = val;

  void updateSize(Function(List<SizeStruct>) updateFn) {
    updateFn(_size ??= []);
  }

  bool hasSize() => _size != null;

  static ColorVarientsOfProductStruct fromMap(Map<String, dynamic> data) =>
      ColorVarientsOfProductStruct(
        color: getSchemaColor(data['Color']),
        image: getDataList(data['Image']),
        size: getStructList(
          data['size'],
          SizeStruct.fromMap,
        ),
      );

  static ColorVarientsOfProductStruct? maybeFromMap(dynamic data) => data is Map
      ? ColorVarientsOfProductStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Color': _color,
        'Image': _image,
        'size': _size?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Color': serializeParam(
          _color,
          ParamType.Color,
        ),
        'Image': serializeParam(
          _image,
          ParamType.String,
          isList: true,
        ),
        'size': serializeParam(
          _size,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static ColorVarientsOfProductStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ColorVarientsOfProductStruct(
        color: deserializeParam(
          data['Color'],
          ParamType.Color,
          false,
        ),
        image: deserializeParam<String>(
          data['Image'],
          ParamType.String,
          true,
        ),
        size: deserializeStructParam<SizeStruct>(
          data['size'],
          ParamType.DataStruct,
          true,
          structBuilder: SizeStruct.fromSerializableMap,
        ),
      );

  static ColorVarientsOfProductStruct fromAlgoliaData(
          Map<String, dynamic> data) =>
      ColorVarientsOfProductStruct(
        color: convertAlgoliaParam(
          data['Color'],
          ParamType.Color,
          false,
        ),
        image: convertAlgoliaParam<String>(
          data['Image'],
          ParamType.String,
          true,
        ),
        size: convertAlgoliaParam<SizeStruct>(
          data['size'],
          ParamType.DataStruct,
          true,
          structBuilder: SizeStruct.fromAlgoliaData,
        ),
        firestoreUtilData: const FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'ColorVarientsOfProductStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ColorVarientsOfProductStruct &&
        color == other.color &&
        listEquality.equals(image, other.image) &&
        listEquality.equals(size, other.size);
  }

  @override
  int get hashCode => const ListEquality().hash([color, image, size]);
}

ColorVarientsOfProductStruct createColorVarientsOfProductStruct({
  Color? color,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ColorVarientsOfProductStruct(
      color: color,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ColorVarientsOfProductStruct? updateColorVarientsOfProductStruct(
  ColorVarientsOfProductStruct? colorVarientsOfProduct, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    colorVarientsOfProduct
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addColorVarientsOfProductStructData(
  Map<String, dynamic> firestoreData,
  ColorVarientsOfProductStruct? colorVarientsOfProduct,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (colorVarientsOfProduct == null) {
    return;
  }
  if (colorVarientsOfProduct.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      colorVarientsOfProduct.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final colorVarientsOfProductData = getColorVarientsOfProductFirestoreData(
      colorVarientsOfProduct, forFieldValue);
  final nestedData =
      colorVarientsOfProductData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      colorVarientsOfProduct.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getColorVarientsOfProductFirestoreData(
  ColorVarientsOfProductStruct? colorVarientsOfProduct, [
  bool forFieldValue = false,
]) {
  if (colorVarientsOfProduct == null) {
    return {};
  }
  final firestoreData = mapToFirestore(colorVarientsOfProduct.toMap());

  // Add any Firestore field values
  colorVarientsOfProduct.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getColorVarientsOfProductListFirestoreData(
  List<ColorVarientsOfProductStruct>? colorVarientsOfProducts,
) =>
    colorVarientsOfProducts
        ?.map((e) => getColorVarientsOfProductFirestoreData(e, true))
        .toList() ??
    [];
