import '../database.dart';

class Banners1homeTable extends SupabaseTable<Banners1homeRow> {
  @override
  String get tableName => 'banners1home';

  @override
  Banners1homeRow createRow(Map<String, dynamic> data) => Banners1homeRow(data);
}

class Banners1homeRow extends SupabaseDataRow {
  Banners1homeRow(super.data);

  @override
  SupabaseTable get table => Banners1homeTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get imageUrl => getField<String>('image_url');
  set imageUrl(String? value) => setField<String>('image_url', value);
}
