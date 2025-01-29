import '../database.dart';

class ProductsTable extends SupabaseTable<ProductsRow> {
  @override
  String get tableName => 'products';

  @override
  ProductsRow createRow(Map<String, dynamic> data) => ProductsRow(data);
}

class ProductsRow extends SupabaseDataRow {
  ProductsRow(super.data);

  @override
  SupabaseTable get table => ProductsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int? get subcategoryId => getField<int>('subcategory_id');
  set subcategoryId(int? value) => setField<int>('subcategory_id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get image => getField<String>('image');
  set image(String? value) => setField<String>('image', value);

  String? get size => getField<String>('size');
  set size(String? value) => setField<String>('size', value);

  int? get designerId => getField<int>('designer_id');
  set designerId(int? value) => setField<int>('designer_id', value);

  int? get price => getField<int>('Price');
  set price(int? value) => setField<int>('Price', value);

  int? get stock => getField<int>('stock');
  set stock(int? value) => setField<int>('stock', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);
}
