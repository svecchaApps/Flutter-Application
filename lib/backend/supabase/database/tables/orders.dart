import '../database.dart';

class OrdersTable extends SupabaseTable<OrdersRow> {
  @override
  String get tableName => 'orders';

  @override
  OrdersRow createRow(Map<String, dynamic> data) => OrdersRow(data);
}

class OrdersRow extends SupabaseDataRow {
  OrdersRow(super.data);

  @override
  SupabaseTable get table => OrdersTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get userid => getField<String>('userid');
  set userid(String? value) => setField<String>('userid', value);

  String? get totalAmount => getField<String>('total_amount');
  set totalAmount(String? value) => setField<String>('total_amount', value);

  String? get address => getField<String>('address');
  set address(String? value) => setField<String>('address', value);

  List<String> get products => getListField<String>('products');
  set products(List<String>? value) => setListField<String>('products', value);

  List<String> get quantities => getListField<String>('quantities');
  set quantities(List<String>? value) =>
      setListField<String>('quantities', value);

  String? get customerName => getField<String>('customer_name');
  set customerName(String? value) => setField<String>('customer_name', value);

  String? get orderNumber => getField<String>('order_number');
  set orderNumber(String? value) => setField<String>('order_number', value);
}
