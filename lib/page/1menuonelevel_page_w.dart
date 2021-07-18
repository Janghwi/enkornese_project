import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_sheets_update_example/api/sheets/menus_fetch_api.dart';
import 'package:google_sheets_update_example/controller/langcontroller.dart';
import 'package:google_sheets_update_example/model/menu.dart';
import '/api/sheets/menus_fetch_api.dart';
import '../model/menu.dart';
import '2menutwolevel_page2.dart';
import '2menutwolevel_page_p.dart';
import 'package:http/http.dart' as http;

class MenuOnelevelPageW extends StatelessWidget {
  const MenuOnelevelPageW({
    Key? key,
  }) : super(key: key);

  Future<List<Menu>> _fetchMenus() async {
    final url = Uri.parse(
      //'http://gsx2json.com/api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=4&display=all&columns=false',
      //'https://gsx2json.com/api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=4&selection=선택947&columns=false',
      //'https://gsx2json.com/api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=8&situation=$selection&columns=false',
      //'https://gsx2json.com/api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=3&selection=인사&columns=false',
      //'https://immense-depths-63197.herokuapp.com//api?id=1uBvyfmwv8LsuAbp87voiXmQYSchk4p1BlqIMxGtzSfg&sheet=3&columns=false&catid=secondmenus.catid',
      "https://immense-depths-63197.herokuapp.com/api?id=1i11vzA9wgOIeizHoX24Y5WqJAI-yj6d2FvtVgWXFq1Y&sheet=1&columns=false&cat1=1",
    );

    final response = await http.get(url);

    final body =
        json.decode(response.body)['rows'].cast<Map<String, dynamic>>();
    print(response.body);

    return body.map<Menu>(Menu.fromJson).toList();

    //return body.map<User>(User.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Menu>>(
        future: _fetchMenus(),
        builder: (context, snapshot) {
          final menus = snapshot.data;
          print(menus);

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Center(child: Text('Some error occurred!'));
              } else {
                return buildMenus(menus!);
              }
          }
        },
      ),
    );
  }

  Widget buildMenus(List<Menu> menus) => StaggeredGridView.countBuilder(
        staggeredTileBuilder: (index) => index % 7 == 0
            ? StaggeredTile.count(2, 2)
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
              // onTap: () => Navigator.of(context).push(MaterialPageRoute(
              //   builder: (BuildContext context) => MenuTwolevelPage1(
              //     passparam: menusOut.catid,
              //   ),
              onTap: () {
                Get.to(MenuTwolevelPage(),
                    arguments: [menusOut.catid, menusOut.eng],
                    transition: Transition.zoom);
              },

              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade600, Colors.blue.shade200],
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
                          style: TextStyle(fontSize: 20, color: Colors.white),
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
