import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sheets_update_example/model/phrase.dart';
import '/model/user.dart';
import 'package:http/http.dart' as http;

class PhrasesFetchApi {
  static Future<List<Phrase>> fetchPhrases() async {
    var selection = "greetings";

    final url = Uri.parse(
      //'http://gsx2json.com/api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=4&display=all&columns=false',
      //'https://gsx2json.com/api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=4&selection=선택947&columns=false',
      //'https://gsx2json.com/api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=8&situation=$selection&columns=false',
      //'https://gsx2json.com/api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=3&selection=인사&columns=false',
      //'https://immense-depths-63197.herokuapp.com/api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=9&columns=false&catid=1',
      'https://gsstojson.herokuapp.com/api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=9&columns=false&catid=1',
    );
    final response = await http.get(url);

    final body =
        json.decode(response.body)['rows'].cast<Map<String, dynamic>>();
    //print(response.body);

    return body.map<Phrase>(Phrase.fromJson).toList();

    //return body.map<User>(User.fromJson).toList();
  }

  static Future<List<User>> getUsersLocally(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('assets/users.json');
    final body = json.decode(data);

    return body.map<User>(User.fromJson).toList();
  }
}
