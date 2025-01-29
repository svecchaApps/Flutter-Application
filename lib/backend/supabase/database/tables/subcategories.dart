import '../database.dart';

class SubcategoriesTable extends SupabaseTable<SubcategoriesRow> {
  @override
  String get tableName => 'subcategories';

  @override
  SubcategoriesRow createRow(Map<String, dynamic> data) =>
      SubcategoriesRow(data);
}

class SubcategoriesRow extends SupabaseDataRow {
  SubcategoriesRow(super.data);

  @override
  SupabaseTable get table => SubcategoriesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int? get categoryId => getField<int>('category_id');
  set categoryId(int? value) => setField<int>('category_id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get image => getField<String>('image');
  set image(String? value) => setField<String>('image', value);
}
