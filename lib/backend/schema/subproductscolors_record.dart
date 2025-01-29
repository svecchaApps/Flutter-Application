import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SubproductscolorsRecord extends FirestoreRecord {
  SubproductscolorsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "catref" field.
  DocumentReference? _catref;
  DocumentReference? get catref => _catref;
  bool hasCatref() => _catref != null;

  // "Productname" field.
  String? _productname;
  String get productname => _productname ?? '';
  bool hasProductname() => _productname != null;

  // "MRP" field.
  double? _mrp;
  double get mrp => _mrp ?? 0.0;
  bool hasMrp() => _mrp != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "Image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "size" field.
  String? _size;
  String get size => _size ?? '';
  bool hasSize() => _size != null;

  // "Imagelist" field.
  List<String>? _imagelist;
  List<String> get imagelist => _imagelist ?? const [];
  bool hasImagelist() => _imagelist != null;

  // "isfav" field.
  bool? _isfav;
  bool get isfav => _isfav ?? false;
  bool hasIsfav() => _isfav != null;

  // "spotlight_on" field.
  bool? _spotlightOn;
  bool get spotlightOn => _spotlightOn ?? false;
  bool hasSpotlightOn() => _spotlightOn != null;

  // "On_sale" field.
  bool? _onSale;
  bool get onSale => _onSale ?? false;
  bool hasOnSale() => _onSale != null;

  // "sal_percentage" field.
  double? _salPercentage;
  double get salPercentage => _salPercentage ?? 0.0;
  bool hasSalPercentage() => _salPercentage != null;

  // "subcategoryref1" field.
  DocumentReference? _subcategoryref1;
  DocumentReference? get subcategoryref1 => _subcategoryref1;
  bool hasSubcategoryref1() => _subcategoryref1 != null;

  // "designerref1" field.
  DocumentReference? _designerref1;
  DocumentReference? get designerref1 => _designerref1;
  bool hasDesignerref1() => _designerref1 != null;

  // "customizable" field.
  String? _customizable;
  String get customizable => _customizable ?? '';
  bool hasCustomizable() => _customizable != null;

  // "materialandcare" field.
  String? _materialandcare;
  String get materialandcare => _materialandcare ?? '';
  bool hasMaterialandcare() => _materialandcare != null;

  // "sizefit" field.
  String? _sizefit;
  String get sizefit => _sizefit ?? '';
  bool hasSizefit() => _sizefit != null;

  // "productdetails" field.
  String? _productdetails;
  String get productdetails => _productdetails ?? '';
  bool hasProductdetails() => _productdetails != null;

  // "fit" field.
  String? _fit;
  String get fit => _fit ?? '';
  bool hasFit() => _fit != null;

  // "fabric" field.
  String? _fabric;
  String get fabric => _fabric ?? '';
  bool hasFabric() => _fabric != null;

  // "Sustainable" field.
  bool? _sustainable;
  bool get sustainable => _sustainable ?? false;
  bool hasSustainable() => _sustainable != null;

  // "sku" field.
  String? _sku;
  String get sku => _sku ?? '';
  bool hasSku() => _sku != null;

  // "color" field.
  String? _color;
  String get color => _color ?? '';
  bool hasColor() => _color != null;

  // "Gender" field.
  String? _gender;
  String get gender => _gender ?? '';
  bool hasGender() => _gender != null;

  // "stock" field.
  int? _stock;
  int get stock => _stock ?? 0;
  bool hasStock() => _stock != null;

  void _initializeFields() {
    _catref = snapshotData['catref'] as DocumentReference?;
    _productname = snapshotData['Productname'] as String?;
    _mrp = castToType<double>(snapshotData['MRP']);
    _description = snapshotData['description'] as String?;
    _image = snapshotData['Image'] as String?;
    _size = snapshotData['size'] as String?;
    _imagelist = getDataList(snapshotData['Imagelist']);
    _isfav = snapshotData['isfav'] as bool?;
    _spotlightOn = snapshotData['spotlight_on'] as bool?;
    _onSale = snapshotData['On_sale'] as bool?;
    _salPercentage = castToType<double>(snapshotData['sal_percentage']);
    _subcategoryref1 = snapshotData['subcategoryref1'] as DocumentReference?;
    _designerref1 = snapshotData['designerref1'] as DocumentReference?;
    _customizable = snapshotData['customizable'] as String?;
    _materialandcare = snapshotData['materialandcare'] as String?;
    _sizefit = snapshotData['sizefit'] as String?;
    _productdetails = snapshotData['productdetails'] as String?;
    _fit = snapshotData['fit'] as String?;
    _fabric = snapshotData['fabric'] as String?;
    _sustainable = snapshotData['Sustainable'] as bool?;
    _sku = snapshotData['sku'] as String?;
    _color = snapshotData['color'] as String?;
    _gender = snapshotData['Gender'] as String?;
    _stock = castToType<int>(snapshotData['stock']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('subproductscolors');

  static Stream<SubproductscolorsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SubproductscolorsRecord.fromSnapshot(s));

  static Future<SubproductscolorsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => SubproductscolorsRecord.fromSnapshot(s));

  static SubproductscolorsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SubproductscolorsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SubproductscolorsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SubproductscolorsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SubproductscolorsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SubproductscolorsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSubproductscolorsRecordData({
  DocumentReference? catref,
  String? productname,
  double? mrp,
  String? description,
  String? image,
  String? size,
  bool? isfav,
  bool? spotlightOn,
  bool? onSale,
  double? salPercentage,
  DocumentReference? subcategoryref1,
  DocumentReference? designerref1,
  String? customizable,
  String? materialandcare,
  String? sizefit,
  String? productdetails,
  String? fit,
  String? fabric,
  bool? sustainable,
  String? sku,
  String? color,
  String? gender,
  int? stock,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'catref': catref,
      'Productname': productname,
      'MRP': mrp,
      'description': description,
      'Image': image,
      'size': size,
      'isfav': isfav,
      'spotlight_on': spotlightOn,
      'On_sale': onSale,
      'sal_percentage': salPercentage,
      'subcategoryref1': subcategoryref1,
      'designerref1': designerref1,
      'customizable': customizable,
      'materialandcare': materialandcare,
      'sizefit': sizefit,
      'productdetails': productdetails,
      'fit': fit,
      'fabric': fabric,
      'Sustainable': sustainable,
      'sku': sku,
      'color': color,
      'Gender': gender,
      'stock': stock,
    }.withoutNulls,
  );

  return firestoreData;
}

