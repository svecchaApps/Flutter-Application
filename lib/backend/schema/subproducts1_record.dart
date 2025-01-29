import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class Subproducts1Record extends FirestoreRecord {
  Subproducts1Record._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "productid" field.
  DocumentReference? _productid;
  DocumentReference? get productid => _productid;
  bool hasProductid() => _productid != null;

  // "size" field.
  String? _size;
  String get size => _size ?? '';
  bool hasSize() => _size != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  // "Stock" field.
  int? _stock;
  int get stock => _stock ?? 0;
  bool hasStock() => _stock != null;

  // "productid2" field.
  DocumentReference? _productid2;
  DocumentReference? get productid2 => _productid2;
  bool hasProductid2() => _productid2 != null;

  void _initializeFields() {
    _productid = snapshotData['productid'] as DocumentReference?;
    _size = snapshotData['size'] as String?;
    _price = castToType<double>(snapshotData['price']);
    _stock = castToType<int>(snapshotData['Stock']);
    _productid2 = snapshotData['productid2'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('subproducts1');

  static Stream<Subproducts1Record> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => Subproducts1Record.fromSnapshot(s));

  static Future<Subproducts1Record> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => Subproducts1Record.fromSnapshot(s));

  static Subproducts1Record fromSnapshot(DocumentSnapshot snapshot) =>
      Subproducts1Record._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static Subproducts1Record getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      Subproducts1Record._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'Subproducts1Record(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is Subproducts1Record &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSubproducts1RecordData({
  DocumentReference? productid,
  String? size,
  double? price,
  int? stock,
  DocumentReference? productid2,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'productid': productid,
      'size': size,
      'price': price,
      'Stock': stock,
      'productid2': productid2,
    }.withoutNulls,
  );

  return firestoreData;
}

class Subproducts1RecordDocumentEquality
    implements Equality<Subproducts1Record> {
  const Subproducts1RecordDocumentEquality();

  @override
  bool equals(Subproducts1Record? e1, Subproducts1Record? e2) {
    return e1?.productid == e2?.productid &&
        e1?.size == e2?.size &&
        e1?.price == e2?.price &&
        e1?.stock == e2?.stock &&
        e1?.productid2 == e2?.productid2;
  }

  @override
  int hash(Subproducts1Record? e) => const ListEquality()
      .hash([e?.productid, e?.size, e?.price, e?.stock, e?.productid2]);

  @override
  bool isValidKey(Object? o) => o is Subproducts1Record;
}
