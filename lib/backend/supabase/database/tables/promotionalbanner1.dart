import '../database.dart';

class Promotionalbanner1Table extends SupabaseTable<Promotionalbanner1Row> {
  @override
  String get tableName => 'promotionalbanner1';

  @override
  Promotionalbanner1Row createRow(Map<String, dynamic> data) =>
      Promotionalbanner1Row(data);
}

class Promotionalbanner1Row extends SupabaseDataRow {
  Promotionalbanner1Row(super.data);

  @override
  SupabaseTable get table => Promotionalbanner1Table();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get imageUrl => getField<String>('image_url');
  set imageUrl(String? value) => setField<String>('image_url', value);
}