class SubproductscolorsRecordDocumentEquality
    implements Equality<SubproductscolorsRecord> {
  const SubproductscolorsRecordDocumentEquality();

  @override
  bool equals(SubproductscolorsRecord? e1, SubproductscolorsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.catref == e2?.catref &&
        e1?.productname == e2?.productname &&
        e1?.mrp == e2?.mrp &&
        e1?.description == e2?.description &&
        e1?.image == e2?.image &&
        e1?.size == e2?.size &&
        listEquality.equals(e1?.imagelist, e2?.imagelist) &&
        e1?.isfav == e2?.isfav &&
        e1?.spotlightOn == e2?.spotlightOn &&
        e1?.onSale == e2?.onSale &&
        e1?.salPercentage == e2?.salPercentage &&
        e1?.subcategoryref1 == e2?.subcategoryref1 &&
        e1?.designerref1 == e2?.designerref1 &&
        e1?.customizable == e2?.customizable &&
        e1?.materialandcare == e2?.materialandcare &&
        e1?.sizefit == e2?.sizefit &&
        e1?.productdetails == e2?.productdetails &&
        e1?.fit == e2?.fit &&
        e1?.fabric == e2?.fabric &&
        e1?.sustainable == e2?.sustainable &&
        e1?.sku == e2?.sku &&
        e1?.color == e2?.color &&
        e1?.gender == e2?.gender &&
        e1?.stock == e2?.stock;
  }

  @override
  int hash(SubproductscolorsRecord? e) => const ListEquality().hash([
        e?.catref,
        e?.productname,
        e?.mrp,
        e?.description,
        e?.image,
        e?.size,
        e?.imagelist,
        e?.isfav,
        e?.spotlightOn,
        e?.onSale,
        e?.salPercentage,
        e?.subcategoryref1,
        e?.designerref1,
        e?.customizable,
        e?.materialandcare,
        e?.sizefit,
        e?.productdetails,
        e?.fit,
        e?.fabric,
        e?.sustainable,
        e?.sku,
        e?.color,
        e?.gender,
        e?.stock
      ]);

  @override
  bool isValidKey(Object? o) => o is SubproductscolorsRecord;
}
