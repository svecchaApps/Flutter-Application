import '../database.dart';

class UsersTable extends SupabaseTable<UsersRow> {
  @override
  String get tableName => 'users';

  @override
  UsersRow createRow(Map<String, dynamic> data) => UsersRow(data);
}

class UsersRow extends SupabaseDataRow {
  UsersRow(super.data);

  @override
  SupabaseTable get table => UsersTable();

  int get userId => getField<int>('user_id')!;
  set userId(int value) => setField<int>('user_id', value);

  String get userName => getField<String>('user_name')!;
  set userName(String value) => setField<String>('user_name', value);

  String get phoneNumber => getField<String>('phone_number')!;
  set phoneNumber(String value) => setField<String>('phone_number', value);

  String get address => getField<String>('address')!;
  set address(String value) => setField<String>('address', value);

  String? get email => getField<String>('email');
  set email(String? value) => setField<String>('email', value);

  String? get ids => getField<String>('ids');
  set ids(String? value) => setField<String>('ids', value);

  String? get adressfield2 => getField<String>('adressfield2');
  set adressfield2(String? value) => setField<String>('adressfield2', value);

  String? get addressfield3 => getField<String>('addressfield3');
  set addressfield3(String? value) => setField<String>('addressfield3', value);
}
