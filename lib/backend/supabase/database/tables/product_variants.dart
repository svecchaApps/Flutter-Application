import '../database.dart';

class ProductVariantsTable extends SupabaseTable<ProductVariantsRow> {
  @override
  String get tableName => 'product_variants';

  @override
  ProductVariantsRow createRow(Map<String, dynamic> data) =>
      ProductVariantsRow(data);
}

class ProductVariantsRow extends SupabaseDataRow {
  ProductVariantsRow(super.data);

  @override
  SupabaseTable get table => ProductVariantsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int? get productId => getField<int>('product_id');
  set productId(int? value) => setField<int>('product_id', value);

  String? get size => getField<String>('size');
  set size(String? value) => setField<String>('size', value);

  double? get price => getField<double>('price');
  set price(double? value) => setField<double>('price', value);
}
