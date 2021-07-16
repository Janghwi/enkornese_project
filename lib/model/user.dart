import 'dart:convert';

class UserFields {
  static final String id = 'id';
  static final String catid = 'catid';
  static final String name = 'name';
  static final String email = 'email';
  static final String url = 'url';
  static final String selection = 'selection';
  static final String selection1 = 'selection1';
  //static final String url = 'https://picsum.photos/id/237/200/300';

  static List<String> getFields() =>
      [id, catid, name, email, url, selection, selection1];
}

class User {
  final int? id;
  final String? catid;
  final String name;
  final String email;
  //final bool isBeginner;
  final String url;
  final String selection;
  final String selection1;

  const User({
    this.id,
    required this.catid,
    required this.name,
    required this.email,
    required this.url,
    required this.selection,
    required this.selection1,
  });

  User copy({
    int? id,
    String? catid,
    String? name,
    String? email,
    bool? isBeginner,
    String? url,
    String? selection,
    String? selection1,
  }) =>
      User(
        id: id ?? this.id,
        catid: catid ?? this.catid,
        name: name ?? this.name,
        email: email ?? this.email,
        //isBeginner: isBeginner ?? this.isBeginner,
        url: url ?? this.url,
        selection: selection ?? this.selection,
        selection1: selection1 ?? this.selection1,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        id: jsonDecode(json[UserFields.id].toString()),
        catid: json[UserFields.catid],
        name: json[UserFields.name],
        email: json[UserFields.email],
        url: json[UserFields.url],
        selection: json[UserFields.selection],
        selection1: json[UserFields.selection1],
      );

  Map<String, dynamic> toJson() => {
        UserFields.id: id,
        UserFields.catid: catid,
        UserFields.name: name,
        UserFields.email: email,
        UserFields.url: url,
        UserFields.selection: selection,
        UserFields.selection1: selection1,
      };
}
