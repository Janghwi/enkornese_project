import 'dart:convert';

class HtmlFields {
  static final String id = 'id';
  static final String catid = 'catid';
  static final String html = 'html';
  static final String date = 'date';
  //static final String url = 'https://picsum.photos/id/237/200/300';

  static Future<List<String>> getDatas() async => [id, catid, html, date];
}

class HtmlSrc {
  final int? id;
  final int? catid;
  final String html;
  final String date;

  const HtmlSrc({
    this.id,
    this.catid,
    required this.html,
    required this.date,
  });

  HtmlSrc copy({
    int? id,
    int? catid,
    String? html,
    date,
  }) =>
      HtmlSrc(
        id: id ?? this.id,
        catid: catid ?? this.catid,
        html: html ?? this.html,
        date: date ?? this.date,
      );

  static HtmlSrc fromJson(Map<String, dynamic> json) => HtmlSrc(
        id: jsonDecode(json[HtmlFields.id].toString()),
        catid: jsonDecode(json[HtmlFields.catid].toString()),
        html: json[HtmlFields.html].toString(),
        date: json[HtmlFields.date].toString(),
      );
  //   eng, engc, kor,    korc, korprn, korprnc, jap, japc, japprn,japprnc, level, cat1, st, stk, stj,place, isq ,qtp isall,date,
//
//
  Map<String, dynamic> toJson() => {
        HtmlFields.id: id,
        HtmlFields.catid: catid,
        HtmlFields.html: html,
        HtmlFields.date: date,
      };
}
