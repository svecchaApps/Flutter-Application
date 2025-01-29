import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OrdersRecord extends FirestoreRecord {
  OrdersRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "userref" field.
  DocumentReference? _userref;
  DocumentReference? get userref => _userref;
  bool hasUserref() => _userref != null;

  // "total_amount" field.
  double? _totalAmount;
  double get totalAmount => _totalAmount ?? 0.0;
  bool hasTotalAmount() => _totalAmount != null;

  // "address" field.
  String? _address;
  String get address => _address ?? '';
  bool hasAddress() => _address != null;

  // "products" field.
  List<String>? _products;
  List<String> get products => _products ?? const [];
  bool hasProducts() => _products != null;

  // "quantities" field.
  List<String>? _quantities;
  List<String> get quantities => _quantities ?? const [];
  bool hasQuantities() => _quantities != null;

  // "customer_name" field.
  String? _customerName;
  String get customerName => _customerName ?? '';
  bool hasCustomerName() => _customerName != null;

  // "designer_ref" field.
  List<DocumentReference>? _designerRef;
  List<DocumentReference> get designerRef => _designerRef ?? const [];
  bool hasDesignerRef() => _designerRef != null;

  // "paymentmethod" field.
  String? _paymentmethod;
  String get paymentmethod => _paymentmethod ?? '';
  bool hasPaymentmethod() => _paymentmethod != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "productrefer" field.
  List<ProductordersStruct>? _productrefer;
  List<ProductordersStruct> get productrefer => _productrefer ?? const [];
  bool hasProductrefer() => _productrefer != null;

  // "createdat" field.
  DateTime? _createdat;
  DateTime? get createdat => _createdat;
  bool hasCreatedat() => _createdat != null;

  // "order_id" field.
  String? _orderId;
  String get orderId => _orderId ?? '';
  bool hasOrderId() => _orderId != null;

  // "is_return" field.
  bool? _isReturn;
  bool get isReturn => _isReturn ?? false;
  bool hasIsReturn() => _isReturn != null;

  // "custome_email" field.
  String? _customeEmail;
  String get customeEmail => _customeEmail ?? '';
  bool hasCustomeEmail() => _customeEmail != null;

  // "customer_city" field.
  String? _customerCity;
  String get customerCity => _customerCity ?? '';
  bool hasCustomerCity() => _customerCity != null;

  // "customer_state" field.
  String? _customerState;
  String get customerState => _customerState ?? '';
  bool hasCustomerState() => _customerState != null;

  // "customer_pincode" field.
  String? _customerPincode;
  String get customerPincode => _customerPincode ?? '';
  bool hasCustomerPincode() => _customerPincode != null;

  // "customer_phone" field.
  String? _customerPhone;
  String get customerPhone => _customerPhone ?? '';
  bool hasCustomerPhone() => _customerPhone != null;

  // "invoice_url" field.
  String? _invoiceUrl;
  String get invoiceUrl => _invoiceUrl ?? '';
  bool hasInvoiceUrl() => _invoiceUrl != null;

  // "subcategoryref" field.
  List<DocumentReference>? _subcategoryref;
  List<DocumentReference> get subcategoryref => _subcategoryref ?? const [];
  bool hasSubcategoryref() => _subcategoryref != null;

  void _initializeFields() {
    _userref = snapshotData['userref'] as DocumentReference?;
    _totalAmount = castToType<double>(snapshotData['total_amount']);
    _address = snapshotData['address'] as String?;
    _products = getDataList(snapshotData['products']);
    _quantities = getDataList(snapshotData['quantities']);
    _customerName = snapshotData['customer_name'] as String?;
    _designerRef = getDataList(snapshotData['designer_ref']);
    _paymentmethod = snapshotData['paymentmethod'] as String?;
    _status = snapshotData['status'] as String?;
    _productrefer = getStructList(
      snapshotData['productrefer'],
      ProductordersStruct.fromMap,
    );
    _createdat = snapshotData['createdat'] as DateTime?;
    _orderId = snapshotData['order_id'] as String?;
    _isReturn = snapshotData['is_return'] as bool?;
    _customeEmail = snapshotData['custome_email'] as String?;
    _customerCity = snapshotData['customer_city'] as String?;
    _customerState = snapshotData['customer_state'] as String?;
    _customerPincode = snapshotData['customer_pincode'] as String?;
    _customerPhone = snapshotData['customer_phone'] as String?;
    _invoiceUrl = snapshotData['invoice_url'] as String?;
    _subcategoryref = getDataList(snapshotData['subcategoryref']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('orders');

  static Stream<OrdersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => OrdersRecord.fromSnapshot(s));

  static Future<OrdersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => OrdersRecord.fromSnapshot(s));

  static OrdersRecord fromSnapshot(DocumentSnapshot snapshot) => OrdersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static OrdersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      OrdersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'OrdersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is OrdersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createOrdersRecordData({
  DocumentReference? userref,
  double? totalAmount,
  String? address,
  String? customerName,
  String? paymentmethod,
  String? status,
  DateTime? createdat,
  String? orderId,
  bool? isReturn,
  String? customeEmail,
  String? customerCity,
  String? customerState,
  String? customerPincode,
  String? customerPhone,
  String? invoiceUrl,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userref': userref,
      'total_amount': totalAmount,
      'address': address,
      'customer_name': customerName,
      'paymentmethod': paymentmethod,
      'status': status,
      'createdat': createdat,
      'order_id': orderId,
      'is_return': isReturn,
      'custome_email': customeEmail,
      'customer_city': customerCity,
      'customer_state': customerState,
      'customer_pincode': customerPincode,
      'customer_phone': customerPhone,
      'invoice_url': invoiceUrl,
    }.withoutNulls,
  );

  return firestoreData;
}

