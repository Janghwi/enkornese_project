import 'package:google_sheets_update_example/model/user.dart';
import 'package:gsheets/gsheets.dart';

//여기에 우리가 엑세스하는 구글시트의 환경을 다 자정하고 준비한다.
class UserSheetsApi {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "gsheets-317105",
  "private_key_id": "52f98e63522ddb21957a0950fe24f3abeed72b39",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDFDW/JQft5kdlM\nmk1I48rbFKIjnthXVmNjRy14giiXOS7Y3xIuSXgQFAk5HnOzdVbF2lJ/cWORIePF\nwfwWHpGt8ymjl/6FjVz5bQV6lz3b4IwCDRFsGmLGHxCjFIBpiCKkrkEVKBlXG0sr\nx/5aIkzzn1xNqXfHC/BUv1i3hgVscklpIKWxbWwS59MI6TyBYXQqDSaqtNSnEAyo\nwyH9HBplsHmHlWPXoJ+gs9UWhJxvLeoSoVVHzG7IZBnr9J91hCKPXc2gKoJ2OBc6\nOJCob4VAvk8aNcskP5JRaYtUymTni6GfB4SNW7js8bRghYiBFL4NQ0imz+kjo8kG\nItSc4ntFAgMBAAECggEAMBmrD2AVYCQLfIjv05qTMm4zc+l62rriMOI3hcKT4PIa\n7uJo4Dab4aTaaYB28rfyUgKMf8JwcQVqQaQsAkQ9AE6qe94GyZfruZD0tOuFNI53\n7qo89fvs33rGx2AiRmBuQG+uwFjU8q/dZhcADgVwbkmYsPZsoABYjn9UyxuiaEmB\nxnr9z5InI8I9gCqROrDpOXIs2qbVcBU7Ko9dGd5IKUEG31Onq1qrkBI9H6e5BV0Z\nUkzDOhbZX4fP/3T77oSGTCydR33NEYeMpUoE+vpNKtr+reOE/QzpiKwJHIbXA7oX\nGFSpcZeOxbk0xgTU/2PHFFXYXrldYsAGHfySoQ4a0wKBgQDqCTtcbUitzwTZjT7l\nnKSuva5JqxXTZTjT6KpNJys8qsqwaxZem1OcBvXZwOUNJMEHJpM2YKC3Ft+EcyKE\nrU8oJ8GpbMQGnvIRkHjSgaOlFSz7nxTiTudY7rgTFZPVWr3it3gJ3/ayd7wP0SW0\n32IG0RZP46kFsnnFTVJvDTaQ9wKBgQDXi6qNZ2GxgS2ZGfwrfZdNfKOCWumRL1z1\nZjHI4tlJNdVz+OwT2otMEGNI1AmY9HEl6w28eVgqQ+fjDka/pdWS/k6P4UIZ4mKn\n4g0YNKZpV1LsfaE4MlhBO8AC7n1CVj3Sc+4nUwEl1ZGmNGgLMFLw+GPpvB+AZIoi\nvA88l7/CowKBgDC78WeCvkKrPDhNKE7J+qUEjJl8jdPyXQ4LggME6AT/D6wC8KqM\nr7Fq5aENgOTmxWdGyhrlrjHSCoNbMlHsgPI8rSAprPwv9vpfWjmDk18Z9L8E1mV1\nxskHFL+sm5cvCSF/0PhFceqh8kBc7fwnFBOVUI8cOiMckizauBK17qnrAoGAT28R\nM3td7WSFwV5qKDzofY3pVCjc2rxxrZ4zyqyPFwPX3h1mIwrvOuDvNe+uecfbyvWM\n4mB1tV3BH1QrjoU26C0AFtYU3iUn5mbQHJOKoFemH7FMsMEc9S1n3ay2TLQrpFtE\n8QkN6zuBqZa2oSj16AgiCgliMpbasWJM2y+xY7ECgYBt1Gox69L7FtvdciQX2luc\nKcPRjbuF2pBaOPQ0m4nIP8CFd8m6kcwrj5OYmZYnWMTqmZ1/ADeQHToeSZpecxVa\nsJqwF4IKNiWG5c1dPN/sQW+at1AcWKV1b6xLzkkh54lZZDYQbNpQwpyDLWmjG+b2\nXFsP3KZf/lueX3AlSnDarA==\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-317105.iam.gserviceaccount.com",
  "client_id": "107180907498839207464",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-317105.iam.gserviceaccount.com"
}
''';
  static final _spreadsheetId = '1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;
  //static변수는 정적변수인데 호출전까지는 초기화 되지 않음

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: '4Users');
      //users는 sheet명임

      final firstRow = UserFields.getFields();
      _userSheet!.values.insertRow(1, firstRow);
      //users에서 첫번째 행에 값이 없으면 첫번째 row 값을 넣어라, 1이 row값이다
    } catch (e) {
      print('Init Error: $e');
    }
  }

  //future는 await를 만나면 실행된다.awiat가 실행된 후에 future객체를 반환한다.
  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title); //없으면 시트를 만든다
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<int> getRowCount() async {
    if (_userSheet == null) return 0;

    final lastRow = await _userSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  //읽는 코드
  static Future<List<User>> getAll() async {
    if (_userSheet == null) return <User>[];

    final users = await _userSheet!.values.map.allRows();
    return users == null ? <User>[] : users.map(User.fromJson).toList();
  }

  static Future<User?> getById(int id) async {
    if (_userSheet == null) return null;

    final json = await _userSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : User.fromJson(json);
  }

  //저장하는 코드
  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_userSheet == null) return;

    _userSheet!.values.map.appendRows(rowList);
  }

  static Future<bool> update(
    int id,
    Map<String, dynamic> user,
  ) async {
    if (_userSheet == null) return false;

    return _userSheet!.values.map.insertRowByKey(id, user);
  }

  static Future<bool> updateCell({
    required int id,
    required String key,
    required dynamic value,
  }) async {
    if (_userSheet == null) return false;

    return _userSheet!.values.insertValueByKeys(
      value,
      columnKey: key,
      rowKey: id,
    );
  }

//삭제하는 코드
  static Future<bool> deleteById(int id) async {
    if (_userSheet == null) return false;

    final index = await _userSheet!.values.rowIndexOf(id);
    if (index == -1) return false;

    return _userSheet!.deleteRow(index);
  }
}

//----------------------------------------------------------------------------
class UserSheetsApi1 {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "gsheets-317105",
  "private_key_id": "52f98e63522ddb21957a0950fe24f3abeed72b39",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDFDW/JQft5kdlM\nmk1I48rbFKIjnthXVmNjRy14giiXOS7Y3xIuSXgQFAk5HnOzdVbF2lJ/cWORIePF\nwfwWHpGt8ymjl/6FjVz5bQV6lz3b4IwCDRFsGmLGHxCjFIBpiCKkrkEVKBlXG0sr\nx/5aIkzzn1xNqXfHC/BUv1i3hgVscklpIKWxbWwS59MI6TyBYXQqDSaqtNSnEAyo\nwyH9HBplsHmHlWPXoJ+gs9UWhJxvLeoSoVVHzG7IZBnr9J91hCKPXc2gKoJ2OBc6\nOJCob4VAvk8aNcskP5JRaYtUymTni6GfB4SNW7js8bRghYiBFL4NQ0imz+kjo8kG\nItSc4ntFAgMBAAECggEAMBmrD2AVYCQLfIjv05qTMm4zc+l62rriMOI3hcKT4PIa\n7uJo4Dab4aTaaYB28rfyUgKMf8JwcQVqQaQsAkQ9AE6qe94GyZfruZD0tOuFNI53\n7qo89fvs33rGx2AiRmBuQG+uwFjU8q/dZhcADgVwbkmYsPZsoABYjn9UyxuiaEmB\nxnr9z5InI8I9gCqROrDpOXIs2qbVcBU7Ko9dGd5IKUEG31Onq1qrkBI9H6e5BV0Z\nUkzDOhbZX4fP/3T77oSGTCydR33NEYeMpUoE+vpNKtr+reOE/QzpiKwJHIbXA7oX\nGFSpcZeOxbk0xgTU/2PHFFXYXrldYsAGHfySoQ4a0wKBgQDqCTtcbUitzwTZjT7l\nnKSuva5JqxXTZTjT6KpNJys8qsqwaxZem1OcBvXZwOUNJMEHJpM2YKC3Ft+EcyKE\nrU8oJ8GpbMQGnvIRkHjSgaOlFSz7nxTiTudY7rgTFZPVWr3it3gJ3/ayd7wP0SW0\n32IG0RZP46kFsnnFTVJvDTaQ9wKBgQDXi6qNZ2GxgS2ZGfwrfZdNfKOCWumRL1z1\nZjHI4tlJNdVz+OwT2otMEGNI1AmY9HEl6w28eVgqQ+fjDka/pdWS/k6P4UIZ4mKn\n4g0YNKZpV1LsfaE4MlhBO8AC7n1CVj3Sc+4nUwEl1ZGmNGgLMFLw+GPpvB+AZIoi\nvA88l7/CowKBgDC78WeCvkKrPDhNKE7J+qUEjJl8jdPyXQ4LggME6AT/D6wC8KqM\nr7Fq5aENgOTmxWdGyhrlrjHSCoNbMlHsgPI8rSAprPwv9vpfWjmDk18Z9L8E1mV1\nxskHFL+sm5cvCSF/0PhFceqh8kBc7fwnFBOVUI8cOiMckizauBK17qnrAoGAT28R\nM3td7WSFwV5qKDzofY3pVCjc2rxxrZ4zyqyPFwPX3h1mIwrvOuDvNe+uecfbyvWM\n4mB1tV3BH1QrjoU26C0AFtYU3iUn5mbQHJOKoFemH7FMsMEc9S1n3ay2TLQrpFtE\n8QkN6zuBqZa2oSj16AgiCgliMpbasWJM2y+xY7ECgYBt1Gox69L7FtvdciQX2luc\nKcPRjbuF2pBaOPQ0m4nIP8CFd8m6kcwrj5OYmZYnWMTqmZ1/ADeQHToeSZpecxVa\nsJqwF4IKNiWG5c1dPN/sQW+at1AcWKV1b6xLzkkh54lZZDYQbNpQwpyDLWmjG+b2\nXFsP3KZf/lueX3AlSnDarA==\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-317105.iam.gserviceaccount.com",
  "client_id": "107180907498839207464",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-317105.iam.gserviceaccount.com"
}
''';
  static final _spreadsheetId = '1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;
  //static변수는 정적변수인데 호출전까지는 초기화 되지 않음

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'settings');
      //users는 sheet명임

      final firstRow = UserFields.getFields();
      _userSheet!.values.insertRow(1, firstRow);
      //users에서 첫번째 행에 값이 없으면 첫번째 row 값을 넣어라, 1이 row값이다
    } catch (e) {
      print('Init Error: $e');
    }
  }

  //future는 await를 만나면 실행된다.awiat가 실행된 후에 future객체를 반환한다.
  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title); //없으면 시트를 만든다
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<int> getRowCount() async {
    if (_userSheet == null) return 0;

    final lastRow = await _userSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  //읽는 코드
  static Future<List<User>> getAll() async {
    if (_userSheet == null) return <User>[];

    final users = await _userSheet!.values.map.allRows();
    return users == null ? <User>[] : users.map(User.fromJson).toList();
  }

  static Future<User?> getById(int id) async {
    if (_userSheet == null) return null;

    final json = await _userSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : User.fromJson(json);
  }

  //저장하는 코드
  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_userSheet == null) return;

    _userSheet!.values.map.appendRows(rowList);
  }

  static Future<bool> update(
    int id,
    Map<String, dynamic> user,
  ) async {
    if (_userSheet == null) return false;

    return _userSheet!.values.map.insertRowByKey(id, user);
  }

  static Future<bool> updateCell({
    required int id,
    required String key,
    required dynamic value,
  }) async {
    if (_userSheet == null) return false;

    return _userSheet!.values.insertValueByKeys(
      value,
      columnKey: key,
      rowKey: id,
    );
  }

//삭제하는 코드
  static Future<bool> deleteById(int id) async {
    if (_userSheet == null) return false;

    final index = await _userSheet!.values.rowIndexOf(id);
    if (index == -1) return false;

    return _userSheet!.deleteRow(index);
  }
}
