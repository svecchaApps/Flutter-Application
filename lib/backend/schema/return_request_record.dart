import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ReturnRequestRecord extends FirestoreRecord {
  ReturnRequestRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "customer_name" field.
  DocumentReference? _customerName;
  DocumentReference? get customerName => _customerName;
  bool hasCustomerName() => _customerName != null;

  // "product_ref" field.
  DocumentReference? _productRef;
  DocumentReference? get productRef => _productRef;
  bool hasProductRef() => _productRef != null;

  // "designer_ref" field.
  DocumentReference? _designerRef;
  DocumentReference? get designerRef => _designerRef;
  bool hasDesignerRef() => _designerRef != null;

  // "order_ref" field.
  DocumentReference? _orderRef;
  DocumentReference? get orderRef => _orderRef;
  bool hasOrderRef() => _orderRef != null;

  // "return_reason" field.
  String? _returnReason;
  String get returnReason => _returnReason ?? '';
  bool hasReturnReason() => _returnReason != null;

  // "retur_comments" field.
  String? _returComments;
  String get returComments => _returComments ?? '';
  bool hasReturComments() => _returComments != null;

  // "actions" field.
  String? _actions;
  String get actions => _actions ?? '';
  bool hasActions() => _actions != null;

  // "subproduct_ref" field.
  DocumentReference? _subproductRef;
  DocumentReference? get subproductRef => _subproductRef;
  bool hasSubproductRef() => _subproductRef != null;

  void _initializeFields() {
    _customerName = snapshotData['customer_name'] as DocumentReference?;
    _productRef = snapshotData['product_ref'] as DocumentReference?;
    _designerRef = snapshotData['designer_ref'] as DocumentReference?;
    _orderRef = snapshotData['order_ref'] as DocumentReference?;
    _returnReason = snapshotData['return_reason'] as String?;
    _returComments = snapshotData['retur_comments'] as String?;
    _actions = snapshotData['actions'] as String?;
    _subproductRef = snapshotData['subproduct_ref'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Return_request');

  static Stream<ReturnRequestRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ReturnRequestRecord.fromSnapshot(s));

  static Future<ReturnRequestRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ReturnRequestRecord.fromSnapshot(s));

  static ReturnRequestRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ReturnRequestRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ReturnRequestRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ReturnRequestRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ReturnRequestRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ReturnRequestRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createReturnRequestRecordData({
  DocumentReference? customerName,
  DocumentReference? productRef,
  DocumentReference? designerRef,
  DocumentReference? orderRef,
  String? returnReason,
  String? returComments,
  String? actions,
  DocumentReference? subproductRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'customer_name': customerName,
      'product_ref': productRef,
      'designer_ref': designerRef,
      'order_ref': orderRef,
      'return_reason': returnReason,
      'retur_comments': returComments,
      'actions': actions,
      'subproduct_ref': subproductRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class ReturnRequestRecordDocumentEquality
    implements Equality<ReturnRequestRecord> {
  const ReturnRequestRecordDocumentEquality();

  @override
  bool equals(ReturnRequestRecord? e1, ReturnRequestRecord? e2) {
    return e1?.customerName == e2?.customerName &&
        e1?.productRef == e2?.productRef &&
        e1?.designerRef == e2?.designerRef &&
        e1?.orderRef == e2?.orderRef &&
        e1?.returnReason == e2?.returnReason &&
        e1?.returComments == e2?.returComments &&
        e1?.actions == e2?.actions &&
        e1?.subproductRef == e2?.subproductRef;
  }

  @override
  int hash(ReturnRequestRecord? e) => const ListEquality().hash([
        e?.customerName,
        e?.productRef,
        e?.designerRef,
        e?.orderRef,
        e?.returnReason,
        e?.returComments,
        e?.actions,
        e?.subproductRef
      ]);

  @override
  bool isValidKey(Object? o) => o is ReturnRequestRecord;
}
