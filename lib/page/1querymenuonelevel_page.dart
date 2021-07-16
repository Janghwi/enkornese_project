import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_sheets_update_example/api/sheets/menus_fetch_api.dart';
import 'package:google_sheets_update_example/api/sheets/phrases_fetch_api.dart';
import 'package:google_sheets_update_example/model/menu.dart';
import 'package:google_sheets_update_example/model/phrase.dart';
import 'package:google_sheets_update_example/page/2querymenutwolevel_page.dart';
import 'package:google_sheets_update_example/page/phrase_page.dart';
import '/api/sheets/menus_fetch_api.dart';
import '../model/menu.dart';
import '2querymenutwolevel_page.dart';
import '2querymenutwolevel_page1.dart';

class QueryMenuOnelevelPage extends StatelessWidget {
  var menus;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: FutureBuilder<List<Menu>>(
          future: MenusFetchApi.fetchMenus(),
          builder: (context, snapshot) {
            final menus = snapshot.data;

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
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    QueryMenuTwolevelPage1(secondmenus: menusOut),
              )),
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
