import 'dart:convert';

class PhraseFields {
  static final String id = 'id';
  static final String catid = 'catid';
  static final String eng = 'eng';
  static final String engc = 'engc';
  static final String kor = 'kor';
  static final String korc = 'korc';
  static final String korprn = 'korprn';
  static final String korprnc = 'korprnc';
  static final String jap = 'jap';
  static final String japc = 'japc';
  static final String japprn = 'japprn';
  static final String japprnc = 'japprnc';
  static final String level = 'level';
  static final String cat = 'cat';
  static final String st = 'st';
  static final String stk = 'stk';
  static final String stj = 'stj';
  static final String place = 'place';
  static final String isq = 'isq ';
  static final String qtp = 'qtp';
  static final String isall = 'isall';
  static final String date = 'date';
  //static final String url = 'https://picsum.photos/id/237/200/300';

  static Future<List<String>> getFields() async => [
        id,
        catid,
        eng,
        engc,
        kor,
        korc,
        korprn,
        jap,
        japc,
        japprn,
        level,
        cat,
        st,
        stk,
        stj,
        place,
        isq,
        qtp,
        isall,
        date
      ];
}

class Phrase {
  final int? id;
  final int? catid;
  final String eng;
  final String engc;
  final String kor;
  final String korc;
  final String korprn;
  final String korprnc;
  final String jap;
  final String japc;
  final String japprn;
  final String japprnc;
  final String level;
  final String cat;
  final String st;
  final String stk;
  final String stj;
  final String place;
  final String isq;
  final String qtp;
  final String isall;
  final String date;

  const Phrase({
    this.id,
    this.catid,
    required this.eng,
    required this.engc,
    required this.kor,
    required this.korc,
    required this.korprn,
    required this.korprnc,
    required this.jap,
    required this.japc,
    required this.japprn,
    required this.japprnc,
    required this.level,
    required this.cat,
    required this.st,
    required this.stk,
    required this.stj,
    required this.place,
    required this.isq,
    required this.qtp,
    required this.isall,
    required this.date,
  });

  Phrase copy({
    int? id,
    int? catid,
    String? eng,
    engc,
    kor,
    korc,
    korprn,
    korprnc,
    jap,
    japc,
    japprn,
    japprnc,
    level,
    cat,
    st,
    stk,
    stj,
    place,
    isq,
    qtp,
    isall,
    date,
  }) =>
      Phrase(
        id: id ?? this.id,
        catid: catid ?? this.catid,
        eng: eng ?? this.eng,
        engc: engc ?? this.engc,
        kor: kor ?? this.kor,
        korc: korc ?? this.korc,
        korprn: korprn ?? this.korprn,
        korprnc: korprnc ?? this.korprnc,
        jap: jap ?? this.jap,
        japc: japc ?? this.japc,
        japprn: japprn ?? this.japprn,
        japprnc: japprnc ?? this.japprnc,
        level: level ?? this.level,
        cat: cat ?? this.cat,
        st: st ?? this.st,
        stk: stk ?? this.stk,
        stj: stj ?? this.stj,
        place: place ?? this.place,
        isq: isq ?? this.isq,
        qtp: qtp ?? this.qtp,
        isall: isall ?? this.isall,
        date: date ?? this.date,
      );

  static Phrase fromJson(Map<String, dynamic> json) => Phrase(
        id: jsonDecode(json[PhraseFields.id].toString()),
        catid: jsonDecode(json[PhraseFields.catid].toString()),
        eng: json[PhraseFields.eng].toString(),
        engc: json[PhraseFields.engc].toString(),
        kor: json[PhraseFields.kor].toString(),
        korc: json[PhraseFields.korc].toString(),
        korprn: json[PhraseFields.korprn].toString(),
        korprnc: json[PhraseFields.korprnc].toString(),
        jap: json[PhraseFields.jap].toString(),
        japc: json[PhraseFields.japc].toString(),
        japprn: json[PhraseFields.japprn].toString(),
        japprnc: json[PhraseFields.japprnc].toString(),
        level: json[PhraseFields.level].toString(),
        cat: json[PhraseFields.cat].toString(),
        st: json[PhraseFields.st].toString(),
        stk: json[PhraseFields.stk].toString(),
        stj: json[PhraseFields.stj].toString(),
        place: json[PhraseFields.place].toString(),
        isq: json[PhraseFields.isq].toString(),
        qtp: json[PhraseFields.qtp].toString(),
        isall: json[PhraseFields.isall].toString(),
        date: json[PhraseFields.date].toString(),
      );
  //   eng, engc, kor,    korc, korprn, korprnc, jap, japc, japprn,japprnc, level, cat, st, stk, stj,place, isq ,qtp isall,date,
//
//
  Map<String, dynamic> toJson() => {
        PhraseFields.id: id,
        PhraseFields.catid: catid,
        PhraseFields.eng: eng,
        PhraseFields.engc: engc,
        PhraseFields.kor: kor,
        PhraseFields.korc: korc,
        PhraseFields.korprn: korprn,
        PhraseFields.korprnc: korprnc,
        PhraseFields.jap: jap,
        PhraseFields.japc: japc,
        PhraseFields.japprn: japprn,
        PhraseFields.japprnc: japprnc,
        PhraseFields.level: level,
        PhraseFields.cat: cat,
        PhraseFields.st: st,
        PhraseFields.stk: stk,
        PhraseFields.stj: stj,
        PhraseFields.place: place,
        PhraseFields.isq: isq,
        PhraseFields.qtp: qtp,
        PhraseFields.isall: isall,
        PhraseFields.date: date,
      };
}
