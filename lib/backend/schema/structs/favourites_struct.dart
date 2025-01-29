// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class FavouritesStruct extends FFFirebaseStruct {
  FavouritesStruct({
    double? price,
    String? productname,
    int? quantity,
    String? image,
    String? size,
    double? total,
    String? finalamounttopay,
    bool? isFav,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _price = price,
        _productname = productname,
        _quantity = quantity,
        _image = image,
        _size = size,
        _total = total,
        _finalamounttopay = finalamounttopay,
        _isFav = isFav,
        super(firestoreUtilData);

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  set price(double? val) => _price = val;

  void incrementPrice(double amount) => price = price + amount;

  bool hasPrice() => _price != null;

  // "productname" field.
  String? _productname;
  String get productname => _productname ?? '';
  set productname(String? val) => _productname = val;

  bool hasProductname() => _productname != null;

  // "quantity" field.
  int? _quantity;
  int get quantity => _quantity ?? 0;
  set quantity(int? val) => _quantity = val;

  void incrementQuantity(int amount) => quantity = quantity + amount;

  bool hasQuantity() => _quantity != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  set image(String? val) => _image = val;

  bool hasImage() => _image != null;

  // "size" field.
  String? _size;
  String get size => _size ?? '';
  set size(String? val) => _size = val;

  bool hasSize() => _size != null;

  // "total" field.
  double? _total;
  double get total => _total ?? 0.0;
  set total(double? val) => _total = val;

  void incrementTotal(double amount) => total = total + amount;

  bool hasTotal() => _total != null;

  // "finalamounttopay" field.
  String? _finalamounttopay;
  String get finalamounttopay => _finalamounttopay ?? '';
  set finalamounttopay(String? val) => _finalamounttopay = val;

  bool hasFinalamounttopay() => _finalamounttopay != null;

  // "is_fav" field.
  bool? _isFav;
  bool get isFav => _isFav ?? false;
  set isFav(bool? val) => _isFav = val;

  bool hasIsFav() => _isFav != null;

  static FavouritesStruct fromMap(Map<String, dynamic> data) =>
      FavouritesStruct(
        price: castToType<double>(data['price']),
        productname: data['productname'] as String?,
        quantity: castToType<int>(data['quantity']),
        image: data['image'] as String?,
        size: data['size'] as String?,
        total: castToType<double>(data['total']),
        finalamounttopay: data['finalamounttopay'] as String?,
        isFav: data['is_fav'] as bool?,
      );

  static FavouritesStruct? maybeFromMap(dynamic data) => data is Map
      ? FavouritesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'price': _price,
        'productname': _productname,
        'quantity': _quantity,
        'image': _image,
        'size': _size,
        'total': _total,
        'finalamounttopay': _finalamounttopay,
        'is_fav': _isFav,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'price': serializeParam(
          _price,
          ParamType.double,
        ),
        'productname': serializeParam(
          _productname,
          ParamType.String,
        ),
        'quantity': serializeParam(
          _quantity,
          ParamType.int,
        ),
        'image': serializeParam(
          _image,
          ParamType.String,
        ),
        'size': serializeParam(
          _size,
          ParamType.String,
        ),
        'total': serializeParam(
          _total,
          ParamType.double,
        ),
        'finalamounttopay': serializeParam(
          _finalamounttopay,
          ParamType.String,
        ),
        'is_fav': serializeParam(
          _isFav,
          ParamType.bool,
        ),
      }.withoutNulls;

  static FavouritesStruct fromSerializableMap(Map<String, dynamic> data) =>
      FavouritesStruct(
        price: deserializeParam(
          data['price'],
          ParamType.double,
          false,
        ),
        productname: deserializeParam(
          data['productname'],
          ParamType.String,
          false,
        ),
        quantity: deserializeParam(
          data['quantity'],
          ParamType.int,
          false,
        ),
        image: deserializeParam(
          data['image'],
          ParamType.String,
          false,
        ),
        size: deserializeParam(
          data['size'],
          ParamType.String,
          false,
        ),
        total: deserializeParam(
          data['total'],
          ParamType.double,
          false,
        ),
        finalamounttopay: deserializeParam(
          data['finalamounttopay'],
          ParamType.String,
          false,
        ),
        isFav: deserializeParam(
          data['is_fav'],
          ParamType.bool,
          false,
        ),
      );

  static FavouritesStruct fromAlgoliaData(Map<String, dynamic> data) =>
      FavouritesStruct(
        price: convertAlgoliaParam(
          data['price'],
          ParamType.double,
          false,
        ),
        productname: convertAlgoliaParam(
          data['productname'],
          ParamType.String,
          false,
        ),
        quantity: convertAlgoliaParam(
          data['quantity'],
          ParamType.int,
          false,
        ),
        image: convertAlgoliaParam(
          data['image'],
          ParamType.String,
          false,
        ),
        size: convertAlgoliaParam(
          data['size'],
          ParamType.String,
          false,
        ),
        total: convertAlgoliaParam(
          data['total'],
          ParamType.double,
          false,
        ),
        finalamounttopay: convertAlgoliaParam(
          data['finalamounttopay'],
          ParamType.String,
          false,
        ),
        isFav: convertAlgoliaParam(
          data['is_fav'],
          ParamType.bool,
          false,
        ),
        firestoreUtilData: const FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'FavouritesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FavouritesStruct &&
        price == other.price &&
        productname == other.productname &&
        quantity == other.quantity &&
        image == other.image &&
        size == other.size &&
        total == other.total &&
        finalamounttopay == other.finalamounttopay &&
        isFav == other.isFav;
  }

  @override
  int get hashCode => const ListEquality().hash([
        price,
        productname,
        quantity,
        image,
        size,
        total,
        finalamounttopay,
        isFav
      ]);
}

FavouritesStruct createFavouritesStruct({
  double? price,
  String? productname,
  int? quantity,
  String? image,
  String? size,
  double? total,
  String? finalamounttopay,
  bool? isFav,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FavouritesStruct(
      price: price,
      productname: productname,
      quantity: quantity,
      image: image,
      size: size,
      total: total,
      finalamounttopay: finalamounttopay,
      isFav: isFav,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FavouritesStruct? updateFavouritesStruct(
  FavouritesStruct? favourites, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    favourites
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFavouritesStructData(
  Map<String, dynamic> firestoreData,
  FavouritesStruct? favourites,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (favourites == null) {
    return;
  }
  if (favourites.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && favourites.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final favouritesData = getFavouritesFirestoreData(favourites, forFieldValue);
  final nestedData = favouritesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = favourites.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFavouritesFirestoreData(
  FavouritesStruct? favourites, [
  bool forFieldValue = false,
]) {
  if (favourites == null) {
    return {};
  }
  final firestoreData = mapToFirestore(favourites.toMap());

  // Add any Firestore field values
  favourites.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFavouritesListFirestoreData(
  List<FavouritesStruct>? favouritess,
) =>
    favouritess?.map((e) => getFavouritesFirestoreData(e, true)).toList() ?? [];
