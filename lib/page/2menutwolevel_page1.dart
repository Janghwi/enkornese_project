import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_sheets_update_example/api/sheets/menus_fetch_api.dart';
import 'package:google_sheets_update_example/api/sheets/phrases_fetch_api.dart';
import 'package:google_sheets_update_example/model/menu.dart';
import 'package:google_sheets_update_example/model/phrase.dart';
import 'package:google_sheets_update_example/page/phrase_page.dart';
import '/api/sheets/phrases_fetch_api.dart';
import '../model/phrase.dart';
import 'menu_page.dart';
import 'package:http/http.dart' as http;

import '1menuonelevel_page.dart';

import 'phrase_page.dart';

class MenuTwolevelPage1 extends StatelessWidget {
  final passparam;

  const MenuTwolevelPage1({
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

  Widget buildUsers(List<Menu> menus) => StaggeredGridView.countBuilder(
        staggeredTileBuilder: (index) => index % 7 == 0
            ? StaggeredTile.count(2, 1)
            : StaggeredTile.count(1, 1),
        physics: BouncingScrollPhysics(),
        itemCount: menus.length,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        crossAxisCount: 3,
        itemBuilder: (context, index) {
          final menusOut = menus[index];

          return Card(
            color: Colors.black54,
            shadowColor: Colors.grey,
            elevation: 8,
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => PhrasePage(
                    passparam: menusOut.catid,
                  ),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.lime, Colors.lime.shade200],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          menusOut.eng,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(menusOut.url),
                          radius: 20,
                        ),
                        // Text(
                        //   menusOut.kor,
                        //   style: TextStyle(fontSize: 20, color: Colors.white),
                        // ),
                        // Text(
                        //   menusOut.jap,
                        //   style: TextStyle(fontSize: 20, color: Colors.white),
                        // ),
                      ],
                    )),
              ),
            ),
          );
        },
      );
}
