import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ColoroptionsRecord extends FirestoreRecord {
  ColoroptionsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "imagelist" field.
  List<String>? _imagelist;
  List<String> get imagelist => _imagelist ?? const [];
  bool hasImagelist() => _imagelist != null;

  // "Productref" field.
  DocumentReference? _productref;
  DocumentReference? get productref => _productref;
  bool hasProductref() => _productref != null;

  // "color" field.
  Color? _color;
  Color? get color => _color;
  bool hasColor() => _color != null;

  // "sizeref" field.
  DocumentReference? _sizeref;
  DocumentReference? get sizeref => _sizeref;
  bool hasSizeref() => _sizeref != null;

  void _initializeFields() {
    _imagelist = getDataList(snapshotData['imagelist']);
    _productref = snapshotData['Productref'] as DocumentReference?;
    _color = getSchemaColor(snapshotData['color']);
    _sizeref = snapshotData['sizeref'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Coloroptions');

  static Stream<ColoroptionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ColoroptionsRecord.fromSnapshot(s));

  static Future<ColoroptionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ColoroptionsRecord.fromSnapshot(s));

  static ColoroptionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ColoroptionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ColoroptionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ColoroptionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ColoroptionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ColoroptionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createColoroptionsRecordData({
  DocumentReference? productref,
  Color? color,
  DocumentReference? sizeref,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Productref': productref,
      'color': color,
      'sizeref': sizeref,
    }.withoutNulls,
  );

  return firestoreData;
}

class ColoroptionsRecordDocumentEquality
    implements Equality<ColoroptionsRecord> {
  const ColoroptionsRecordDocumentEquality();

  @override
  bool equals(ColoroptionsRecord? e1, ColoroptionsRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.imagelist, e2?.imagelist) &&
        e1?.productref == e2?.productref &&
        e1?.color == e2?.color &&
        e1?.sizeref == e2?.sizeref;
  }

  @override
  int hash(ColoroptionsRecord? e) => const ListEquality()
      .hash([e?.imagelist, e?.productref, e?.color, e?.sizeref]);

  @override
  bool isValidKey(Object? o) => o is ColoroptionsRecord;
}
