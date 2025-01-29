import '../database.dart';

class DesignersTable extends SupabaseTable<DesignersRow> {
  @override
  String get tableName => 'designers';

  @override
  DesignersRow createRow(Map<String, dynamic> data) => DesignersRow(data);
}

class DesignersRow extends SupabaseDataRow {
  DesignersRow(super.data);

  @override
  SupabaseTable get table => DesignersTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get logoUrl => getField<String>('logo_url');
  set logoUrl(String? value) => setField<String>('logo_url', value);

  String? get background => getField<String>('background');
  set background(String? value) => setField<String>('background', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  String? get email => getField<String>('email');
  set email(String? value) => setField<String>('email', value);

  String? get phoneNumber => getField<String>('phone number');
  set phoneNumber(String? value) => setField<String>('phone number', value);

  String? get address => getField<String>('address');
  set address(String? value) => setField<String>('address', value);

  String? get isApproved => getField<String>('is_approved');
  set isApproved(String? value) => setField<String>('is_approved', value);
}
