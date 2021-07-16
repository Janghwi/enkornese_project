import 'package:flutter/material.dart';
import 'package:google_sheets_update_example/api/sheets/menus_fetch_api.dart';
import 'package:google_sheets_update_example/api/sheets/phrases_fetch_api.dart';
import 'package:google_sheets_update_example/model/menu.dart';
import 'package:google_sheets_update_example/model/phrase.dart';
import 'package:google_sheets_update_example/page/phrase_page.dart';
import '/api/sheets/phrases_fetch_api.dart';
import '../model/phrase.dart';
import 'menu_page.dart';
import '1menuonelevel_page.dart';

import 'phrase_page.dart';

class MenuTwolevelPage1 extends StatelessWidget {
  final secondmenus;

  const MenuTwolevelPage1({
    Key? key,
    required this.secondmenus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(secondmenus.eng),
        ),
        body: FutureBuilder<List<Menu>>(
          future: MenusFetchApi.fetchMenus1(),
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
