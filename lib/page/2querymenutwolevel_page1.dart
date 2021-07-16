import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sheets_update_example/api/sheets/menus_fetch_api.dart';
import 'package:google_sheets_update_example/api/sheets/phrases_fetch_api.dart';
import 'package:google_sheets_update_example/model/menu.dart';
import 'package:google_sheets_update_example/model/phrase.dart';
import 'package:google_sheets_update_example/page/phrase_page.dart';
import '/api/sheets/phrases_fetch_api.dart';
import '../model/phrase.dart';
import 'menu_page.dart';
import 'package:http/http.dart' as http;

import '1querymenuonelevel_page.dart';

import 'phrase_page.dart';

class QueryMenuTwolevelPage1 extends StatelessWidget {
  final passparam;

  const QueryMenuTwolevelPage1({
    Key? key,
    required this.passparam,
  }) : super(key: key);

  Future<List<Menu>> fetchMenus1() async {
    var catid = passparam;

    final url = Uri.parse(
      //'http://gsx2json.com/api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=4&display=all&columns=false',
      //'https://gsx2json.com/api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=4&selection=선택947&columns=false',
      //'https://gsx2json.com/api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=8&situation=$selection&columns=false',
      //'https://gsx2json.com/api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=3&selection=인사&columns=false',
      //'https://immense-depths-63197.herokuapp.com//api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=3&columns=false&catid=secondmenus.catid',
      'https://immense-depths-63197.herokuapp.com/api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=3&columns=false&catid=$catid',
    );
    print(url);
    final response = await http.get(url);

    final body =
        json.decode(response.body)['rows'].cast<Map<String, dynamic>>();
    print(response.body);

    return body.map<Menu>(Menu.fromJson).toList();

    //return body.map<User>(User.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            // title: Text(passparam.toString()),
            ),
        body: FutureBuilder<List<Menu>>(
          future: fetchMenus1(),
          builder: (context, snapshot) {
            final secondmenus = snapshot.data;

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Some error occurred!'));
                } else {
                  return buildUsers(secondmenus!);
                }
            }
          },
        ),
      );

  Widget buildUsers(List<Menu> menus) => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: menus.length,
        itemBuilder: (context, index) {
          final menusOut = menus[index];

          return ListTile(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => MenuPage(menu: menusOut),
            )),
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage('https://picsum.photos/id/237/200/300'),
            ),
            title: Text(menusOut.eng),
            subtitle: Text(menusOut.kor),
            trailing: Icon(Icons.keyboard_arrow_right),
          );
        },
      );
}