class OrdersRecordDocumentEquality implements Equality<OrdersRecord> {
  const OrdersRecordDocumentEquality();

  @override
  bool equals(OrdersRecord? e1, OrdersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.userref == e2?.userref &&
        e1?.totalAmount == e2?.totalAmount &&
        e1?.address == e2?.address &&
        listEquality.equals(e1?.products, e2?.products) &&
        listEquality.equals(e1?.quantities, e2?.quantities) &&
        e1?.customerName == e2?.customerName &&
        listEquality.equals(e1?.designerRef, e2?.designerRef) &&
        e1?.paymentmethod == e2?.paymentmethod &&
        e1?.status == e2?.status &&
        listEquality.equals(e1?.productrefer, e2?.productrefer) &&
        e1?.createdat == e2?.createdat &&
        e1?.orderId == e2?.orderId &&
        e1?.isReturn == e2?.isReturn &&
        e1?.customeEmail == e2?.customeEmail &&
        e1?.customerCity == e2?.customerCity &&
        e1?.customerState == e2?.customerState &&
        e1?.customerPincode == e2?.customerPincode &&
        e1?.customerPhone == e2?.customerPhone &&
        e1?.invoiceUrl == e2?.invoiceUrl &&
        listEquality.equals(e1?.subcategoryref, e2?.subcategoryref);
  }

  @override
  int hash(OrdersRecord? e) => const ListEquality().hash([
        e?.userref,
        e?.totalAmount,
        e?.address,
        e?.products,
        e?.quantities,
        e?.customerName,
        e?.designerRef,
        e?.paymentmethod,
        e?.status,
        e?.productrefer,
        e?.createdat,
        e?.orderId,
        e?.isReturn,
        e?.customeEmail,
        e?.customerCity,
        e?.customerState,
        e?.customerPincode,
        e?.customerPhone,
        e?.invoiceUrl,
        e?.subcategoryref
      ]);

  @override
  bool isValidKey(Object? o) => o is OrdersRecord;
}
