import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InvoiceShipmentIdRecord extends FirestoreRecord {
  InvoiceShipmentIdRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "order_ref" field.
  DocumentReference? _orderRef;
  DocumentReference? get orderRef => _orderRef;
  bool hasOrderRef() => _orderRef != null;

  // "designer_ref" field.
  DocumentReference? _designerRef;
  DocumentReference? get designerRef => _designerRef;
  bool hasDesignerRef() => _designerRef != null;

  // "shipment_id" field.
  String? _shipmentId;
  String get shipmentId => _shipmentId ?? '';
  bool hasShipmentId() => _shipmentId != null;

  void _initializeFields() {
    _orderRef = snapshotData['order_ref'] as DocumentReference?;
    _designerRef = snapshotData['designer_ref'] as DocumentReference?;
    _shipmentId = snapshotData['shipment_id'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('invoice_shipment_id');

  static Stream<InvoiceShipmentIdRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => InvoiceShipmentIdRecord.fromSnapshot(s));

  static Future<InvoiceShipmentIdRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => InvoiceShipmentIdRecord.fromSnapshot(s));

  static InvoiceShipmentIdRecord fromSnapshot(DocumentSnapshot snapshot) =>
      InvoiceShipmentIdRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static InvoiceShipmentIdRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      InvoiceShipmentIdRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'InvoiceShipmentIdRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is InvoiceShipmentIdRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createInvoiceShipmentIdRecordData({
  DocumentReference? orderRef,
  DocumentReference? designerRef,
  String? shipmentId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'order_ref': orderRef,
      'designer_ref': designerRef,
      'shipment_id': shipmentId,
    }.withoutNulls,
  );

  return firestoreData;
}

class InvoiceShipmentIdRecordDocumentEquality
    implements Equality<InvoiceShipmentIdRecord> {
  const InvoiceShipmentIdRecordDocumentEquality();

  @override
  bool equals(InvoiceShipmentIdRecord? e1, InvoiceShipmentIdRecord? e2) {
    return e1?.orderRef == e2?.orderRef &&
        e1?.designerRef == e2?.designerRef &&
        e1?.shipmentId == e2?.shipmentId;
  }

  @override
  int hash(InvoiceShipmentIdRecord? e) =>
      const ListEquality().hash([e?.orderRef, e?.designerRef, e?.shipmentId]);

  @override
  bool isValidKey(Object? o) => o is InvoiceShipmentIdRecord;
}
