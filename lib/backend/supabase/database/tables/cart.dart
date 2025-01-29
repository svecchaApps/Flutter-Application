import '../database.dart';

class CartTable extends SupabaseTable<CartRow> {
  @override
  String get tableName => 'cart';

  @override
  CartRow createRow(Map<String, dynamic> data) => CartRow(data);
}

class CartRow extends SupabaseDataRow {
  CartRow(super.data);

  @override
  SupabaseTable get table => CartTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get itemName => getField<String>('item_name');
  set itemName(String? value) => setField<String>('item_name', value);

  int? get itemPrice => getField<int>('item price');
  set itemPrice(int? value) => setField<int>('item price', value);

  int? get quantity => getField<int>('quantity');
  set quantity(int? value) => setField<int>('quantity', value);

  String? get image => getField<String>('image');
  set image(String? value) => setField<String>('image', value);

  String? get size => getField<String>('size');
  set size(String? value) => setField<String>('size', value);

  double? get price => getField<double>('price');
  set price(double? value) => setField<double>('price', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);
}
